using ErpBackEnd.Domain.Entities.Inventory;

namespace ErpBackEnd.Domain.Interfaces.Repositories;

/// <summary>
/// Repository interface for Warehouse entity
/// </summary>
public interface IWarehouseRepository : IRepository<Warehouse, string>
{
    /// <summary>
    /// Get warehouse with all stock bins
    /// </summary>
    Task<Warehouse?> GetWithStockBinsAsync(string warehouseNo, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get warehouses by branch
    /// </summary>
    Task<IEnumerable<Warehouse>> GetByBranchAsync(string branchCode, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get active warehouses only
    /// </summary>
    Task<IEnumerable<Warehouse>> GetActiveWarehousesAsync(CancellationToken cancellationToken = default);

    /// <summary>
    /// Get non-suspended warehouses
    /// </summary>
    Task<IEnumerable<Warehouse>> GetNonSuspendedWarehousesAsync(CancellationToken cancellationToken = default);

    /// <summary>
    /// Check if warehouse code exists
    /// </summary>
    Task<bool> WarehouseExistsAsync(string warehouseNo, CancellationToken cancellationToken = default);
}
