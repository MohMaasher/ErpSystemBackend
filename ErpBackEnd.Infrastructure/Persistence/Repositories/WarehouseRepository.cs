using System.Data;
using Dapper;
using ErpBackEnd.Domain.Entities.Inventory;
using ErpBackEnd.Domain.Interfaces;
using ErpBackEnd.Domain.Interfaces.Repositories;
using Microsoft.Extensions.Logging;

namespace ErpBackEnd.Infrastructure.Persistence.Repositories;

public class WarehouseRepository : IWarehouseRepository
{
    private readonly IDbConnection _connection;
    private readonly ICurrentUserProvider _currentUserProvider;
    private readonly ILogger<WarehouseRepository> _logger;

    public WarehouseRepository(
        IDbConnection connection,
        ICurrentUserProvider currentUserProvider,
        ILogger<WarehouseRepository> logger)
    {
        _connection = connection;
        _currentUserProvider = currentUserProvider;
        _logger = logger;
    }

    public async Task<Warehouse?> GetByIdAsync(string warehouseNo, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                whno AS WarehouseNo,
                name AS NameEn,
                lname AS NameAr,
                branch AS BranchCode,
                manager AS Manager,
                phone AS Phone,
                fax AS Fax,
                address AS Address,
                srwhs AS SerialAccount,
                cstcode AS CostCenterCode,
                sc_code AS SalesCenterCode,
                prnt_fsh AS PrintFinishedGoods,
                ac_end_prd AS AccountEndOfPeriod,
                no_autosales AS NoAutoSales,
                suspended AS IsSuspended,
                binsrlno AS BinSerialNo,
                xfrfm_mustbinnno AS TransferFromRequiresBin,
                xfrto_mustbinnno AS TransferToRequiresBin,
                lastupdt AS LastUpdateDate,
                modified AS Modified
            FROM stwhous
            WHERE whno = @WarehouseNo";

        var command = new CommandDefinition(sql, new { WarehouseNo = warehouseNo }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QuerySingleOrDefaultAsync<Warehouse>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving warehouse with WarehouseNo {WarehouseNo}", warehouseNo);
            throw;
        }
    }

    public async Task<Warehouse?> GetWithStockBinsAsync(string warehouseNo, CancellationToken cancellationToken = default)
    {
        const string warehouseSql = @"
            SELECT
                whno AS WarehouseNo,
                name AS NameEn,
                lname AS NameAr,
                branch AS BranchCode,
                manager AS Manager,
                phone AS Phone,
                address AS Address,
                suspended AS IsSuspended
            FROM stwhous
            WHERE whno = @WarehouseNo";

        const string binsSql = @"
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
            WHERE whno = @WarehouseNo";

        var warehouseCommand = new CommandDefinition(warehouseSql, new { WarehouseNo = warehouseNo }, cancellationToken: cancellationToken);
        var binsCommand = new CommandDefinition(binsSql, new { WarehouseNo = warehouseNo }, cancellationToken: cancellationToken);

        try
        {
            var warehouse = await _connection.QuerySingleOrDefaultAsync<Warehouse>(warehouseCommand);

            if (warehouse != null)
            {
                var bins = await _connection.QueryAsync<StockBin>(binsCommand);
                warehouse.StockBins = bins.ToList();
            }

            return warehouse;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving warehouse with stock bins for WarehouseNo {WarehouseNo}", warehouseNo);
            throw;
        }
    }

    public async Task<IEnumerable<Warehouse>> GetAllAsync(int pageNumber = 1, int pageSize = 100, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                whno AS WarehouseNo,
                name AS NameEn,
                lname AS NameAr,
                branch AS BranchCode,
                manager AS Manager,
                phone AS Phone,
                suspended AS IsSuspended
            FROM stwhous
            ORDER BY whno
            OFFSET @Offset ROWS
            FETCH NEXT @PageSize ROWS ONLY";

        var offset = (pageNumber - 1) * pageSize;
        var command = new CommandDefinition(
            sql,
            new { Offset = offset, PageSize = pageSize },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<Warehouse>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving all warehouses");
            throw;
        }
    }

    public async Task<string> AddAsync(Warehouse entity, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            INSERT INTO stwhous (
                whno, name, lname, branch, manager, phone, fax, address,
                srwhs, cstcode, sc_code, prnt_fsh, ac_end_prd, no_autosales,
                suspended, binsrlno, xfrfm_mustbinnno, xfrto_mustbinnno,
                lastupdt, modified
            ) VALUES (
                @WarehouseNo, @NameEn, @NameAr, @BranchCode, @Manager, @Phone, @Fax, @Address,
                @SerialAccount, @CostCenterCode, @SalesCenterCode, @PrintFinishedGoods,
                @AccountEndOfPeriod, @NoAutoSales, @IsSuspended, @BinSerialNo,
                @TransferFromRequiresBin, @TransferToRequiresBin, CONVERT(VARCHAR(8), GETDATE(), 112), 1
            )";

        var command = new CommandDefinition(sql, entity, transaction, cancellationToken: cancellationToken);

        try
        {
            await _connection.ExecuteAsync(command);

            _logger.LogInformation("Warehouse created with WarehouseNo {WarehouseNo}", entity.WarehouseNo);
            return entity.WarehouseNo;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating warehouse with WarehouseNo {WarehouseNo}", entity.WarehouseNo);
            throw;
        }
    }

    public async Task<bool> UpdateAsync(Warehouse entity, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            UPDATE stwhous SET
                name = @NameEn,
                lname = @NameAr,
                branch = @BranchCode,
                manager = @Manager,
                phone = @Phone,
                fax = @Fax,
                address = @Address,
                no_autosales = @NoAutoSales,
                suspended = @IsSuspended,
                lastupdt = CONVERT(VARCHAR(8), GETDATE(), 112),
                modified = 1
            WHERE whno = @WarehouseNo";

        var command = new CommandDefinition(sql, entity, transaction, cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Warehouse {WarehouseNo} updated", entity.WarehouseNo);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating warehouse {WarehouseNo}", entity.WarehouseNo);
            throw;
        }
    }

    public async Task<bool> DeleteAsync(string warehouseNo, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        // Hard delete as per requirements
        const string sql = "DELETE FROM stwhous WHERE whno = @WarehouseNo";
        var command = new CommandDefinition(sql, new { WarehouseNo = warehouseNo }, transaction, cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Warehouse {WarehouseNo} deleted", warehouseNo);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting warehouse {WarehouseNo}", warehouseNo);
            throw;
        }
    }

    public async Task<bool> ExistsAsync(string warehouseNo, CancellationToken cancellationToken = default)
    {
        const string sql = "SELECT COUNT(1) FROM stwhous WHERE whno = @WarehouseNo";
        var command = new CommandDefinition(sql, new { WarehouseNo = warehouseNo }, cancellationToken: cancellationToken);

        try
        {
            var count = await _connection.ExecuteScalarAsync<int>(command);
            return count > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error checking if warehouse exists with WarehouseNo {WarehouseNo}", warehouseNo);
            throw;
        }
    }

    public async Task<int> CountAsync(CancellationToken cancellationToken = default)
    {
        const string sql = "SELECT COUNT(*) FROM stwhous";
        var command = new CommandDefinition(sql, cancellationToken: cancellationToken);

        try
        {
            return await _connection.ExecuteScalarAsync<int>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error counting warehouses");
            throw;
        }
    }

    public async Task<IEnumerable<Warehouse>> GetByBranchAsync(string branchCode, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                whno AS WarehouseNo,
                name AS NameEn,
                lname AS NameAr,
                branch AS BranchCode,
                manager AS Manager,
                suspended AS IsSuspended
            FROM stwhous
            WHERE branch = @BranchCode
            ORDER BY whno";

        var command = new CommandDefinition(sql, new { BranchCode = branchCode }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<Warehouse>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving warehouses by branch {BranchCode}", branchCode);
            throw;
        }
    }

    public async Task<IEnumerable<Warehouse>> GetActiveWarehousesAsync(CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                whno AS WarehouseNo,
                name AS NameEn,
                lname AS NameAr,
                branch AS BranchCode,
                manager AS Manager
            FROM stwhous
            WHERE suspended = 0
            ORDER BY whno";

        var command = new CommandDefinition(sql, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<Warehouse>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving active warehouses");
            throw;
        }
    }

    public async Task<IEnumerable<Warehouse>> GetNonSuspendedWarehousesAsync(CancellationToken cancellationToken = default)
    {
        return await GetActiveWarehousesAsync(cancellationToken);
    }

    public async Task<bool> WarehouseExistsAsync(string warehouseNo, CancellationToken cancellationToken = default)
    {
        return await ExistsAsync(warehouseNo, cancellationToken);
    }
}
