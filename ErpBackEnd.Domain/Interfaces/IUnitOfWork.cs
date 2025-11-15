using System.Data;
using ErpBackEnd.Domain.Interfaces.Repositories;

namespace ErpBackEnd.Domain.Interfaces;

/// <summary>
/// Unit of Work pattern to manage database transactions
/// </summary>
public interface IUnitOfWork : IAsyncDisposable
{
    // Inventory Repositories
    IProductRepository Products { get; }
    IProductUnitRepository ProductUnits { get; }
    IWarehouseRepository Warehouses { get; }
    IStockBinRepository StockBins { get; }

    /// <summary>
    /// Begin a new database transaction
    /// </summary>
    Task BeginTransactionAsync(IsolationLevel level = IsolationLevel.ReadCommitted, CancellationToken ct = default);

    /// <summary>
    /// Commit the current transaction
    /// </summary>
    Task CommitAsync(CancellationToken ct = default);

    /// <summary>
    /// Rollback the current transaction
    /// </summary>
    Task RollbackAsync(CancellationToken ct = default);

    /// <summary>
    /// Check if there is an active transaction
    /// </summary>
    bool HasActiveTransaction { get; }

    /// <summary>
    /// Get the current transaction
    /// </summary>
    IDbTransaction? Transaction { get; }

    /// <summary>
    /// Get the underlying connection
    /// </summary>
    IDbConnection Connection { get; }
}
