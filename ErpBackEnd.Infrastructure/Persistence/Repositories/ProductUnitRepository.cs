using System.Data;
using Dapper;
using ErpBackEnd.Domain.Entities.Inventory;
using ErpBackEnd.Domain.Interfaces;
using ErpBackEnd.Domain.Interfaces.Repositories;
using Microsoft.Extensions.Logging;

namespace ErpBackEnd.Infrastructure.Persistence.Repositories;

public class ProductUnitRepository : IProductUnitRepository
{
    private readonly IDbConnection _connection;
    private readonly ICurrentUserProvider _currentUserProvider;
    private readonly ILogger<ProductUnitRepository> _logger;

    public ProductUnitRepository(
        IDbConnection connection,
        ICurrentUserProvider currentUserProvider,
        ILogger<ProductUnitRepository> logger)
    {
        _connection = connection;
        _currentUserProvider = currentUserProvider;
        _logger = logger;
    }

    public async Task<ProductUnit?> GetByIdAsync(string itemNo, string unitCode, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                unicode AS UnitCode,
                name AS Name,
                scnname AS ScannedName,
                company AS CompanyCode,
                cmbkey AS CombinationKey,
                barcode AS Barcode,
                modelno AS ModelNo,
                openlcost AS OpeningLocalCost,
                lcost AS LocalCost,
                openfcost AS OpeningForeignCost,
                fcost AS ForeignCost,
                lprice1 AS LocalPrice1,
                fprice1 AS ForeignPrice1,
                maxdisc1 AS MaxDiscount1,
                lprice2 AS LocalPrice2,
                fprice2 AS ForeignPrice2,
                maxdisc2 AS MaxDiscount2,
                lprice3 AS LocalPrice3,
                fprice3 AS ForeignPrice3,
                maxdisc3 AS MaxDiscount3,
                mnmprice AS MinimumPrice,
                openbal AS OpeningBalance,
                curbal AS CurrentBalance,
                rsvqty AS ReservedQuantity,
                minstk AS MinimumStock,
                maxstk AS MaximumStock,
                orderlevel AS ReorderLevel,
                leadday AS LeadDays,
                packtp AS PackingType,
                pack0 AS Pack0,
                pack1 AS Pack1,
                pkqty1 AS PackQuantity1,
                pack2 AS Pack2,
                pkqty2 AS PackQuantity2,
                pack3 AS Pack3,
                pkqty3 AS PackQuantity3,
                lrcvdate AS LastReceivedDate,
                lastissue AS LastIssueDate,
                crtdate AS CreationDate,
                lastupdt AS LastUpdateDate,
                prmcode AS PromotionCode,
                scncode AS ScanCode,
                moved AS Moved,
                Xdecimal AS AllowDecimal,
                inactive AS IsInactive,
                modified AS Modified,
                splyitemno AS SupplierItemNo,
                splyinv AS SupplierInvoice,
                invprice AS InvoicePrice,
                invqty AS InvoiceQuantity,
                invpk AS InvoicePack,
                pp2 AS ProfitPercent2,
                pp3 AS ProfitPercent3
            FROM stunits
            WHERE itemno = @ItemNo AND unicode = @UnitCode";

        var command = new CommandDefinition(
            sql,
            new { ItemNo = itemNo, UnitCode = unitCode },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QuerySingleOrDefaultAsync<ProductUnit>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving product unit {ItemNo}-{UnitCode}", itemNo, unitCode);
            throw;
        }
    }

    public async Task<IEnumerable<ProductUnit>> GetByItemNoAsync(string itemNo, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                unicode AS UnitCode,
                name AS Name,
                barcode AS Barcode,
                lcost AS LocalCost,
                lprice1 AS LocalPrice1,
                lprice2 AS LocalPrice2,
                lprice3 AS LocalPrice3,
                mnmprice AS MinimumPrice,
                curbal AS CurrentBalance,
                rsvqty AS ReservedQuantity,
                minstk AS MinimumStock,
                maxstk AS MaximumStock,
                orderlevel AS ReorderLevel,
                inactive AS IsInactive
            FROM stunits
            WHERE itemno = @ItemNo
            ORDER BY unicode";

        var command = new CommandDefinition(sql, new { ItemNo = itemNo }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<ProductUnit>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving product units for ItemNo {ItemNo}", itemNo);
            throw;
        }
    }

    public async Task<ProductUnit?> GetByBarcodeAsync(string barcode, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                unicode AS UnitCode,
                name AS Name,
                barcode AS Barcode,
                lcost AS LocalCost,
                lprice1 AS LocalPrice1,
                mnmprice AS MinimumPrice,
                curbal AS CurrentBalance
            FROM stunits
            WHERE barcode = @Barcode";

        var command = new CommandDefinition(sql, new { Barcode = barcode }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QuerySingleOrDefaultAsync<ProductUnit>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving product unit by barcode {Barcode}", barcode);
            throw;
        }
    }

    public async Task<IEnumerable<ProductUnit>> GetByCombinationKeyAsync(string combinationKey, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                unicode AS UnitCode,
                name AS Name,
                cmbkey AS CombinationKey,
                curbal AS CurrentBalance
            FROM stunits
            WHERE cmbkey = @CombinationKey
            ORDER BY itemno, unicode";

        var command = new CommandDefinition(sql, new { CombinationKey = combinationKey }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<ProductUnit>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving product units by combination key {CombinationKey}", combinationKey);
            throw;
        }
    }

    public async Task<IEnumerable<ProductUnit>> GetBelowMinimumStockAsync(CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                unicode AS UnitCode,
                name AS Name,
                curbal AS CurrentBalance,
                minstk AS MinimumStock,
                orderlevel AS ReorderLevel
            FROM stunits
            WHERE ISNULL(curbal, 0) < minstk
              AND inactive = 0
            ORDER BY itemno, unicode";

        var command = new CommandDefinition(sql, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<ProductUnit>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving products below minimum stock");
            throw;
        }
    }

    public async Task<IEnumerable<ProductUnit>> GetAtReorderLevelAsync(CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                unicode AS UnitCode,
                name AS Name,
                curbal AS CurrentBalance,
                orderlevel AS ReorderLevel,
                leadday AS LeadDays
            FROM stunits
            WHERE ISNULL(curbal, 0) <= orderlevel
              AND inactive = 0
              AND orderlevel > 0
            ORDER BY itemno, unicode";

        var command = new CommandDefinition(sql, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<ProductUnit>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving products at reorder level");
            throw;
        }
    }

    public async Task<IEnumerable<ProductUnit>> GetInactiveUnitsAsync(CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                unicode AS UnitCode,
                name AS Name,
                inactive AS IsInactive,
                lastupdt AS LastUpdateDate
            FROM stunits
            WHERE inactive = 1
            ORDER BY itemno, unicode";

        var command = new CommandDefinition(sql, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<ProductUnit>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving inactive product units");
            throw;
        }
    }

    public async Task<bool> AddAsync(ProductUnit productUnit, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            INSERT INTO stunits (
                itemno, unicode, name, scnname, company, cmbkey, barcode, modelno,
                openlcost, lcost, openfcost, fcost,
                lprice1, fprice1, maxdisc1,
                lprice2, fprice2, maxdisc2,
                lprice3, fprice3, maxdisc3,
                mnmprice, openbal, curbal, rsvqty,
                minstk, maxstk, orderlevel, leadday,
                packtp, pack0, pack1, pkqty1, pack2, pkqty2, pack3, pkqty3,
                lrcvdate, lastissue, crtdate, lastupdt,
                prmcode, scncode, moved, Xdecimal, inactive, modified
            ) VALUES (
                @ItemNo, @UnitCode, @Name, @ScannedName, @CompanyCode, @CombinationKey, @Barcode, @ModelNo,
                @OpeningLocalCost, @LocalCost, @OpeningForeignCost, @ForeignCost,
                @LocalPrice1, @ForeignPrice1, @MaxDiscount1,
                @LocalPrice2, @ForeignPrice2, @MaxDiscount2,
                @LocalPrice3, @ForeignPrice3, @MaxDiscount3,
                @MinimumPrice, @OpeningBalance, @CurrentBalance, @ReservedQuantity,
                @MinimumStock, @MaximumStock, @ReorderLevel, @LeadDays,
                @PackingType, @Pack0, @Pack1, @PackQuantity1, @Pack2, @PackQuantity2, @Pack3, @PackQuantity3,
                @LastReceivedDate, @LastIssueDate, CONVERT(VARCHAR(8), GETDATE(), 112), CONVERT(VARCHAR(8), GETDATE(), 112),
                @PromotionCode, @ScanCode, @Moved, @AllowDecimal, @IsInactive, 1
            )";

        var command = new CommandDefinition(sql, productUnit, transaction, cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Product unit created {ItemNo}-{UnitCode}", productUnit.ItemNo, productUnit.UnitCode);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating product unit {ItemNo}-{UnitCode}", productUnit.ItemNo, productUnit.UnitCode);
            throw;
        }
    }

    public async Task<bool> UpdateAsync(ProductUnit productUnit, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            UPDATE stunits SET
                name = @Name,
                lcost = @LocalCost,
                fcost = @ForeignCost,
                lprice1 = @LocalPrice1,
                lprice2 = @LocalPrice2,
                lprice3 = @LocalPrice3,
                fprice1 = @ForeignPrice1,
                fprice2 = @ForeignPrice2,
                fprice3 = @ForeignPrice3,
                maxdisc1 = @MaxDiscount1,
                maxdisc2 = @MaxDiscount2,
                maxdisc3 = @MaxDiscount3,
                mnmprice = @MinimumPrice,
                minstk = @MinimumStock,
                maxstk = @MaximumStock,
                orderlevel = @ReorderLevel,
                leadday = @LeadDays,
                inactive = @IsInactive,
                lastupdt = CONVERT(VARCHAR(8), GETDATE(), 112),
                modified = 1
            WHERE itemno = @ItemNo AND unicode = @UnitCode";

        var command = new CommandDefinition(sql, productUnit, transaction, cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Product unit updated {ItemNo}-{UnitCode}", productUnit.ItemNo, productUnit.UnitCode);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating product unit {ItemNo}-{UnitCode}", productUnit.ItemNo, productUnit.UnitCode);
            throw;
        }
    }

    public async Task<bool> UpdateStockBalanceAsync(string itemNo, string unitCode, decimal quantityChange, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            UPDATE stunits SET
                curbal = ISNULL(curbal, 0) + @QuantityChange,
                lastupdt = CONVERT(VARCHAR(8), GETDATE(), 112),
                modified = 1
            WHERE itemno = @ItemNo AND unicode = @UnitCode";

        var command = new CommandDefinition(
            sql,
            new { ItemNo = itemNo, UnitCode = unitCode, QuantityChange = quantityChange },
            transaction,
            cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Stock balance updated for {ItemNo}-{UnitCode}, change: {QuantityChange}",
                    itemNo, unitCode, quantityChange);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating stock balance for {ItemNo}-{UnitCode}", itemNo, unitCode);
            throw;
        }
    }

    public async Task<bool> UpdateReservedQuantityAsync(string itemNo, string unitCode, decimal quantityChange, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            UPDATE stunits SET
                rsvqty = ISNULL(rsvqty, 0) + @QuantityChange,
                lastupdt = CONVERT(VARCHAR(8), GETDATE(), 112),
                modified = 1
            WHERE itemno = @ItemNo AND unicode = @UnitCode";

        var command = new CommandDefinition(
            sql,
            new { ItemNo = itemNo, UnitCode = unitCode, QuantityChange = quantityChange },
            transaction,
            cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Reserved quantity updated for {ItemNo}-{UnitCode}, change: {QuantityChange}",
                    itemNo, unitCode, quantityChange);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating reserved quantity for {ItemNo}-{UnitCode}", itemNo, unitCode);
            throw;
        }
    }

    public async Task<bool> DeleteAsync(string itemNo, string unitCode, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        // Hard delete as per requirements
        const string sql = "DELETE FROM stunits WHERE itemno = @ItemNo AND unicode = @UnitCode";
        var command = new CommandDefinition(
            sql,
            new { ItemNo = itemNo, UnitCode = unitCode },
            transaction,
            cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Product unit deleted {ItemNo}-{UnitCode}", itemNo, unitCode);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting product unit {ItemNo}-{UnitCode}", itemNo, unitCode);
            throw;
        }
    }
}
