using ErpBackEnd.Application.DTOs.Common;
using ErpBackEnd.Application.DTOs.Inventory;
using ErpBackEnd.Application.Features.Inventory.Products.Commands.CreateProduct;
using ErpBackEnd.Application.Features.Inventory.Products.Commands.UpdateProduct;
using ErpBackEnd.Application.Features.Inventory.Products.Queries.GetProductById;
using ErpBackEnd.Application.Features.Inventory.Products.Queries.GetProducts;
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

namespace ErpBackEnd.API.Controllers.V1;

[ApiController]
[Route("api/v1/[controller]")]
[Authorize]
public class ProductsController : ControllerBase
{
    private readonly IMediator _mediator;
    private readonly ILogger<ProductsController> _logger;

    public ProductsController(IMediator mediator, ILogger<ProductsController> logger)
    {
        _mediator = mediator;
        _logger = logger;
    }

    /// <summary>
    /// Get all products with pagination and filtering
    /// </summary>
    /// <param name="query">Query parameters for filtering and pagination</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Paginated list of products</returns>
    [HttpGet]
    [ProducesResponseType(typeof(Result<PagedResult<ProductListDto>>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(Result), StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> GetProducts(
        [FromQuery] GetProductsQuery query,
        CancellationToken cancellationToken)
    {
        try
        {
            var result = await _mediator.Send(query, cancellationToken);

            if (result.IsSuccess)
            {
                return Ok(result);
            }

            return BadRequest(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving products");
            return StatusCode(StatusCodes.Status500InternalServerError,
                Result.Failure(new Error("INTERNAL_ERROR", "An error occurred while retrieving products")));
        }
    }

    /// <summary>
    /// Get a product by item number
    /// </summary>
    /// <param name="itemNo">Product item number</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Product details</returns>
    [HttpGet("{itemNo}")]
    [ProducesResponseType(typeof(Result<ProductDetailDto>), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(Result), StatusCodes.Status404NotFound)]
    public async Task<IActionResult> GetProduct(
        string itemNo,
        CancellationToken cancellationToken)
    {
        try
        {
            var query = new GetProductByIdQuery { ItemNo = itemNo };
            var result = await _mediator.Send(query, cancellationToken);

            if (result.IsSuccess)
            {
                return Ok(result);
            }

            return NotFound(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving product {ItemNo}", itemNo);
            return StatusCode(StatusCodes.Status500InternalServerError,
                Result.Failure(new Error("INTERNAL_ERROR", $"An error occurred while retrieving product {itemNo}")));
        }
    }

    /// <summary>
    /// Create a new product
    /// </summary>
    /// <param name="command">Product creation data</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Created product item number</returns>
    [HttpPost]
    [ProducesResponseType(typeof(Result<string>), StatusCodes.Status201Created)]
    [ProducesResponseType(typeof(Result), StatusCodes.Status400BadRequest)]
    [Authorize(Policy = "Inventory.Products.Write")]
    public async Task<IActionResult> CreateProduct(
        [FromBody] CreateProductCommand command,
        CancellationToken cancellationToken)
    {
        try
        {
            var result = await _mediator.Send(command, cancellationToken);

            if (result.IsSuccess)
            {
                return CreatedAtAction(
                    nameof(GetProduct),
                    new { itemNo = result.Value },
                    result);
            }

            return BadRequest(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating product");
            return StatusCode(StatusCodes.Status500InternalServerError,
                Result.Failure(new Error("INTERNAL_ERROR", "An error occurred while creating the product")));
        }
    }

    /// <summary>
    /// Update an existing product
    /// </summary>
    /// <param name="itemNo">Product item number</param>
    /// <param name="command">Product update data</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Success result</returns>
    [HttpPut("{itemNo}")]
    [ProducesResponseType(typeof(Result), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(Result), StatusCodes.Status400BadRequest)]
    [ProducesResponseType(typeof(Result), StatusCodes.Status404NotFound)]
    [Authorize(Policy = "Inventory.Products.Write")]
    public async Task<IActionResult> UpdateProduct(
        string itemNo,
        [FromBody] UpdateProductCommand command,
        CancellationToken cancellationToken)
    {
        try
        {
            if (itemNo != command.ItemNo)
            {
                return BadRequest(Result.Failure(
                    new Error("ITEM_MISMATCH", "Item number in URL does not match item number in request body")));
            }

            var result = await _mediator.Send(command, cancellationToken);

            if (result.IsSuccess)
            {
                return Ok(result);
            }

            if (result.Error.Code == "NOT_FOUND")
            {
                return NotFound(result);
            }

            return BadRequest(result);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating product {ItemNo}", itemNo);
            return StatusCode(StatusCodes.Status500InternalServerError,
                Result.Failure(new Error("INTERNAL_ERROR", $"An error occurred while updating product {itemNo}")));
        }
    }

    /// <summary>
    /// Delete a product
    /// </summary>
    /// <param name="itemNo">Product item number</param>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>Success result</returns>
    [HttpDelete("{itemNo}")]
    [ProducesResponseType(typeof(Result), StatusCodes.Status200OK)]
    [ProducesResponseType(typeof(Result), StatusCodes.Status404NotFound)]
    [Authorize(Policy = "Inventory.Products.Delete")]
    public async Task<IActionResult> DeleteProduct(
        string itemNo,
        CancellationToken cancellationToken)
    {
        try
        {
            // TODO: Implement DeleteProductCommand
            return StatusCode(StatusCodes.Status501NotImplemented,
                Result.Failure(new Error("NOT_IMPLEMENTED", "Delete operation not yet implemented")));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting product {ItemNo}", itemNo);
            return StatusCode(StatusCodes.Status500InternalServerError,
                Result.Failure(new Error("INTERNAL_ERROR", $"An error occurred while deleting product {itemNo}")));
        }
    }

    /// <summary>
    /// Get products below minimum stock level
    /// </summary>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>List of products below minimum stock</returns>
    [HttpGet("below-minimum")]
    [ProducesResponseType(typeof(Result<IEnumerable<ProductListDto>>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetProductsBelowMinimum(CancellationToken cancellationToken)
    {
        try
        {
            // TODO: Implement GetProductsBelowMinimumQuery
            return StatusCode(StatusCodes.Status501NotImplemented,
                Result.Failure(new Error("NOT_IMPLEMENTED", "This feature is not yet implemented")));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving products below minimum stock");
            return StatusCode(StatusCodes.Status500InternalServerError,
                Result.Failure(new Error("INTERNAL_ERROR", "An error occurred while retrieving products below minimum stock")));
        }
    }

    /// <summary>
    /// Get products at reorder level
    /// </summary>
    /// <param name="cancellationToken">Cancellation token</param>
    /// <returns>List of products at reorder level</returns>
    [HttpGet("at-reorder-level")]
    [ProducesResponseType(typeof(Result<IEnumerable<ProductListDto>>), StatusCodes.Status200OK)]
    public async Task<IActionResult> GetProductsAtReorderLevel(CancellationToken cancellationToken)
    {
        try
        {
            // TODO: Implement GetProductsAtReorderLevelQuery
            return StatusCode(StatusCodes.Status501NotImplemented,
                Result.Failure(new Error("NOT_IMPLEMENTED", "This feature is not yet implemented")));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving products at reorder level");
            return StatusCode(StatusCodes.Status500InternalServerError,
                Result.Failure(new Error("INTERNAL_ERROR", "An error occurred while retrieving products at reorder level")));
        }
    }
}
