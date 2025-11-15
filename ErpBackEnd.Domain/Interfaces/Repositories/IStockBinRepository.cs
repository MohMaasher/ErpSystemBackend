using ErpBackEnd.Domain.Entities.Inventory;

namespace ErpBackEnd.Domain.Interfaces.Repositories;

/// <summary>
/// Repository interface for StockBin entity
/// </summary>
public interface IStockBinRepository
{
    /// <summary>
    /// Get stock bin by composite key
    /// </summary>
    Task<StockBin?> GetByIdAsync(string branchCode, string itemNo, string unitCode, string warehouseNo, string binNo, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get all bins for a specific product unit in a warehouse
    /// </summary>
    Task<IEnumerable<StockBin>> GetByProductAndWarehouseAsync(string itemNo, string unitCode, string warehouseNo, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get all stock in a specific warehouse
    /// </summary>
    Task<IEnumerable<StockBin>> GetByWarehouseAsync(string warehouseNo, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get all stock for a specific product across all warehouses
    /// </summary>
    Task<IEnumerable<StockBin>> GetByProductAsync(string itemNo, string unitCode, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get total available quantity for a product across all warehouses/bins
    /// </summary>
    Task<decimal> GetTotalAvailableQuantityAsync(string itemNo, string unitCode, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get bins with expiring stock (within specified days)
    /// </summary>
    Task<IEnumerable<StockBin>> GetExpiringStockAsync(int daysUntilExpiry, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get bins with expired stock
    /// </summary>
    Task<IEnumerable<StockBin>> GetExpiredStockAsync(CancellationToken cancellationToken = default);

    /// <summary>
    /// Add stock bin
    /// </summary>
    Task<bool> AddAsync(StockBin stockBin, System.Data.IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Update stock bin quantity
    /// </summary>
    Task<bool> UpdateQuantityAsync(string branchCode, string itemNo, string unitCode, string warehouseNo, string binNo, decimal quantityChange, System.Data.IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Update reserved quantity
    /// </summary>
    Task<bool> UpdateReservedQuantityAsync(string branchCode, string itemNo, string unitCode, string warehouseNo, string binNo, decimal quantityChange, System.Data.IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Transfer stock between bins
    /// </summary>
    Task<bool> TransferBetweenBinsAsync(string branchCode, string itemNo, string unitCode, string fromWarehouse, string fromBin, string toWarehouse, string toBin, decimal quantity, System.Data.IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Delete stock bin
    /// </summary>
    Task<bool> DeleteAsync(string branchCode, string itemNo, string unitCode, string warehouseNo, string binNo, System.Data.IDbTransaction? transaction = null, CancellationToken cancellationToken = default);
}
