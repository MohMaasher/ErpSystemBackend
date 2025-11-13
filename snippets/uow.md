# Unit of Work Pattern

## Current User Provider
```csharp
namespace ErpBackEnd.Application.Interfaces;

public interface ICurrentUserProvider
{
    int UserId { get; }
    string Username { get; }
    string? TenantId { get; }
    string? IpAddress { get; }
    IEnumerable<string> Permissions { get; }
    IEnumerable<string> Roles { get; }
}
```

## HTTP Context Implementation
```csharp
namespace ErpBackEnd.Infrastructure.Services;

public class HttpContextCurrentUserProvider : ICurrentUserProvider
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public HttpContextCurrentUserProvider(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    private ClaimsPrincipal? User => _httpContextAccessor.HttpContext?.User;

    public int UserId
    {
        get
        {
            var userIdClaim = User?.FindFirst(ClaimTypes.NameIdentifier)?.Value 
                           ?? User?.FindFirst("sub")?.Value;
            
            return int.TryParse(userIdClaim, out var userId) ? userId : 0;
        }
    }

    public string Username => User?.Identity?.Name ?? "System";

    public string? TenantId => User?.FindFirst("tid")?.Value;

    public string? IpAddress => _httpContextAccessor.HttpContext?.Connection?.RemoteIpAddress?.ToString();

    public IEnumerable<string> Permissions => User?.FindAll("permission").Select(c => c.Value) ?? Enumerable.Empty<string>();

    public IEnumerable<string> Roles => User?.FindAll(ClaimTypes.Role).Select(c => c.Value) ?? Enumerable.Empty<string>();
}
```

## Background Job Implementation
```csharp
namespace ErpBackEnd.Infrastructure.Services;

public class SystemUserProvider : ICurrentUserProvider
{
    public int UserId { get; set; } = 0; // System user
    public string Username { get; set; } = "System";
    public string? TenantId { get; set; }
    public string? IpAddress => "::1";
    public IEnumerable<string> Permissions { get; set; } = new[] { "*" }; // All permissions for system
    public IEnumerable<string> Roles { get; set; } = new[] { "System" };
}

// For use in background jobs
public class BackgroundJobUserProvider : ICurrentUserProvider
{
    private readonly int _userId;
    private readonly string _username;
    private readonly string? _tenantId;

    public BackgroundJobUserProvider(int userId, string username, string? tenantId = null)
    {
        _userId = userId;
        _username = username;
        _tenantId = tenantId;
    }

    public int UserId => _userId;
    public string Username => _username;
    public string? TenantId => _tenantId;
    public string? IpAddress => "BackgroundJob";
    public IEnumerable<string> Permissions => Enumerable.Empty<string>();
    public IEnumerable<string> Roles => new[] { "BackgroundJob" };
}
```

## Unit of Work Interface
```csharp
namespace ErpBackEnd.Application.Interfaces.Persistence;

public interface IUnitOfWork : IAsyncDisposable
{
    // Transaction Management
    Task BeginTransactionAsync(IsolationLevel level = IsolationLevel.ReadCommitted, CancellationToken ct = default);
    Task CommitAsync(CancellationToken ct = default);
    Task RollbackAsync(CancellationToken ct = default);
    bool HasActiveTransaction { get; }
    
    // Repositories
    IAccountRepository Accounts { get; }
    ICustomerRepository Customers { get; }
    IProductRepository Products { get; }
    IWarehouseRepository Warehouses { get; }
    ISalesOrderRepository SalesOrders { get; }
    IPurchaseOrderRepository PurchaseOrders { get; }
    IJournalEntryRepository JournalEntries { get; }
    
    // Direct Access for Complex Queries
    IDbConnection Connection { get; }
    IDbTransaction? Transaction { get; }
    
    // Bulk Operations
    Task<int> ExecuteAsync(string sql, object? param = null, CancellationToken ct = default);
    Task<T> ExecuteScalarAsync<T>(string sql, object? param = null, CancellationToken ct = default);
}
```

## Unit of Work Implementation
```csharp
namespace ErpBackEnd.Infrastructure.Persistence;

public sealed class UnitOfWork : IUnitOfWork
{
    private readonly string _connectionString;
    private IDbConnection? _connection;
    private IDbTransaction? _transaction;
    private bool _disposed;
    
    private readonly ICurrentUserProvider _currentUserProvider;
    private readonly ILoggerFactory _loggerFactory;
    private readonly ICacheService _cacheService;

    // Lazy-loaded repositories
    private IAccountRepository? _accounts;
    private ICustomerRepository? _customers;
    private IProductRepository? _products;
    private IWarehouseRepository? _warehouses;
    private ISalesOrderRepository? _salesOrders;
    private IPurchaseOrderRepository? _purchaseOrders;
    private IJournalEntryRepository? _journalEntries;

    public UnitOfWork(
        IConfiguration configuration,
        ICurrentUserProvider currentUserProvider,
        ILoggerFactory loggerFactory,
        ICacheService cacheService)
    {
        _connectionString = configuration.GetConnectionString("DefaultConnection") 
            ?? throw new InvalidOperationException("Connection string not configured");
        _currentUserProvider = currentUserProvider;
        _loggerFactory = loggerFactory;
        _cacheService = cacheService;
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

    public IAccountRepository Accounts
    {
        get
        {
            if (_accounts == null)
            {
                var repository = new AccountRepository(
                    Connection,
                    _currentUserProvider,
                    _loggerFactory.CreateLogger<AccountRepository>());
                
                // Wrap with caching decorator
                _accounts = new CachedAccountRepository(
                    repository,
                    _cacheService,
                    _loggerFactory.CreateLogger<CachedAccountRepository>());
            }
            return _accounts;
        }
    }

    public ICustomerRepository Customers => 
        _customers ??= new CustomerRepository(
            Connection,
            _currentUserProvider,
            _loggerFactory.CreateLogger<CustomerRepository>());

    public IProductRepository Products => 
        _products ??= new ProductRepository(
            Connection,
            _currentUserProvider,
            _loggerFactory.CreateLogger<ProductRepository>());

    public IWarehouseRepository Warehouses => 
        _warehouses ??= new WarehouseRepository(
            Connection,
            _currentUserProvider,
            _loggerFactory.CreateLogger<WarehouseRepository>());

    public ISalesOrderRepository SalesOrders => 
        _salesOrders ??= new SalesOrderRepository(
            Connection,
            _currentUserProvider,
            _loggerFactory.CreateLogger<SalesOrderRepository>());

    public IPurchaseOrderRepository PurchaseOrders => 
        _purchaseOrders ??= new PurchaseOrderRepository(
            Connection,
            _currentUserProvider,
            _loggerFactory.CreateLogger<PurchaseOrderRepository>());

    public IJournalEntryRepository JournalEntries => 
        _journalEntries ??= new JournalEntryRepository(
            Connection,
            _currentUserProvider,
            _loggerFactory.CreateLogger<JournalEntryRepository>());

    public async Task BeginTransactionAsync(IsolationLevel level = IsolationLevel.ReadCommitted, CancellationToken ct = default)
    {
        if (_transaction != null)
        {
            throw new InvalidOperationException("A transaction is already in progress");
        }

        if (Connection.State != ConnectionState.Open)
        {
            await ((SqlConnection)Connection).OpenAsync(ct);
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

    public async Task<int> ExecuteAsync(string sql, object? param = null, CancellationToken ct = default)
    {
        var command = new CommandDefinition(sql, param, _transaction, cancellationToken: ct);
        return await Connection.ExecuteAsync(command);
    }

    public async Task<T> ExecuteScalarAsync<T>(string sql, object? param = null, CancellationToken ct = default)
    {
        var command = new CommandDefinition(sql, param, _transaction, cancellationToken: ct);
        return await Connection.ExecuteScalarAsync<T>(command);
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
                await ((SqlConnection)_connection).CloseAsync();
            }
            _connection.Dispose();
        }

        _disposed = true;
        GC.SuppressFinalize(this);
    }
}
```

## Unit of Work with Audit
```csharp
namespace ErpBackEnd.Infrastructure.Persistence;

public class AuditableUnitOfWork : IUnitOfWork
{
    private readonly IUnitOfWork _innerUnitOfWork;
    private readonly IAuditService _auditService;
    private readonly List<AuditEntry> _auditEntries = new();

    public AuditableUnitOfWork(IUnitOfWork innerUnitOfWork, IAuditService auditService)
    {
        _innerUnitOfWork = innerUnitOfWork;
        _auditService = auditService;
    }

    public IDbConnection Connection => _innerUnitOfWork.Connection;
    public IDbTransaction? Transaction => _innerUnitOfWork.Transaction;
    public bool HasActiveTransaction => _innerUnitOfWork.HasActiveTransaction;

    // Wrap repositories with audit tracking
    public IAccountRepository Accounts => new AuditableRepository<Account>(
        _innerUnitOfWork.Accounts,
        _auditEntries);

    // ... other repositories

    public async Task BeginTransactionAsync(IsolationLevel level = IsolationLevel.ReadCommitted, CancellationToken ct = default)
    {
        await _innerUnitOfWork.BeginTransactionAsync(level, ct);
        _auditEntries.Clear();
    }

    public async Task CommitAsync(CancellationToken ct = default)
    {
        // Commit the main transaction
        await _innerUnitOfWork.CommitAsync(ct);
        
        // Log audit entries after successful commit
        if (_auditEntries.Any())
        {
            await _auditService.LogBulkAsync(_auditEntries, ct);
        }
        
        _auditEntries.Clear();
    }

    public async Task RollbackAsync(CancellationToken ct = default)
    {
        await _innerUnitOfWork.RollbackAsync(ct);
        _auditEntries.Clear();
    }

    public Task<int> ExecuteAsync(string sql, object? param = null, CancellationToken ct = default)
        => _innerUnitOfWork.ExecuteAsync(sql, param, ct);

    public Task<T> ExecuteScalarAsync<T>(string sql, object? param = null, CancellationToken ct = default)
        => _innerUnitOfWork.ExecuteScalarAsync<T>(sql, param, ct);

    public ValueTask DisposeAsync() => _innerUnitOfWork.DisposeAsync();
}
```

## Unit of Work Factory
```csharp
namespace ErpBackEnd.Infrastructure.Persistence;

public interface IUnitOfWorkFactory
{
    IUnitOfWork Create();
    IUnitOfWork CreateWithAudit();
}

public class UnitOfWorkFactory : IUnitOfWorkFactory
{
    private readonly IServiceProvider _serviceProvider;

    public UnitOfWorkFactory(IServiceProvider serviceProvider)
    {
        _serviceProvider = serviceProvider;
    }

    public IUnitOfWork Create()
    {
        return new UnitOfWork(
            _serviceProvider.GetRequiredService<IConfiguration>(),
            _serviceProvider.GetRequiredService<ICurrentUserProvider>(),
            _serviceProvider.GetRequiredService<ILoggerFactory>(),
            _serviceProvider.GetRequiredService<ICacheService>());
    }

    public IUnitOfWork CreateWithAudit()
    {
        var baseUow = Create();
        var auditService = _serviceProvider.GetRequiredService<IAuditService>();
        return new AuditableUnitOfWork(baseUow, auditService);
    }
}
```

## Service Registration
```csharp
// In Program.cs or Startup.cs
public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddPersistence(this IServiceCollection services, IConfiguration configuration)
    {
        // Register connection
        services.AddSingleton<IDbConnection>(sp =>
        {
            var connectionString = configuration.GetConnectionString("DefaultConnection");
            return new SqlConnection(connectionString);
        });

        // Register current user provider
        services.AddScoped<ICurrentUserProvider, HttpContextCurrentUserProvider>();
        
        // Register UnitOfWork
        services.AddScoped<IUnitOfWork, UnitOfWork>();
        services.AddScoped<IUnitOfWorkFactory, UnitOfWorkFactory>();
        
        // Register repositories if needed individually
        services.AddScoped<IAccountRepository, AccountRepository>();
        services.AddScoped<ICustomerRepository, CustomerRepository>();
        services.AddScoped<IProductRepository, ProductRepository>();
        // ... other repositories
        
        // Register audit service
        services.AddScoped<IAuditService, AuditService>();
        
        // Register cache service
        services.AddSingleton<ICacheService, RedisCacheService>();
        
        return services;
    }
}
```

## Usage Example
```csharp
public class CreateAccountCommandHandler : IRequestHandler<CreateAccountCommand, Result<AccountDto>>
{
    private readonly IUnitOfWorkFactory _unitOfWorkFactory;
    private readonly IMapper _mapper;
    private readonly ILogger<CreateAccountCommandHandler> _logger;

    public CreateAccountCommandHandler(
        IUnitOfWorkFactory unitOfWorkFactory,
        IMapper mapper,
        ILogger<CreateAccountCommandHandler> logger)
    {
        _unitOfWorkFactory = unitOfWorkFactory;
        _mapper = mapper;
        _logger = logger;
    }

    public async Task<Result<AccountDto>> Handle(CreateAccountCommand request, CancellationToken cancellationToken)
    {
        await using var unitOfWork = _unitOfWorkFactory.CreateWithAudit();
        
        try
        {
            await unitOfWork.BeginTransactionAsync(cancellationToken: cancellationToken);
            
            // Check if account code already exists
            var existingAccount = await unitOfWork.Accounts.GetByCodeAsync(request.Code, cancellationToken);
            if (existingAccount != null)
            {
                return Result<AccountDto>.Failure(Error.Conflict("Account code already exists"));
            }
            
            // Create new account
            var account = Account.Create(
                request.Code,
                request.NameAr,
                request.NameEn,
                request.AccountType,
                request.AccountNature);
            
            // Save to database
            var accountId = await unitOfWork.Accounts.AddAsync(account, unitOfWork.Transaction!, cancellationToken);
            account.Id = accountId;
            
            // Commit transaction (this will also save audit logs)
            await unitOfWork.CommitAsync(cancellationToken);
            
            _logger.LogInformation("Account {AccountCode} created successfully with ID {AccountId}", 
                account.Code, account.Id);
            
            var dto = _mapper.Map<AccountDto>(account);
            return Result<AccountDto>.Success(dto);
        }
        catch (Exception ex)
        {
            await unitOfWork.RollbackAsync(cancellationToken);
            _logger.LogError(ex, "Error creating account with code {AccountCode}", request.Code);
            throw;
        }
    }
}
```