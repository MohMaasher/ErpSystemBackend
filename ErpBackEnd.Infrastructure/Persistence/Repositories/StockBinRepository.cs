using System.Data;
using Dapper;
using ErpBackEnd.Domain.Entities.Inventory;
using ErpBackEnd.Domain.Interfaces;
using ErpBackEnd.Domain.Interfaces.Repositories;
using Microsoft.Extensions.Logging;

namespace ErpBackEnd.Infrastructure.Persistence.Repositories;

public class StockBinRepository : IStockBinRepository
{
    private readonly IDbConnection _connection;
    private readonly ICurrentUserProvider _currentUserProvider;
    private readonly ILogger<StockBinRepository> _logger;

    public StockBinRepository(
        IDbConnection connection,
        ICurrentUserProvider currentUserProvider,
        ILogger<StockBinRepository> logger)
    {
        _connection = connection;
        _currentUserProvider = currentUserProvider;
        _logger = logger;
    }

    public async Task<StockBin?> GetByIdAsync(string branchCode, string itemNo, string unitCode, string warehouseNo, string binNo, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                branch AS BranchCode,
                itemno AS ItemNo,
                unicode AS UnitCode,
                whno AS WarehouseNo,
                binno AS BinNo,
                qty AS Quantity,
                rsvqty AS ReservedQuantity,
                openbal AS OpeningBalance,
                lcost AS LocalCost,
                fcost AS ForeignCost,
                openlcost AS OpeningLocalCost,
                openfcost AS OpeningForeignCost,
                expdate AS ExpiryDate
            FROM stbins
            WHERE branch = @BranchCode
              AND itemno = @ItemNo
              AND unicode = @UnitCode
              AND whno = @WarehouseNo
              AND binno = @BinNo";

        var command = new CommandDefinition(
            sql,
            new { BranchCode = branchCode, ItemNo = itemNo, UnitCode = unitCode, WarehouseNo = warehouseNo, BinNo = binNo },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QuerySingleOrDefaultAsync<StockBin>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving stock bin {BranchCode}-{ItemNo}-{UnitCode}-{WarehouseNo}-{BinNo}",
                branchCode, itemNo, unitCode, warehouseNo, binNo);
            throw;
        }
    }

    public async Task<IEnumerable<StockBin>> GetByProductAndWarehouseAsync(string itemNo, string unitCode, string warehouseNo, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                branch AS BranchCode,
                itemno AS ItemNo,
                unicode AS UnitCode,
                whno AS WarehouseNo,
                binno AS BinNo,
                qty AS Quantity,
                rsvqty AS ReservedQuantity,
                lcost AS LocalCost,
                expdate AS ExpiryDate
            FROM stbins
            WHERE itemno = @ItemNo
              AND unicode = @UnitCode
              AND whno = @WarehouseNo
            ORDER BY binno";

        var command = new CommandDefinition(
            sql,
            new { ItemNo = itemNo, UnitCode = unitCode, WarehouseNo = warehouseNo },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<StockBin>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving stock bins for {ItemNo}-{UnitCode} in warehouse {WarehouseNo}",
                itemNo, unitCode, warehouseNo);
            throw;
        }
    }

    public async Task<IEnumerable<StockBin>> GetByWarehouseAsync(string warehouseNo, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                branch AS BranchCode,
                itemno AS ItemNo,
                unicode AS UnitCode,
                whno AS WarehouseNo,
                binno AS BinNo,
                qty AS Quantity,
                rsvqty AS ReservedQuantity,
                lcost AS LocalCost
            FROM stbins
            WHERE whno = @WarehouseNo
            ORDER BY itemno, unicode, binno";

        var command = new CommandDefinition(sql, new { WarehouseNo = warehouseNo }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<StockBin>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving stock bins for warehouse {WarehouseNo}", warehouseNo);
            throw;
        }
    }

    public async Task<IEnumerable<StockBin>> GetByProductAsync(string itemNo, string unitCode, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                branch AS BranchCode,
                itemno AS ItemNo,
                unicode AS UnitCode,
                whno AS WarehouseNo,
                binno AS BinNo,
                qty AS Quantity,
                rsvqty AS ReservedQuantity,
                lcost AS LocalCost,
                expdate AS ExpiryDate
            FROM stbins
            WHERE itemno = @ItemNo
              AND unicode = @UnitCode
            ORDER BY whno, binno";

        var command = new CommandDefinition(
            sql,
            new { ItemNo = itemNo, UnitCode = unitCode },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<StockBin>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving stock bins for product {ItemNo}-{UnitCode}", itemNo, unitCode);
            throw;
        }
    }

    public async Task<decimal> GetTotalAvailableQuantityAsync(string itemNo, string unitCode, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT ISNULL(SUM(ISNULL(qty, 0) - ISNULL(rsvqty, 0)), 0)
            FROM stbins
            WHERE itemno = @ItemNo
              AND unicode = @UnitCode";

        var command = new CommandDefinition(
            sql,
            new { ItemNo = itemNo, UnitCode = unitCode },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.ExecuteScalarAsync<decimal>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting total available quantity for {ItemNo}-{UnitCode}", itemNo, unitCode);
            throw;
        }
    }

    public async Task<IEnumerable<StockBin>> GetExpiringStockAsync(int daysUntilExpiry, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                branch AS BranchCode,
                itemno AS ItemNo,
                unicode AS UnitCode,
                whno AS WarehouseNo,
                binno AS BinNo,
                qty AS Quantity,
                expdate AS ExpiryDate,
                lcost AS LocalCost
            FROM stbins
            WHERE expdate != ''
              AND expdate != '00000000'
              AND CAST(expdate AS DATE) <= DATEADD(DAY, @DaysUntilExpiry, GETDATE())
              AND CAST(expdate AS DATE) > GETDATE()
              AND ISNULL(qty, 0) > 0
            ORDER BY expdate, itemno";

        var command = new CommandDefinition(
            sql,
            new { DaysUntilExpiry = daysUntilExpiry },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<StockBin>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving expiring stock within {DaysUntilExpiry} days", daysUntilExpiry);
            throw;
        }
    }

    public async Task<IEnumerable<StockBin>> GetExpiredStockAsync(CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                branch AS BranchCode,
                itemno AS ItemNo,
                unicode AS UnitCode,
                whno AS WarehouseNo,
                binno AS BinNo,
                qty AS Quantity,
                expdate AS ExpiryDate,
                lcost AS LocalCost
            FROM stbins
            WHERE expdate != ''
              AND expdate != '00000000'
              AND CAST(expdate AS DATE) < GETDATE()
              AND ISNULL(qty, 0) > 0
            ORDER BY expdate, itemno";

        var command = new CommandDefinition(sql, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<StockBin>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving expired stock");
            throw;
        }
    }

    public async Task<bool> AddAsync(StockBin stockBin, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            INSERT INTO stbins (
                branch, itemno, unicode, whno, binno,
                qty, rsvqty, openbal, lcost, fcost,
                openlcost, openfcost, expdate
            ) VALUES (
                @BranchCode, @ItemNo, @UnitCode, @WarehouseNo, @BinNo,
                @Quantity, @ReservedQuantity, @OpeningBalance, @LocalCost, @ForeignCost,
                @OpeningLocalCost, @OpeningForeignCost, @ExpiryDate
            )";

        var command = new CommandDefinition(sql, stockBin, transaction, cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Stock bin created {ItemNo}-{UnitCode} in {WarehouseNo}/{BinNo}",
                    stockBin.ItemNo, stockBin.UnitCode, stockBin.WarehouseNo, stockBin.BinNo);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating stock bin {ItemNo}-{UnitCode} in {WarehouseNo}/{BinNo}",
                stockBin.ItemNo, stockBin.UnitCode, stockBin.WarehouseNo, stockBin.BinNo);
            throw;
        }
    }

    public async Task<bool> UpdateQuantityAsync(string branchCode, string itemNo, string unitCode, string warehouseNo, string binNo, decimal quantityChange, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            UPDATE stbins SET
                qty = ISNULL(qty, 0) + @QuantityChange
            WHERE branch = @BranchCode
              AND itemno = @ItemNo
              AND unicode = @UnitCode
              AND whno = @WarehouseNo
              AND binno = @BinNo";

        var command = new CommandDefinition(
            sql,
            new { BranchCode = branchCode, ItemNo = itemNo, UnitCode = unitCode, WarehouseNo = warehouseNo, BinNo = binNo, QuantityChange = quantityChange },
            transaction,
            cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Stock bin quantity updated {ItemNo}-{UnitCode} in {WarehouseNo}/{BinNo}, change: {QuantityChange}",
                    itemNo, unitCode, warehouseNo, binNo, quantityChange);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating stock bin quantity {ItemNo}-{UnitCode} in {WarehouseNo}/{BinNo}",
                itemNo, unitCode, warehouseNo, binNo);
            throw;
        }
    }

    public async Task<bool> UpdateReservedQuantityAsync(string branchCode, string itemNo, string unitCode, string warehouseNo, string binNo, decimal quantityChange, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            UPDATE stbins SET
                rsvqty = ISNULL(rsvqty, 0) + @QuantityChange
            WHERE branch = @BranchCode
              AND itemno = @ItemNo
              AND unicode = @UnitCode
              AND whno = @WarehouseNo
              AND binno = @BinNo";

        var command = new CommandDefinition(
            sql,
            new { BranchCode = branchCode, ItemNo = itemNo, UnitCode = unitCode, WarehouseNo = warehouseNo, BinNo = binNo, QuantityChange = quantityChange },
            transaction,
            cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Stock bin reserved quantity updated {ItemNo}-{UnitCode} in {WarehouseNo}/{BinNo}, change: {QuantityChange}",
                    itemNo, unitCode, warehouseNo, binNo, quantityChange);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating stock bin reserved quantity {ItemNo}-{UnitCode} in {WarehouseNo}/{BinNo}",
                itemNo, unitCode, warehouseNo, binNo);
            throw;
        }
    }

    public async Task<bool> TransferBetweenBinsAsync(string branchCode, string itemNo, string unitCode, string fromWarehouse, string fromBin, string toWarehouse, string toBin, decimal quantity, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        // Decrease quantity in source bin
        const string decreaseSql = @"
            UPDATE stbins SET
                qty = ISNULL(qty, 0) - @Quantity
            WHERE branch = @BranchCode
              AND itemno = @ItemNo
              AND unicode = @UnitCode
              AND whno = @FromWarehouse
              AND binno = @FromBin";

        // Increase quantity in destination bin
        const string increaseSql = @"
            UPDATE stbins SET
                qty = ISNULL(qty, 0) + @Quantity
            WHERE branch = @BranchCode
              AND itemno = @ItemNo
              AND unicode = @UnitCode
              AND whno = @ToWarehouse
              AND binno = @ToBin";

        var decreaseCommand = new CommandDefinition(
            decreaseSql,
            new { BranchCode = branchCode, ItemNo = itemNo, UnitCode = unitCode, FromWarehouse = fromWarehouse, FromBin = fromBin, Quantity = quantity },
            transaction,
            cancellationToken: cancellationToken);

        var increaseCommand = new CommandDefinition(
            increaseSql,
            new { BranchCode = branchCode, ItemNo = itemNo, UnitCode = unitCode, ToWarehouse = toWarehouse, ToBin = toBin, Quantity = quantity },
            transaction,
            cancellationToken: cancellationToken);

        try
        {
            var decreaseRows = await _connection.ExecuteAsync(decreaseCommand);
            var increaseRows = await _connection.ExecuteAsync(increaseCommand);

            if (decreaseRows > 0 && increaseRows > 0)
            {
                _logger.LogInformation("Stock transferred {ItemNo}-{UnitCode}: {FromWarehouse}/{FromBin} -> {ToWarehouse}/{ToBin}, quantity: {Quantity}",
                    itemNo, unitCode, fromWarehouse, fromBin, toWarehouse, toBin, quantity);
            }

            return decreaseRows > 0 && increaseRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error transferring stock {ItemNo}-{UnitCode} between bins", itemNo, unitCode);
            throw;
        }
    }

    public async Task<bool> DeleteAsync(string branchCode, string itemNo, string unitCode, string warehouseNo, string binNo, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        // Hard delete as per requirements
        const string sql = @"
            DELETE FROM stbins
            WHERE branch = @BranchCode
              AND itemno = @ItemNo
              AND unicode = @UnitCode
              AND whno = @WarehouseNo
              AND binno = @BinNo";

        var command = new CommandDefinition(
            sql,
            new { BranchCode = branchCode, ItemNo = itemNo, UnitCode = unitCode, WarehouseNo = warehouseNo, BinNo = binNo },
            transaction,
            cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Stock bin deleted {ItemNo}-{UnitCode} in {WarehouseNo}/{BinNo}",
                    itemNo, unitCode, warehouseNo, binNo);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting stock bin {ItemNo}-{UnitCode} in {WarehouseNo}/{BinNo}",
                itemNo, unitCode, warehouseNo, binNo);
            throw;
        }
    }
}
