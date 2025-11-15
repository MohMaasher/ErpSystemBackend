using System.Data;
using System.Text.Json;
using Dapper;
using ErpBackEnd.Domain.Interfaces;
using Microsoft.Extensions.Logging;

namespace ErpBackEnd.Infrastructure.Services;

public class TransactionLogService : ITransactionLogService
{
    private readonly IDbConnection _connection;
    private readonly ICurrentUserProvider _currentUserProvider;
    private readonly ILogger<TransactionLogService> _logger;

    public TransactionLogService(
        IDbConnection connection,
        ICurrentUserProvider currentUserProvider,
        ILogger<TransactionLogService> logger)
    {
        _connection = connection;
        _currentUserProvider = currentUserProvider;
        _logger = logger;
    }

    public async Task LogInsertAsync<TEntity>(
        string tableName,
        string recordId,
        TEntity newValues,
        IDbTransaction? transaction = null,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        try
        {
            const string sql = @"
                INSERT INTO TransactionLog (
                    TableName, RecordId, Operation, NewValues, Username, Timestamp, IPAddress
                ) VALUES (
                    @TableName, @RecordId, @Operation, @NewValues, @Username, GETDATE(), @IPAddress
                )";

            var newValuesJson = JsonSerializer.Serialize(newValues);

            var command = new CommandDefinition(
                sql,
                new
                {
                    TableName = tableName,
                    RecordId = recordId,
                    Operation = "INSERT",
                    NewValues = newValuesJson,
                    Username = _currentUserProvider.Username,
                    IPAddress = _currentUserProvider.IpAddress
                },
                transaction,
                cancellationToken: cancellationToken);

            await _connection.ExecuteAsync(command);

            _logger.LogInformation(
                "Transaction log: INSERT on {TableName}, RecordId: {RecordId}, User: {Username}",
                tableName, recordId, _currentUserProvider.Username);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error logging INSERT transaction for {TableName}, RecordId: {RecordId}",
                tableName, recordId);
            // Don't throw - logging should not break the application
        }
    }

    public async Task LogUpdateAsync<TEntity>(
        string tableName,
        string recordId,
        TEntity oldValues,
        TEntity newValues,
        IDbTransaction? transaction = null,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        try
        {
            const string sql = @"
                INSERT INTO TransactionLog (
                    TableName, RecordId, Operation, OldValues, NewValues, Username, Timestamp, IPAddress
                ) VALUES (
                    @TableName, @RecordId, @Operation, @OldValues, @NewValues, @Username, GETDATE(), @IPAddress
                )";

            var oldValuesJson = JsonSerializer.Serialize(oldValues);
            var newValuesJson = JsonSerializer.Serialize(newValues);

            var command = new CommandDefinition(
                sql,
                new
                {
                    TableName = tableName,
                    RecordId = recordId,
                    Operation = "UPDATE",
                    OldValues = oldValuesJson,
                    NewValues = newValuesJson,
                    Username = _currentUserProvider.Username,
                    IPAddress = _currentUserProvider.IpAddress
                },
                transaction,
                cancellationToken: cancellationToken);

            await _connection.ExecuteAsync(command);

            _logger.LogInformation(
                "Transaction log: UPDATE on {TableName}, RecordId: {RecordId}, User: {Username}",
                tableName, recordId, _currentUserProvider.Username);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error logging UPDATE transaction for {TableName}, RecordId: {RecordId}",
                tableName, recordId);
            // Don't throw - logging should not break the application
        }
    }

    public async Task LogDeleteAsync<TEntity>(
        string tableName,
        string recordId,
        TEntity oldValues,
        IDbTransaction? transaction = null,
        CancellationToken cancellationToken = default) where TEntity : class
    {
        try
        {
            const string sql = @"
                INSERT INTO TransactionLog (
                    TableName, RecordId, Operation, OldValues, Username, Timestamp, IPAddress
                ) VALUES (
                    @TableName, @RecordId, @Operation, @OldValues, @Username, GETDATE(), @IPAddress
                )";

            var oldValuesJson = JsonSerializer.Serialize(oldValues);

            var command = new CommandDefinition(
                sql,
                new
                {
                    TableName = tableName,
                    RecordId = recordId,
                    Operation = "DELETE",
                    OldValues = oldValuesJson,
                    Username = _currentUserProvider.Username,
                    IPAddress = _currentUserProvider.IpAddress
                },
                transaction,
                cancellationToken: cancellationToken);

            await _connection.ExecuteAsync(command);

            _logger.LogInformation(
                "Transaction log: DELETE on {TableName}, RecordId: {RecordId}, User: {Username}",
                tableName, recordId, _currentUserProvider.Username);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error logging DELETE transaction for {TableName}, RecordId: {RecordId}",
                tableName, recordId);
            // Don't throw - logging should not break the application
        }
    }

    public async Task<IEnumerable<TransactionLogEntry>> GetHistoryAsync(
        string tableName,
        string recordId,
        CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                LogId,
                TableName,
                RecordId,
                Operation,
                OldValues,
                NewValues,
                Username,
                Timestamp,
                IPAddress,
                UserAgent
            FROM TransactionLog
            WHERE TableName = @TableName
              AND RecordId = @RecordId
            ORDER BY Timestamp DESC";

        var command = new CommandDefinition(
            sql,
            new { TableName = tableName, RecordId = recordId },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<TransactionLogEntry>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving transaction history for {TableName}, RecordId: {RecordId}",
                tableName, recordId);
            throw;
        }
    }

    public async Task<IEnumerable<TransactionLogEntry>> GetByUserAsync(
        string username,
        DateTime? fromDate = null,
        DateTime? toDate = null,
        CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                LogId,
                TableName,
                RecordId,
                Operation,
                OldValues,
                NewValues,
                Username,
                Timestamp,
                IPAddress,
                UserAgent
            FROM TransactionLog
            WHERE Username = @Username
              AND (@FromDate IS NULL OR Timestamp >= @FromDate)
              AND (@ToDate IS NULL OR Timestamp <= @ToDate)
            ORDER BY Timestamp DESC";

        var command = new CommandDefinition(
            sql,
            new { Username = username, FromDate = fromDate, ToDate = toDate },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<TransactionLogEntry>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving transaction logs for user {Username}", username);
            throw;
        }
    }

    public async Task<IEnumerable<TransactionLogEntry>> GetByTableAsync(
        string tableName,
        DateTime? fromDate = null,
        DateTime? toDate = null,
        int pageNumber = 1,
        int pageSize = 100,
        CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                LogId,
                TableName,
                RecordId,
                Operation,
                OldValues,
                NewValues,
                Username,
                Timestamp,
                IPAddress,
                UserAgent
            FROM TransactionLog
            WHERE TableName = @TableName
              AND (@FromDate IS NULL OR Timestamp >= @FromDate)
              AND (@ToDate IS NULL OR Timestamp <= @ToDate)
            ORDER BY Timestamp DESC
            OFFSET @Offset ROWS
            FETCH NEXT @PageSize ROWS ONLY";

        var offset = (pageNumber - 1) * pageSize;

        var command = new CommandDefinition(
            sql,
            new
            {
                TableName = tableName,
                FromDate = fromDate,
                ToDate = toDate,
                Offset = offset,
                PageSize = pageSize
            },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<TransactionLogEntry>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving transaction logs for table {TableName}", tableName);
            throw;
        }
    }
}
