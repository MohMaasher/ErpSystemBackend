using ErpBackEnd.Application.DTOs.Common;
using MediatR;

namespace ErpBackEnd.Application.Features.Inventory.Products.Commands.CreateProduct;

/// <summary>
/// Command to create a new product
/// </summary>
public record CreateProductCommand : IRequest<Result<string>>
{
    public string ItemNo { get; init; } = string.Empty;
    public string NameEn { get; init; } = string.Empty;
    public string NameAr { get; init; } = string.Empty;
    public string MainGroup { get; init; } = string.Empty;
    public string SubGroup { get; init; } = string.Empty;
    public string Category { get; init; } = string.Empty;
    public string ClassKey { get; init; } = string.Empty;
    public string CompanyCode { get; init; } = string.Empty;
    public string SupplierCode { get; init; } = string.Empty;
    public int BrandId { get; init; }
    public string? ModelNo { get; init; }
    public string ItemType { get; init; } = "S";
    public bool IsTaxFree { get; init; }
    public bool AllowsExpiryDate { get; init; }
}
