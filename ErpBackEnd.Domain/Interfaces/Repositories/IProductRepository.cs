using ErpBackEnd.Domain.Entities.Inventory;

namespace ErpBackEnd.Domain.Interfaces.Repositories;

/// <summary>
/// Repository interface for Product entity
/// </summary>
public interface IProductRepository : IRepository<Product, string>
{
    /// <summary>
    /// Get product by item number with all related data (units, barcodes, etc.)
    /// </summary>
    Task<Product?> GetWithDetailsAsync(string itemNo, CancellationToken cancellationToken = default);

    /// <summary>
    /// Search products by name (Arabic or English)
    /// </summary>
    Task<IEnumerable<Product>> SearchByNameAsync(string searchTerm, int pageNumber = 1, int pageSize = 50, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get products by classification
    /// </summary>
    Task<IEnumerable<Product>> GetByClassificationAsync(string classKey, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get products by category
    /// </summary>
    Task<IEnumerable<Product>> GetByCategoryAsync(string categoryCode, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get products by supplier
    /// </summary>
    Task<IEnumerable<Product>> GetBySupplierAsync(string supplierCode, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get products by brand
    /// </summary>
    Task<IEnumerable<Product>> GetByBrandAsync(int brandId, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get active products only
    /// </summary>
    Task<IEnumerable<Product>> GetActiveProductsAsync(int pageNumber = 1, int pageSize = 100, CancellationToken cancellationToken = default);

    /// <summary>
    /// Check if product code exists
    /// </summary>
    Task<bool> ItemNoExistsAsync(string itemNo, CancellationToken cancellationToken = default);
}
