using ErpBackEnd.Application.DTOs.Common;
using ErpBackEnd.Application.DTOs.Inventory;
using MediatR;

namespace ErpBackEnd.Application.Features.Inventory.Products.Queries.GetProductById;

/// <summary>
/// Query to get a product by its item number
/// </summary>
public record GetProductByIdQuery(string ItemNo) : IRequest<Result<ProductDetailDto>>;
