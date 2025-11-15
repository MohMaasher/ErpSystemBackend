using System.Data;
using Dapper;
using ErpBackEnd.Domain.Entities.Inventory;
using ErpBackEnd.Domain.Interfaces;
using ErpBackEnd.Domain.Interfaces.Repositories;
using Microsoft.Extensions.Logging;

namespace ErpBackEnd.Infrastructure.Persistence.Repositories;

public class ProductRepository : IProductRepository
{
    private readonly IDbConnection _connection;
    private readonly ICurrentUserProvider _currentUserProvider;
    private readonly ILogger<ProductRepository> _logger;

    public ProductRepository(
        IDbConnection connection,
        ICurrentUserProvider currentUserProvider,
        ILogger<ProductRepository> logger)
    {
        _connection = connection;
        _currentUserProvider = currentUserProvider;
        _logger = logger;
    }

    public async Task<Product?> GetByIdAsync(string itemNo, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                name AS NameEn,
                lname AS NameAr,
                mgroup AS MainGroup,
                sgroup AS SubGroup,
                category AS Category,
                sgroup3 AS SubGroup3,
                sgroup4 AS SubGroup4,
                classkey AS ClassKey,
                fcy AS CurrencyCode,
                company AS CompanyCode,
                country AS CountryCode,
                season AS Season,
                splycode AS SupplierCode,
                msplycode AS MainSupplierCode,
                brand_id AS BrandId,
                modelno AS ModelNo,
                itemtype AS ItemType,
                taxtype AS TaxType,
                taxfree AS IsTaxFree,
                nosales AS NoSales,
                exdatealw AS AllowsExpiryDate,
                noofsbitem AS NumberOfSubItems,
                prntasmitm AS PrintAsAssembledItem,
                cmpprcnt AS ComparePrices,
                dsctype AS DiscountType,
                prmdesc AS PrimaryDescription,
                scndesc AS SecondaryDescription,
                splylcact AS SupplierLocalCurrency,
                vprice AS VATPrice,
                fix_barcode AS FixedBarcode,
                modified AS Modified
            FROM stitems
            WHERE itemno = @ItemNo";

        var command = new CommandDefinition(sql, new { ItemNo = itemNo }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QuerySingleOrDefaultAsync<Product>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving product with ItemNo {ItemNo}", itemNo);
            throw;
        }
    }

    public async Task<Product?> GetWithDetailsAsync(string itemNo, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                name AS NameEn,
                lname AS NameAr,
                mgroup AS MainGroup,
                sgroup AS SubGroup,
                category AS Category,
                classkey AS ClassKey,
                company AS CompanyCode,
                splycode AS SupplierCode,
                brand_id AS BrandId,
                modelno AS ModelNo,
                itemtype AS ItemType,
                taxfree AS IsTaxFree,
                nosales AS NoSales,
                exdatealw AS AllowsExpiryDate,
                vprice AS VATPrice
            FROM stitems
            WHERE itemno = @ItemNo";

        const string unitsSql = @"
            SELECT
                itemno AS ItemNo,
                unicode AS UnitCode,
                name AS Name,
                barcode AS Barcode,
                lcost AS LocalCost,
                fcost AS ForeignCost,
                lprice1 AS LocalPrice1,
                lprice2 AS LocalPrice2,
                lprice3 AS LocalPrice3,
                mnmprice AS MinimumPrice,
                maxdisc1 AS MaxDiscount1,
                maxdisc2 AS MaxDiscount2,
                maxdisc3 AS MaxDiscount3,
                curbal AS CurrentBalance,
                rsvqty AS ReservedQuantity,
                minstk AS MinimumStock,
                maxstk AS MaximumStock,
                orderlevel AS ReorderLevel,
                pack1 AS Pack1,
                pkqty1 AS PackQuantity1,
                pack2 AS Pack2,
                pkqty2 AS PackQuantity2,
                inactive AS IsInactive,
                Xdecimal AS AllowDecimal
            FROM stunits
            WHERE itemno = @ItemNo";

        var productCommand = new CommandDefinition(sql, new { ItemNo = itemNo }, cancellationToken: cancellationToken);
        var unitsCommand = new CommandDefinition(unitsSql, new { ItemNo = itemNo }, cancellationToken: cancellationToken);

        try
        {
            var product = await _connection.QuerySingleOrDefaultAsync<Product>(productCommand);

            if (product != null)
            {
                var units = await _connection.QueryAsync<ProductUnit>(unitsCommand);
                product.ProductUnits = units.ToList();
            }

            return product;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving product with details for ItemNo {ItemNo}", itemNo);
            throw;
        }
    }

    public async Task<IEnumerable<Product>> GetAllAsync(int pageNumber = 1, int pageSize = 100, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                name AS NameEn,
                lname AS NameAr,
                mgroup AS MainGroup,
                sgroup AS SubGroup,
                category AS Category,
                classkey AS ClassKey,
                company AS CompanyCode,
                splycode AS SupplierCode,
                brand_id AS BrandId,
                itemtype AS ItemType
            FROM stitems
            ORDER BY itemno
            OFFSET @Offset ROWS
            FETCH NEXT @PageSize ROWS ONLY";

        var offset = (pageNumber - 1) * pageSize;
        var command = new CommandDefinition(
            sql,
            new { Offset = offset, PageSize = pageSize },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<Product>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving all products. Page: {PageNumber}, Size: {PageSize}", pageNumber, pageSize);
            throw;
        }
    }

    public async Task<string> AddAsync(Product entity, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            INSERT INTO stitems (
                itemno, name, lname, mgroup, sgroup, category, sgroup3, sgroup4,
                classkey, fcy, company, country, season, splycode, msplycode,
                brand_id, modelno, itemtype, taxtype, taxfree, nosales, exdatealw,
                noofsbitem, prntasmitm, cmpprcnt, dsctype, prmdesc, scndesc,
                splylcact, vprice, fix_barcode, modified
            ) VALUES (
                @ItemNo, @NameEn, @NameAr, @MainGroup, @SubGroup, @Category, @SubGroup3, @SubGroup4,
                @ClassKey, @CurrencyCode, @CompanyCode, @CountryCode, @Season, @SupplierCode, @MainSupplierCode,
                @BrandId, @ModelNo, @ItemType, @TaxType, @IsTaxFree, @NoSales, @AllowsExpiryDate,
                @NumberOfSubItems, @PrintAsAssembledItem, @ComparePrices, @DiscountType, @PrimaryDescription, @SecondaryDescription,
                @SupplierLocalCurrency, @VATPrice, @FixedBarcode, @Modified
            )";

        var command = new CommandDefinition(sql, entity, transaction, cancellationToken: cancellationToken);

        try
        {
            await _connection.ExecuteAsync(command);

            _logger.LogInformation("Product created with ItemNo {ItemNo}", entity.ItemNo);
            return entity.ItemNo;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error creating product with ItemNo {ItemNo}", entity.ItemNo);
            throw;
        }
    }

    public async Task<bool> UpdateAsync(Product entity, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            UPDATE stitems SET
                name = @NameEn,
                lname = @NameAr,
                mgroup = @MainGroup,
                sgroup = @SubGroup,
                category = @Category,
                classkey = @ClassKey,
                splycode = @SupplierCode,
                brand_id = @BrandId,
                modelno = @ModelNo,
                itemtype = @ItemType,
                taxfree = @IsTaxFree,
                nosales = @NoSales,
                vprice = @VATPrice,
                modified = 1
            WHERE itemno = @ItemNo";

        var command = new CommandDefinition(sql, entity, transaction, cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Product {ItemNo} updated", entity.ItemNo);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error updating product {ItemNo}", entity.ItemNo);
            throw;
        }
    }

    public async Task<bool> DeleteAsync(string itemNo, IDbTransaction? transaction = null, CancellationToken cancellationToken = default)
    {
        // Hard delete as per requirements
        const string sql = "DELETE FROM stitems WHERE itemno = @ItemNo";
        var command = new CommandDefinition(sql, new { ItemNo = itemNo }, transaction, cancellationToken: cancellationToken);

        try
        {
            var affectedRows = await _connection.ExecuteAsync(command);

            if (affectedRows > 0)
            {
                _logger.LogInformation("Product {ItemNo} deleted", itemNo);
            }

            return affectedRows > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting product {ItemNo}", itemNo);
            throw;
        }
    }

    public async Task<bool> ExistsAsync(string itemNo, CancellationToken cancellationToken = default)
    {
        const string sql = "SELECT COUNT(1) FROM stitems WHERE itemno = @ItemNo";
        var command = new CommandDefinition(sql, new { ItemNo = itemNo }, cancellationToken: cancellationToken);

        try
        {
            var count = await _connection.ExecuteScalarAsync<int>(command);
            return count > 0;
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error checking if product exists with ItemNo {ItemNo}", itemNo);
            throw;
        }
    }

    public async Task<int> CountAsync(CancellationToken cancellationToken = default)
    {
        const string sql = "SELECT COUNT(*) FROM stitems";
        var command = new CommandDefinition(sql, cancellationToken: cancellationToken);

        try
        {
            return await _connection.ExecuteScalarAsync<int>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error counting products");
            throw;
        }
    }

    public async Task<IEnumerable<Product>> SearchByNameAsync(string searchTerm, int pageNumber = 1, int pageSize = 50, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                name AS NameEn,
                lname AS NameAr,
                category AS Category,
                splycode AS SupplierCode,
                brand_id AS BrandId
            FROM stitems
            WHERE name LIKE @SearchTerm OR lname LIKE @SearchTerm
            ORDER BY name
            OFFSET @Offset ROWS
            FETCH NEXT @PageSize ROWS ONLY";

        var offset = (pageNumber - 1) * pageSize;
        var command = new CommandDefinition(
            sql,
            new { SearchTerm = $"%{searchTerm}%", Offset = offset, PageSize = pageSize },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<Product>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error searching products by name: {SearchTerm}", searchTerm);
            throw;
        }
    }

    public async Task<IEnumerable<Product>> GetByClassificationAsync(string classKey, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                name AS NameEn,
                lname AS NameAr,
                classkey AS ClassKey,
                category AS Category
            FROM stitems
            WHERE classkey = @ClassKey
            ORDER BY itemno";

        var command = new CommandDefinition(sql, new { ClassKey = classKey }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<Product>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving products by classification {ClassKey}", classKey);
            throw;
        }
    }

    public async Task<IEnumerable<Product>> GetByCategoryAsync(string categoryCode, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                name AS NameEn,
                lname AS NameAr,
                category AS Category
            FROM stitems
            WHERE category = @Category
            ORDER BY itemno";

        var command = new CommandDefinition(sql, new { Category = categoryCode }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<Product>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving products by category {Category}", categoryCode);
            throw;
        }
    }

    public async Task<IEnumerable<Product>> GetBySupplierAsync(string supplierCode, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                name AS NameEn,
                lname AS NameAr,
                splycode AS SupplierCode
            FROM stitems
            WHERE splycode = @SupplierCode
            ORDER BY itemno";

        var command = new CommandDefinition(sql, new { SupplierCode = supplierCode }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<Product>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving products by supplier {SupplierCode}", supplierCode);
            throw;
        }
    }

    public async Task<IEnumerable<Product>> GetByBrandAsync(int brandId, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                name AS NameEn,
                lname AS NameAr,
                brand_id AS BrandId
            FROM stitems
            WHERE brand_id = @BrandId
            ORDER BY itemno";

        var command = new CommandDefinition(sql, new { BrandId = brandId }, cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<Product>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving products by brand {BrandId}", brandId);
            throw;
        }
    }

    public async Task<IEnumerable<Product>> GetActiveProductsAsync(int pageNumber = 1, int pageSize = 100, CancellationToken cancellationToken = default)
    {
        const string sql = @"
            SELECT
                itemno AS ItemNo,
                name AS NameEn,
                lname AS NameAr,
                category AS Category,
                splycode AS SupplierCode
            FROM stitems
            WHERE nosales = 0
            ORDER BY itemno
            OFFSET @Offset ROWS
            FETCH NEXT @PageSize ROWS ONLY";

        var offset = (pageNumber - 1) * pageSize;
        var command = new CommandDefinition(
            sql,
            new { Offset = offset, PageSize = pageSize },
            cancellationToken: cancellationToken);

        try
        {
            return await _connection.QueryAsync<Product>(command);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving active products");
            throw;
        }
    }

    public async Task<bool> ItemNoExistsAsync(string itemNo, CancellationToken cancellationToken = default)
    {
        return await ExistsAsync(itemNo, cancellationToken);
    }
}
