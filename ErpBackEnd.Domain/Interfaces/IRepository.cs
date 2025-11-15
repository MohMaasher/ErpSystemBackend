using System.Data;

namespace ErpBackEnd.Domain.Interfaces;

/// <summary>
/// Base repository interface for common CRUD operations
/// </summary>
/// <typeparam name="TEntity">Entity type</typeparam>
/// <typeparam name="TKey">Primary key type</typeparam>
public interface IRepository<TEntity, TKey> where TEntity : class
{
    /// <summary>
    /// Get entity by ID
    /// </summary>
    Task<TEntity?> GetByIdAsync(TKey id, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get all entities with optional pagination
    /// </summary>
    Task<IEnumerable<TEntity>> GetAllAsync(int pageNumber = 1, int pageSize = 100, CancellationToken cancellationToken = default);

    /// <summary>
    /// Add new entity
    /// </summary>
    Task<TKey> AddAsync(TEntity entity, IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Update existing entity
    /// </summary>
    Task<bool> UpdateAsync(TEntity entity, IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Delete entity by ID (hard delete as per requirements)
    /// </summary>
    Task<bool> DeleteAsync(TKey id, IDbTransaction? transaction = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Check if entity exists
    /// </summary>
    Task<bool> ExistsAsync(TKey id, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get total count of entities
    /// </summary>
    Task<int> CountAsync(CancellationToken cancellationToken = default);
}
