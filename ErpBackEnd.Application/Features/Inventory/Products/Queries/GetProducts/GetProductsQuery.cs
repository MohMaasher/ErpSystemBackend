using ErpBackEnd.Application.DTOs.Common;
using ErpBackEnd.Application.DTOs.Inventory;
using MediatR;

namespace ErpBackEnd.Application.Features.Inventory.Products.Queries.GetProducts;

/// <summary>
/// Query to get a paged list of products with optional search
/// </summary>
public record GetProductsQuery : PagedQuery, IRequest<Result<PagedResult<ProductListDto>>>
{
    public string? Category { get; set; }
    public string? SupplierCode { get; set; }
    public int? BrandId { get; set; }
    public bool? ActiveOnly { get; set; } = true;
}
