using ErpBackEnd.Domain.Entities.Inventory;

namespace ErpBackEnd.Domain.Interfaces.Repositories;

/// <summary>
/// Repository interface for ProductUnit entity
/// </summary>
public interface IProductUnitRepository
{
    /// <summary>
    /// Get product unit by composite key (itemno + unicode)
    /// </summary>
    Task<ProductUnit?> GetByIdAsync(string itemNo, string unitCode, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get all units for a specific product
    /// </summary>
    Task<IEnumerable<ProductUnit>> GetByItemNoAsync(string itemNo, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get product unit by barcode
    /// </summary>
    Task<ProductUnit?> GetByBarcodeAsync(string barcode, CancellationToken cancellationToken = default);

    /// <summary>
    /// Search product units by combination key
    /// </summary>
    Task<IEnumerable<ProductUnit>> GetByCombinationKeyAsync(string combinationKey, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get products below minimum stock level
    /// </summary>
    Task<IEnumerable<ProductUnit>> GetBelowMinimumStockAsync(CancellationToken cancellationToken = default);

    /// <summary>
    /// Get products at or below reorder level
    /// </summary>
    Task<IEnumerable<ProductUnit>> GetAtReorderLevelAsync(CancellationToken cancellationToken = default);

    /// <summary>
    /// Get inactive products
    /// </summary>
    Task<IEnumerable<ProductUnit>> GetInactiveUnitsAsync(CancellationToken cancellationToken = default);

    /// <summary>
    /// Add product unit
    /// </summary>
    Task<bool> AddAsync(ProductUnit productUnit, System.Data.IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Update product unit
    /// </summary>
    Task<bool> UpdateAsync(ProductUnit productUnit, System.Data.IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Update stock balance
    /// </summary>
    Task<bool> UpdateStockBalanceAsync(string itemNo, string unitCode, decimal quantityChange, System.Data.IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Update reserved quantity
    /// </summary>
    Task<bool> UpdateReservedQuantityAsync(string itemNo, string unitCode, decimal quantityChange, System.Data.IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Delete product unit
    /// </summary>
    Task<bool> DeleteAsync(string itemNo, string unitCode, System.Data.IDbTransaction? transaction = null, CancellationToken cancellationToken = default);
}
