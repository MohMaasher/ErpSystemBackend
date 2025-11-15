using ErpBackEnd.Application.DTOs.Common;
using ErpBackEnd.Application.DTOs.Inventory;
using ErpBackEnd.Domain.Interfaces;
using MediatR;

namespace ErpBackEnd.Application.Features.Inventory.Products.Queries.GetProductById;

/// <summary>
/// Handler for GetProductByIdQuery
/// </summary>
public class GetProductByIdQueryHandler : IRequestHandler<GetProductByIdQuery, Result<ProductDetailDto>>
{
    private readonly IUnitOfWork _unitOfWork;

    public GetProductByIdQueryHandler(IUnitOfWork unitOfWork)
    {
        _unitOfWork = unitOfWork ?? throw new ArgumentNullException(nameof(unitOfWork));
    }

    public async Task<Result<ProductDetailDto>> Handle(GetProductByIdQuery request, CancellationToken cancellationToken)
    {
        var product = await _unitOfWork.Products.GetWithDetailsAsync(request.ItemNo, cancellationToken);

        if (product == null)
        {
            return Result.Failure<ProductDetailDto>(
                new Error("Product.NotFound", $"Product with ItemNo '{request.ItemNo}' was not found"));
        }

        // Map to DTO
        var productDto = new ProductDetailDto
        {
            ItemNo = product.ItemNo,
            NameEn = product.NameEn,
            NameAr = product.NameAr,
            MainGroup = product.MainGroup,
            SubGroup = product.SubGroup,
            Category = product.Category,
            ClassKey = product.ClassKey,
            CompanyCode = product.CompanyCode,
            SupplierCode = product.SupplierCode,
            BrandId = product.BrandId,
            ModelNo = product.ModelNo,
            ItemType = product.ItemType,
            IsTaxFree = product.IsTaxFree,
            NoSales = product.NoSales,
            AllowsExpiryDate = product.AllowsExpiryDate,
            VATPrice = product.VATPrice,
            Units = product.ProductUnits?.Select(u => new ProductUnitDto
            {
                ItemNo = u.ItemNo,
                UnitCode = u.UnitCode,
                Name = u.Name,
                Barcode = u.Barcode,
                LocalCost = u.LocalCost,
                ForeignCost = u.ForeignCost,
                LocalPrice1 = u.LocalPrice1,
                LocalPrice2 = u.LocalPrice2 ?? 0,
                LocalPrice3 = u.LocalPrice3,
                MinimumPrice = u.MinimumPrice,
                MaxDiscount1 = u.MaxDiscount1,
                MaxDiscount2 = u.MaxDiscount2,
                MaxDiscount3 = u.MaxDiscount3,
                CurrentBalance = u.CurrentBalance,
                ReservedQuantity = u.ReservedQuantity,
                MinimumStock = u.MinimumStock,
                MaximumStock = u.MaximumStock,
                ReorderLevel = u.ReorderLevel,
                Pack1 = u.Pack1,
                PackQuantity1 = u.PackQuantity1,
                Pack2 = u.Pack2,
                PackQuantity2 = u.PackQuantity2,
                IsInactive = u.IsInactive,
                AllowDecimal = u.AllowDecimal
            }).ToList()
        };

        // Calculate total stock quantities
        if (productDto.Units != null && productDto.Units.Any())
        {
            productDto.TotalStockQuantity = productDto.Units.Sum(u => u.CurrentBalance ?? 0);
            productDto.TotalReservedQuantity = productDto.Units.Sum(u => u.ReservedQuantity ?? 0);
            productDto.TotalAvailableQuantity = productDto.TotalStockQuantity - productDto.TotalReservedQuantity;
        }

        return Result.Success(productDto);
    }
}
