using System.Data;

namespace ErpBackEnd.Domain.Interfaces;

/// <summary>
/// Service for logging all data changes for audit trail
/// As per CLAUDE.md - Hard delete + TransactionLog for history
/// </summary>
public interface ITransactionLogService
{
    /// <summary>
    /// Log an INSERT operation
    /// </summary>
    Task LogInsertAsync<TEntity>(string tableName, string recordId, TEntity newValues, IDbTransaction? transaction = null, CancellationToken cancellationToken = default) where TEntity : class;

    /// <summary>
    /// Log an UPDATE operation
    /// </summary>
    Task LogUpdateAsync<TEntity>(string tableName, string recordId, TEntity oldValues, TEntity newValues, IDbTransaction? transaction = null, CancellationToken cancellationToken = default) where TEntity : class;

    /// <summary>
    /// Log a DELETE operation
    /// </summary>
    Task LogDeleteAsync<TEntity>(string tableName, string recordId, TEntity oldValues, IDbTransaction? transaction = null, CancellationToken cancellationToken = default) where TEntity : class;

    /// <summary>
    /// Get transaction history for a specific record
    /// </summary>
    Task<IEnumerable<TransactionLogEntry>> GetHistoryAsync(string tableName, string recordId, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get all changes by a specific user
    /// </summary>
    Task<IEnumerable<TransactionLogEntry>> GetByUserAsync(string username, DateTime? fromDate = null, DateTime? toDate = null, CancellationToken cancellationToken = default);

    /// <summary>
    /// Get all changes for a specific table
    /// </summary>
    Task<IEnumerable<TransactionLogEntry>> GetByTableAsync(string tableName, DateTime? fromDate = null, DateTime? toDate = null, int pageNumber = 1, int pageSize = 100, CancellationToken cancellationToken = default);
}

/// <summary>
/// Represents a transaction log entry
/// </summary>
public class TransactionLogEntry
{
    public long LogId { get; set; }
    public string TableName { get; set; } = string.Empty;
    public string RecordId { get; set; } = string.Empty;
    public string Operation { get; set; } = string.Empty; // INSERT, UPDATE, DELETE
    public string? OldValues { get; set; }
    public string? NewValues { get; set; }
    public string Username { get; set; } = string.Empty;
    public DateTime Timestamp { get; set; }
    public string? IPAddress { get; set; }
    public string? UserAgent { get; set; }
}
