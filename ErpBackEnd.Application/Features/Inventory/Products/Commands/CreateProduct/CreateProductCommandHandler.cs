using ErpBackEnd.Application.DTOs.Common;
using ErpBackEnd.Domain.Entities.Inventory;
using ErpBackEnd.Domain.Interfaces;
using MediatR;

namespace ErpBackEnd.Application.Features.Inventory.Products.Commands.CreateProduct;

/// <summary>
/// Handler for CreateProductCommand
/// </summary>
public class CreateProductCommandHandler : IRequestHandler<CreateProductCommand, Result<string>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly ICurrentUserProvider _currentUserProvider;
    private readonly ITransactionLogService _transactionLog;

    public CreateProductCommandHandler(
        IUnitOfWork unitOfWork,
        ICurrentUserProvider currentUserProvider,
        ITransactionLogService transactionLog)
    {
        _unitOfWork = unitOfWork ?? throw new ArgumentNullException(nameof(unitOfWork));
        _currentUserProvider = currentUserProvider ?? throw new ArgumentNullException(nameof(currentUserProvider));
        _transactionLog = transactionLog ?? throw new ArgumentNullException(nameof(transactionLog));
    }

    public async Task<Result<string>> Handle(CreateProductCommand request, CancellationToken cancellationToken)
    {
        // Check if product already exists
        var exists = await _unitOfWork.Products.ItemNoExistsAsync(request.ItemNo, cancellationToken);
        if (exists)
        {
            return Result.Failure<string>(
                new Error("Product.Duplicate", $"Product with ItemNo '{request.ItemNo}' already exists"));
        }

        // Create product entity
        var product = new Product
        {
            ItemNo = request.ItemNo,
            NameEn = request.NameEn,
            NameAr = request.NameAr,
            MainGroup = request.MainGroup,
            SubGroup = request.SubGroup,
            Category = request.Category,
            ClassKey = request.ClassKey,
            CompanyCode = request.CompanyCode,
            SupplierCode = request.SupplierCode,
            BrandId = request.BrandId,
            ModelNo = request.ModelNo,
            ItemType = request.ItemType,
            IsTaxFree = request.IsTaxFree,
            AllowsExpiryDate = request.AllowsExpiryDate,
            Modified = true
        };

        try
        {
            // Begin transaction
            using var transaction = await _unitOfWork.BeginTransactionAsync();

            // Add product
            var itemNo = await _unitOfWork.Products.AddAsync(product, transaction, cancellationToken);

            // Log the transaction
            await _transactionLog.LogInsertAsync("stitems", itemNo, product, transaction, cancellationToken);

            // Commit transaction
            await _unitOfWork.CommitAsync();

            return Result.Success(itemNo);
        }
        catch (Exception ex)
        {
            await _unitOfWork.RollbackAsync();
            return Result.Failure<string>(
                new Error("Product.CreateFailed", $"Failed to create product: {ex.Message}"));
        }
    }
}
