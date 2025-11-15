using System.Data;
using ErpBackEnd.Domain.Interfaces;
using ErpBackEnd.Domain.Interfaces.Repositories;
using ErpBackEnd.Infrastructure.Persistence.Repositories;
using Microsoft.Data.SqlClient;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Logging;

namespace ErpBackEnd.Infrastructure.Persistence;

public sealed class UnitOfWork : IUnitOfWork
{
    private readonly string _connectionString;
    private IDbConnection? _connection;
    private IDbTransaction? _transaction;
    private bool _disposed;

    private readonly ICurrentUserProvider _currentUserProvider;
    private readonly ILoggerFactory _loggerFactory;

    // Lazy-loaded repositories
    private IProductRepository? _products;
    private IProductUnitRepository? _productUnits;
    private IWarehouseRepository? _warehouses;
    private IStockBinRepository? _stockBins;

    public UnitOfWork(
        IConfiguration configuration,
        ICurrentUserProvider currentUserProvider,
        ILoggerFactory loggerFactory)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection")
            ?? throw new InvalidOperationException("Connection string not configured");
        _currentUserProvider = currentUserProvider;
        _loggerFactory = loggerFactory;
    }

    public IDbConnection Connection
    {
        get
        {
            if (_connection == null)
            {
                _connection = new SqlConnection(_connectionString);
            }

            if (_connection.State != ConnectionState.Open)
            {
                _connection.Open();
            }

            return _connection;
        }
    }

    public IDbTransaction? Transaction => _transaction;

    public bool HasActiveTransaction => _transaction != null;

    public IProductRepository Products =>
        _products ??= new ProductRepository(
            Connection,
            _currentUserProvider,
            _loggerFactory.CreateLogger<ProductRepository>());

    public IProductUnitRepository ProductUnits =>
        _productUnits ??= new ProductUnitRepository(
            Connection,
            _currentUserProvider,
            _loggerFactory.CreateLogger<ProductUnitRepository>());

    public IWarehouseRepository Warehouses =>
        _warehouses ??= new WarehouseRepository(
            Connection,
            _currentUserProvider,
            _loggerFactory.CreateLogger<WarehouseRepository>());

    public IStockBinRepository StockBins =>
        _stockBins ??= new StockBinRepository(
            Connection,
            _currentUserProvider,
            _loggerFactory.CreateLogger<StockBinRepository>());

    public async Task BeginTransactionAsync(IsolationLevel level = IsolationLevel.ReadCommitted, CancellationToken ct = default)
    {
        if (_transaction != null)
        {
            throw new InvalidOperationException("A transaction is already in progress");
        }

        if (Connection.State != ConnectionState.Open)
        {
            if (Connection is SqlConnection sqlConnection)
            {
                await sqlConnection.OpenAsync(ct);
            }
        }

        _transaction = Connection.BeginTransaction(level);
    }

    public async Task CommitAsync(CancellationToken ct = default)
    {
        if (_transaction == null)
        {
            throw new InvalidOperationException("No transaction to commit");
        }

        try
        {
            await Task.Run(() => _transaction.Commit(), ct);
        }
        catch
        {
            await RollbackAsync(ct);
            throw;
        }
        finally
        {
            _transaction.Dispose();
            _transaction = null;
        }
    }

    public async Task RollbackAsync(CancellationToken ct = default)
    {
        if (_transaction == null) return;

        try
        {
            await Task.Run(() => _transaction.Rollback(), ct);
        }
        finally
        {
            _transaction.Dispose();
            _transaction = null;
        }
    }

    public async ValueTask DisposeAsync()
    {
        if (_disposed) return;

        if (_transaction != null)
        {
            await RollbackAsync();
        }

        if (_connection != null)
        {
            if (_connection.State == ConnectionState.Open)
            {
                if (_connection is SqlConnection sqlConnection)
                {
                    await sqlConnection.CloseAsync();
                }
            }
            _connection.Dispose();
        }

        _disposed = true;
        GC.SuppressFinalize(this);
    }
}
