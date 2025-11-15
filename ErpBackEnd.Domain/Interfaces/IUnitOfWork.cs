using System.Data;
using ErpBackEnd.Domain.Interfaces.Repositories;

namespace ErpBackEnd.Domain.Interfaces;

/// <summary>
/// Unit of Work pattern to manage database transactions
/// </summary>
public interface IUnitOfWork : IDisposable
{
    // Inventory Repositories
    IProductRepository Products { get; }
    IProductUnitRepository ProductUnits { get; }
    IWarehouseRepository Warehouses { get; }
    IStockBinRepository StockBins { get; }

    /// <summary>
    /// Begin a new database transaction
    /// </summary>
    Task<IDbTransaction> BeginTransactionAsync();

    /// <summary>
    /// Commit the current transaction
    /// </summary>
    Task CommitAsync();

    /// <summary>
    /// Rollback the current transaction
    /// </summary>
    Task RollbackAsync();

    /// <summary>
    /// Get the current transaction
    /// </summary>
    IDbTransaction? CurrentTransaction { get; }

    /// <summary>
    /// Get the underlying connection
    /// </summary>
    IDbConnection Connection { get; }
}
