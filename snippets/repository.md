# Repository Patterns

## Base Entity
```csharp
namespace ErpBackEnd.Domain.Common;

public abstract class BaseEntity
{
    public int Id { get; set; }
    public int CreatedBy { get; set; }
    public DateTime CreatedDate { get; set; }
    public int? ModifiedBy { get; set; }
    public DateTime? ModifiedDate { get; set; }
}

public abstract class AuditableEntity : BaseEntity
{
    public bool IsDeleted { get; private set; }
    public int? DeletedBy { get; private set; }
    public DateTime? DeletedDate { get; private set; }

    public void MarkAsDeleted(int userId)
    {
        IsDeleted = true;
        DeletedBy = userId;
        DeletedDate = DateTime.UtcNow;
    }
}
```

## Generic Repository Interface
```csharp
namespace ErpBackEnd.Application.Interfaces.Persistence;

public interface IRepository<T> where T : BaseEntity
{
    // Read operations (don't need a transaction)
    Task<T?> GetByIdAsync(int id, CancellationToken ct = default);
    Task<IEnumerable<T>> GetAllAsync(CancellationToken ct = default);
    Task<IEnumerable<T>> GetPagedAsync(int pageNumber, int pageSize, CancellationToken ct = default);
    Task<int> CountAsync(CancellationToken ct = default);
    Task<bool> ExistsAsync(int id, CancellationToken ct = default);
    
    // Write operations (must be part of a transaction)
    Task<int> AddAsync(T entity, IDbTransaction transaction, CancellationToken ct = default);
    Task<bool> UpdateAsync(T entity, IDbTransaction transaction, CancellationToken ct = default);
    Task<bool> DeleteAsync(int id, IDbTransaction transaction, CancellationToken ct = default);
    
    // Bulk operations
    Task<int> AddRangeAsync(IEnumerable<T> entities, IDbTransaction transaction, CancellationToken ct = default);
    Task<int> UpdateRangeAsync(IEnumerable<T> entities, IDbTransaction transaction, CancellationToken ct = default);
    Task<int> DeleteRangeAsync(IEnumerable<int> ids, IDbTransaction transaction, CancellationToken ct = default);
}
```

## Specialized Repository Example
```csharp
namespace ErpBackEnd.Application.Interfaces.Persistence;

public interface IAccountRepository : IRepository<Account>
{
    Task<Account?> GetByCodeAsync(string code, CancellationToken ct = default);
    Task<IEnumerable<Account>> GetByTypeAsync(AccountType type, CancellationToken ct = default);
    Task<IEnumerable<Account>> GetChildAccountsAsync(int parentId, CancellationToken ct = default);
    Task<bool> IsCodeUniqueAsync(string code, int? excludeId = null, CancellationToken ct = default);
    Task<AccountBalance> GetBalanceAsync(int accountId, DateTime? asOfDate = null, CancellationToken ct = default);
}
```

## Repository Implementation
```csharp
namespace ErpBackEnd.Infrastructure.Persistence.Repositories;

public class AccountRepository : IAccountRepository
{
    private readonly IDbConnection _connection;
    private readonly ICurrentUserProvider _currentUserProvider;
    private readonly ILogger<AccountRepository> _logger;

    public AccountRepository(
        IDbConnection connection,
        ICurrentUserProvider currentUserProvider,
        ILogger<AccountRepository> logger)
    {
        _connection = connection;
        _currentUserProvider = currentUserProvider;
        _logger = logger;
    }

    public async Task<Account?> GetByIdAsync(int id, CancellationToken ct = default)
    {
        const string sql = @"
            SELECT 
                AccountId AS Id,
                Code,
                NameAr,
                NameEn,
                AccountType,
                AccountNature,
                Level,
                ParentAccountId,
                IsActive,
                Balance,
                CreatedBy,
                CreatedDate,
                ModifiedBy,
                ModifiedDate
            FROM AccountChart 
            WHERE AccountId = @Id AND IsActive = 1";
        
        var command = new CommandDefinition(sql, new { Id = id }, cancellationToken: ct);
        
        try
        {
            return await _connection.QuerySingleOrDefaultAsync<Account>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving account with ID {AccountId}", id);
            throw;
        }
    }

    public async Task<IEnumerable<Account>> GetAllAsync(CancellationToken ct = default)
    {
        const string sql = @"
            SELECT 
                AccountId AS Id,
                Code,
                NameAr,
                NameEn,
                AccountType,
                AccountNature,
                Level,
                ParentAccountId,
                IsActive,
                Balance,
                CreatedBy,
                CreatedDate,
                ModifiedBy,
                ModifiedDate
            FROM AccountChart 
            WHERE IsActive = 1
            ORDER BY Code";
        
        var command = new CommandDefinition(sql, cancellationToken: ct);
        
        try
        {
            return await _connection.QueryAsync<Account>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving all accounts");
            throw;
        }
    }

    public async Task<IEnumerable<Account>> GetPagedAsync(int pageNumber, int pageSize, CancellationToken ct = default)
    {
        const string sql = @"
            SELECT 
                AccountId AS Id,
                Code,
                NameAr,
                NameEn,
                AccountType,
                AccountNature,
                Level,
                ParentAccountId,
                IsActive,
                Balance,
                CreatedBy,
                CreatedDate,
                ModifiedBy,
                ModifiedDate
            FROM AccountChart 
            WHERE IsActive = 1
            ORDER BY Code
            OFFSET @Offset ROWS
            FETCH NEXT @PageSize ROWS ONLY";
        
        var offset = (pageNumber - 1) * pageSize;
        var command = new CommandDefinition(sql, new { Offset = offset, PageSize = pageSize }, cancellationToken: ct);
        
        try
        {
            return await _connection.QueryAsync<Account>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving paged accounts. Page: {PageNumber}, Size: {PageSize}", pageNumber, pageSize);
            throw;
        }
    }

    public async Task<int> CountAsync(CancellationToken ct = default)
    {
        const string sql = "SELECT COUNT(*) FROM AccountChart WHERE IsActive = 1";
        var command = new CommandDefinition(sql, cancellationToken: ct);
        
        try
        {
            return await _connection.ExecuteScalarAsync<int>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error counting accounts");
            throw;
        }
    }

    public async Task<bool> ExistsAsync(int id, CancellationToken ct = default)
    {
        const string sql = "SELECT COUNT(1) FROM AccountChart WHERE AccountId = @Id AND IsActive = 1";
        var command = new CommandDefinition(sql, new { Id = id }, cancellationToken: ct);
        
        try
        {
            var count = await _connection.ExecuteScalarAsync<int>(command);
            return count > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error checking if account exists with ID {AccountId}", id);
            throw;
        }
    }

    public async Task<int> AddAsync(Account entity, IDbTransaction transaction, CancellationToken ct = default)
    {
        const string sql = @"
            INSERT INTO AccountChart (
                Code, NameAr, NameEn, AccountType, AccountNature, 
                Level, ParentAccountId, IsActive, Balance,
                CreatedBy, CreatedDate
            ) VALUES (
                @Code, @NameAr, @NameEn, @AccountType, @AccountNature,
                @Level, @ParentAccountId, 1, 0,
                @CreatedBy, GETUTCDATE()
            );
            SELECT CAST(SCOPE_IDENTITY() as int)";
        
        entity.CreatedBy = _currentUserProvider.UserId;
        entity.CreatedDate = DateTime.UtcNow;
        
        var command = new CommandDefinition(sql, entity, transaction, cancellationToken: ct);
        
        try
        {
            var id = await _connection.QuerySingleAsync<int>(command);
            entity.Id = id;
            
            _logger.LogInformation("Account created with ID {AccountId} by user {UserId}", id, _currentUserProvider.UserId);
            return id;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating account with code {AccountCode}", entity.Code);
            throw;
        }
    }

    public async Task<bool> UpdateAsync(Account entity, IDbTransaction transaction, CancellationToken ct = default)
    {
        const string sql = @"
            UPDATE AccountChart SET
                NameAr = @NameAr,
                NameEn = @NameEn,
                AccountType = @AccountType,
                AccountNature = @AccountNature,
                Level = @Level,
                ParentAccountId = @ParentAccountId,
                IsActive = @IsActive,
                Balance = @Balance,
                ModifiedBy = @ModifiedBy,
                ModifiedDate = GETUTCDATE()
            WHERE AccountId = @Id";
        
        entity.ModifiedBy = _currentUserProvider.UserId;
        entity.ModifiedDate = DateTime.UtcNow;
        
        var command = new CommandDefinition(sql, entity, transaction, cancellationToken: ct);
        
        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);
            
            if (affectedRows > 0)
            {
                _logger.LogInformation("Account {AccountId} updated by user {UserId}", entity.Id, _currentUserProvider.UserId);
            }
            
            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating account {AccountId}", entity.Id);
            throw;
        }
    }

    public async Task<bool> DeleteAsync(int id, IDbTransaction transaction, CancellationToken ct = default)
    {
        // Hard delete as per requirements
        const string sql = "DELETE FROM AccountChart WHERE AccountId = @Id";
        var command = new CommandDefinition(sql, new { Id = id }, transaction, cancellationToken: ct);
        
        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);
            
            if (affectedRows > 0)
            {
                _logger.LogInformation("Account {AccountId} deleted by user {UserId}", id, _currentUserProvider.UserId);
            }
            
            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting account {AccountId}", id);
            throw;
        }
    }

    public async Task<int> AddRangeAsync(IEnumerable<Account> entities, IDbTransaction transaction, CancellationToken ct = default)
    {
        const string sql = @"
            INSERT INTO AccountChart (
                Code, NameAr, NameEn, AccountType, AccountNature, 
                Level, ParentAccountId, IsActive, Balance,
                CreatedBy, CreatedDate
            ) VALUES (
                @Code, @NameAr, @NameEn, @AccountType, @AccountNature,
                @Level, @ParentAccountId, 1, 0,
                @CreatedBy, GETUTCDATE()
            )";
        
        var userId = _currentUserProvider.UserId;
        var createdDate = DateTime.UtcNow;
        
        foreach (var entity in entities)
        {
            entity.CreatedBy = userId;
            entity.CreatedDate = createdDate;
        }
        
        var command = new CommandDefinition(sql, entities, transaction, cancellationToken: ct);
        
        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);
            _logger.LogInformation("{Count} accounts created by user {UserId}", affectedRows, userId);
            return affectedRows;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating multiple accounts");
            throw;
        }
    }

    public async Task<Account?> GetByCodeAsync(string code, CancellationToken ct = default)
    {
        const string sql = @"
            SELECT 
                AccountId AS Id,
                Code,
                NameAr,
                NameEn,
                AccountType,
                AccountNature,
                Level,
                ParentAccountId,
                IsActive,
                Balance,
                CreatedBy,
                CreatedDate,
                ModifiedBy,
                ModifiedDate
            FROM AccountChart 
            WHERE Code = @Code AND IsActive = 1";
        
        var command = new CommandDefinition(sql, new { Code = code }, cancellationToken: ct);
        
        try
        {
            return await _connection.QuerySingleOrDefaultAsync<Account>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving account with code {AccountCode}", code);
            throw;
        }
    }

    public async Task<IEnumerable<Account>> GetByTypeAsync(AccountType type, CancellationToken ct = default)
    {
        const string sql = @"
            SELECT 
                AccountId AS Id,
                Code,
                NameAr,
                NameEn,
                AccountType,
                AccountNature,
                Level,
                ParentAccountId,
                IsActive,
                Balance,
                CreatedBy,
                CreatedDate,
                ModifiedBy,
                ModifiedDate
            FROM AccountChart 
            WHERE AccountType = @Type AND IsActive = 1
            ORDER BY Code";
        
        var command = new CommandDefinition(sql, new { Type = type }, cancellationToken: ct);
        
        try
        {
            return await _connection.QueryAsync<Account>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving accounts of type {AccountType}", type);
            throw;
        }
    }

    public async Task<bool> IsCodeUniqueAsync(string code, int? excludeId = null, CancellationToken ct = default)
    {
        var sql = "SELECT COUNT(1) FROM AccountChart WHERE Code = @Code AND IsActive = 1";
        object parameters;
        
        if (excludeId.HasValue)
        {
            sql += " AND AccountId != @ExcludeId";
            parameters = new { Code = code, ExcludeId = excludeId.Value };
        }
        else
        {
            parameters = new { Code = code };
        }
        
        var command = new CommandDefinition(sql, parameters, cancellationToken: ct);
        
        try
        {
            var count = await _connection.ExecuteScalarAsync<int>(command);
            return count == 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error checking uniqueness of account code {AccountCode}", code);
            throw;
        }
    }
}
```

## Repository with Caching
```csharp
namespace ErpBackEnd.Infrastructure.Persistence.Repositories;

public class CachedAccountRepository : IAccountRepository
{
    private readonly IAccountRepository _innerRepository;
    private readonly ICacheService _cacheService;
    private readonly ILogger<CachedAccountRepository> _logger;
    private const int CacheExpirationMinutes = 5;

    public CachedAccountRepository(
        IAccountRepository innerRepository,
        ICacheService cacheService,
        ILogger<CachedAccountRepository> logger)
    {
        _innerRepository = innerRepository;
        _cacheService = cacheService;
        _logger = logger;
    }

    public async Task<Account?> GetByIdAsync(int id, CancellationToken ct = default)
    {
        var cacheKey = $"account:{id}";
        
        var cached = await _cacheService.GetAsync<Account>(cacheKey);
        if (cached != null)
        {
            _logger.LogDebug("Cache hit for account {AccountId}", id);
            return cached;
        }

        var account = await _innerRepository.GetByIdAsync(id, ct);
        
        if (account != null)
        {
            await _cacheService.SetAsync(cacheKey, account, TimeSpan.FromMinutes(CacheExpirationMinutes));
        }

        return account;
    }

    public async Task<IEnumerable<Account>> GetAllAsync(CancellationToken ct = default)
    {
        var cacheKey = "account:all";
        
        var cached = await _cacheService.GetAsync<IEnumerable<Account>>(cacheKey);
        if (cached != null)
        {
            _logger.LogDebug("Cache hit for all accounts");
            return cached;
        }

        var accounts = await _innerRepository.GetAllAsync(ct);
        await _cacheService.SetAsync(cacheKey, accounts, TimeSpan.FromMinutes(CacheExpirationMinutes));

        return accounts;
    }

    public async Task<int> AddAsync(Account entity, IDbTransaction transaction, CancellationToken ct = default)
    {
        var id = await _innerRepository.AddAsync(entity, transaction, ct);
        
        // Invalidate related caches
        await InvalidateCachesAsync();
        
        return id;
    }

    public async Task<bool> UpdateAsync(Account entity, IDbTransaction transaction, CancellationToken ct = default)
    {
        var result = await _innerRepository.UpdateAsync(entity, transaction, ct);
        
        if (result)
        {
            // Invalidate specific and related caches
            await _cacheService.DeleteAsync($"account:{entity.Id}");
            await InvalidateCachesAsync();
        }
        
        return result;
    }

    public async Task<bool> DeleteAsync(int id, IDbTransaction transaction, CancellationToken ct = default)
    {
        var result = await _innerRepository.DeleteAsync(id, transaction, ct);
        
        if (result)
        {
            // Invalidate specific and related caches
            await _cacheService.DeleteAsync($"account:{id}");
            await InvalidateCachesAsync();
        }
        
        return result;
    }

    private async Task InvalidateCachesAsync()
    {
        var tasks = new[]
        {
            _cacheService.DeleteAsync("account:all"),
            _cacheService.FlushAsync("account:type:*"),
            _cacheService.FlushAsync("account:child:*")
        };
        
        await Task.WhenAll(tasks);
    }

    // Delegate other methods to inner repository
    public Task<IEnumerable<Account>> GetPagedAsync(int pageNumber, int pageSize, CancellationToken ct = default)
        => _innerRepository.GetPagedAsync(pageNumber, pageSize, ct);

    public Task<int> CountAsync(CancellationToken ct = default)
        => _innerRepository.CountAsync(ct);

    public Task<bool> ExistsAsync(int id, CancellationToken ct = default)
        => _innerRepository.ExistsAsync(id, ct);

    // ... other delegated methods
}
```