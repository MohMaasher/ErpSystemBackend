# Database Schema Documentation

## Overview
The ERP system uses an existing SQL Server database with 200+ tables. This document provides guidance on working with the database schema.

## Connection Configuration
```json
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=.;Database=ErpDb;Trusted_Connection=true;TrustServerCertificate=true;MultipleActiveResultSets=true"
  }
}
```

## Database Conventions

### Naming Conventions
- **Tables**: PascalCase (e.g., `Customers`, `SalesOrders`)
- **Columns**: PascalCase (e.g., `CustomerId`, `OrderDate`)
- **Stored Procedures**: `sp_` prefix (e.g., `sp_GetCustomerById`)
- **Views**: `vw_` prefix (e.g., `vw_CustomerSummary`)

### Audit Fields
All tables must include these audit columns:
- `CreatedBy` (nvarchar(50)) - Username who created the record
- `CreatedDate` (datetime2) - Record creation timestamp
- `ModifiedBy` (nvarchar(50)) - Username who last modified
- `ModifiedDate` (datetime2) - Last modification timestamp

### Localization Fields
For multi-language support, use separate columns:
- `NameAr` - Arabic name
- `NameEn` - English name
- `NameFr` - French name (optional)
- `DescriptionAr` - Arabic description
- `DescriptionEn` - English description
- `DescriptionFr` - French description (optional)

## Core Tables by Module

### Accounting Module
```sql
-- Chart of Accounts
CREATE TABLE ChartOfAccounts (
    AccountId INT PRIMARY KEY IDENTITY(1,1),
    AccountCode NVARCHAR(20) NOT NULL UNIQUE,
    AccountNameAr NVARCHAR(100) NOT NULL,
    AccountNameEn NVARCHAR(100) NOT NULL,
    AccountType INT NOT NULL, -- Asset, Liability, Equity, Revenue, Expense
    ParentAccountId INT NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedBy NVARCHAR(50) NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    ModifiedBy NVARCHAR(50) NULL,
    ModifiedDate DATETIME2 NULL
)

-- Journal Entries
CREATE TABLE JournalEntries (
    EntryId INT PRIMARY KEY IDENTITY(1,1),
    EntryNumber NVARCHAR(20) NOT NULL UNIQUE,
    EntryDate DATE NOT NULL,
    DescriptionAr NVARCHAR(500),
    DescriptionEn NVARCHAR(500),
    TotalDebit DECIMAL(18,2) NOT NULL,
    TotalCredit DECIMAL(18,2) NOT NULL,
    Status INT NOT NULL, -- Draft, Posted, Cancelled
    PostedDate DATETIME2 NULL,
    CreatedBy NVARCHAR(50) NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    ModifiedBy NVARCHAR(50) NULL,
    ModifiedDate DATETIME2 NULL
)

-- Journal Entry Lines
CREATE TABLE JournalEntryLines (
    LineId INT PRIMARY KEY IDENTITY(1,1),
    EntryId INT NOT NULL FOREIGN KEY REFERENCES JournalEntries(EntryId),
    AccountId INT NOT NULL FOREIGN KEY REFERENCES ChartOfAccounts(AccountId),
    DebitAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    CreditAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    DescriptionAr NVARCHAR(500),
    DescriptionEn NVARCHAR(500),
    CostCenterId INT NULL,
    ProjectId INT NULL
)
```

### Inventory Module
```sql
-- Products/Items
CREATE TABLE Products (
    ProductId INT PRIMARY KEY IDENTITY(1,1),
    ProductCode NVARCHAR(50) NOT NULL UNIQUE,
    Barcode NVARCHAR(50) NULL,
    ProductNameAr NVARCHAR(200) NOT NULL,
    ProductNameEn NVARCHAR(200) NOT NULL,
    CategoryId INT NOT NULL,
    UnitOfMeasureId INT NOT NULL,
    CostPrice DECIMAL(18,2) NOT NULL DEFAULT 0,
    SellingPrice DECIMAL(18,2) NOT NULL DEFAULT 0,
    VATRate DECIMAL(5,2) NOT NULL DEFAULT 15.00,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedBy NVARCHAR(50) NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    ModifiedBy NVARCHAR(50) NULL,
    ModifiedDate DATETIME2 NULL
)

-- Warehouses
CREATE TABLE Warehouses (
    WarehouseId INT PRIMARY KEY IDENTITY(1,1),
    WarehouseCode NVARCHAR(20) NOT NULL UNIQUE,
    WarehouseNameAr NVARCHAR(100) NOT NULL,
    WarehouseNameEn NVARCHAR(100) NOT NULL,
    LocationAddress NVARCHAR(500),
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedBy NVARCHAR(50) NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    ModifiedBy NVARCHAR(50) NULL,
    ModifiedDate DATETIME2 NULL
)

-- Stock Levels
CREATE TABLE StockLevels (
    StockId INT PRIMARY KEY IDENTITY(1,1),
    ProductId INT NOT NULL FOREIGN KEY REFERENCES Products(ProductId),
    WarehouseId INT NOT NULL FOREIGN KEY REFERENCES Warehouses(WarehouseId),
    QuantityOnHand DECIMAL(18,3) NOT NULL DEFAULT 0,
    QuantityReserved DECIMAL(18,3) NOT NULL DEFAULT 0,
    QuantityAvailable AS (QuantityOnHand - QuantityReserved),
    ReorderLevel DECIMAL(18,3) NOT NULL DEFAULT 0,
    LastUpdated DATETIME2 NOT NULL DEFAULT GETDATE(),
    CONSTRAINT UK_Stock_Product_Warehouse UNIQUE (ProductId, WarehouseId)
)
```

### Customers Module
```sql
-- Customers
CREATE TABLE Customers (
    CustomerId INT PRIMARY KEY IDENTITY(1,1),
    CustomerCode NVARCHAR(20) NOT NULL UNIQUE,
    CustomerNameAr NVARCHAR(200) NOT NULL,
    CustomerNameEn NVARCHAR(200) NOT NULL,
    CustomerType INT NOT NULL, -- Individual, Company
    VATNumber NVARCHAR(15) NULL,
    CRNumber NVARCHAR(10) NULL, -- Commercial Registration
    Email NVARCHAR(100) NULL,
    Phone NVARCHAR(20) NULL,
    CreditLimit DECIMAL(18,2) NOT NULL DEFAULT 0,
    CurrentBalance DECIMAL(18,2) NOT NULL DEFAULT 0,
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedBy NVARCHAR(50) NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    ModifiedBy NVARCHAR(50) NULL,
    ModifiedDate DATETIME2 NULL
)

-- Customer Addresses
CREATE TABLE CustomerAddresses (
    AddressId INT PRIMARY KEY IDENTITY(1,1),
    CustomerId INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerId),
    AddressType INT NOT NULL, -- Billing, Shipping
    Street NVARCHAR(200),
    City NVARCHAR(100),
    State NVARCHAR(100),
    PostalCode NVARCHAR(20),
    Country NVARCHAR(100),
    IsDefault BIT NOT NULL DEFAULT 0
)
```

### Sales Module
```sql
-- Sales Orders
CREATE TABLE SalesOrders (
    OrderId INT PRIMARY KEY IDENTITY(1,1),
    OrderNumber NVARCHAR(20) NOT NULL UNIQUE,
    OrderDate DATE NOT NULL,
    CustomerId INT NOT NULL FOREIGN KEY REFERENCES Customers(CustomerId),
    SalespersonId INT NULL,
    SubTotal DECIMAL(18,2) NOT NULL DEFAULT 0,
    VATAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    TotalAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    OrderStatus INT NOT NULL, -- Draft, Confirmed, Shipped, Delivered, Cancelled
    PaymentTerms INT NOT NULL, -- Cash, Net30, Net60, etc.
    DueDate DATE NOT NULL,
    Notes NVARCHAR(1000) NULL,
    CreatedBy NVARCHAR(50) NOT NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETDATE(),
    ModifiedBy NVARCHAR(50) NULL,
    ModifiedDate DATETIME2 NULL
)

-- Sales Order Lines
CREATE TABLE SalesOrderLines (
    LineId INT PRIMARY KEY IDENTITY(1,1),
    OrderId INT NOT NULL FOREIGN KEY REFERENCES SalesOrders(OrderId),
    ProductId INT NOT NULL FOREIGN KEY REFERENCES Products(ProductId),
    Quantity DECIMAL(18,3) NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    DiscountPercent DECIMAL(5,2) NOT NULL DEFAULT 0,
    DiscountAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    VATRate DECIMAL(5,2) NOT NULL DEFAULT 15.00,
    VATAmount DECIMAL(18,2) NOT NULL DEFAULT 0,
    LineTotal DECIMAL(18,2) NOT NULL,
    WarehouseId INT NOT NULL FOREIGN KEY REFERENCES Warehouses(WarehouseId)
)
```

## Transaction Log Table
```sql
CREATE TABLE TransactionLog (
    LogId BIGINT PRIMARY KEY IDENTITY(1,1),
    TableName NVARCHAR(100) NOT NULL,
    RecordId NVARCHAR(50) NOT NULL,
    Operation NVARCHAR(10) NOT NULL, -- INSERT, UPDATE, DELETE
    OldValues NVARCHAR(MAX) NULL, -- JSON format
    NewValues NVARCHAR(MAX) NULL, -- JSON format
    Username NVARCHAR(50) NOT NULL,
    Timestamp DATETIME2 NOT NULL DEFAULT GETDATE(),
    IPAddress NVARCHAR(50) NULL,
    UserAgent NVARCHAR(500) NULL
)

-- Index for performance
CREATE INDEX IX_TransactionLog_Table_Record 
ON TransactionLog(TableName, RecordId, Timestamp DESC)
```

## Stored Procedures Examples

### Get Customer with Balance
```sql
CREATE PROCEDURE sp_GetCustomerWithBalance
    @CustomerId INT
AS
BEGIN
    SELECT 
        c.*,
        ISNULL(SUM(so.TotalAmount), 0) as TotalSales,
        ISNULL(SUM(CASE WHEN so.OrderStatus != 5 THEN so.TotalAmount ELSE 0 END), 0) as OutstandingAmount
    FROM Customers c
    LEFT JOIN SalesOrders so ON c.CustomerId = so.CustomerId
    WHERE c.CustomerId = @CustomerId
    GROUP BY c.CustomerId, c.CustomerCode, c.CustomerNameAr, c.CustomerNameEn, 
             c.CustomerType, c.VATNumber, c.CRNumber, c.Email, c.Phone, 
             c.CreditLimit, c.CurrentBalance, c.IsActive, 
             c.CreatedBy, c.CreatedDate, c.ModifiedBy, c.ModifiedDate
END
```

### Post Journal Entry
```sql
CREATE PROCEDURE sp_PostJournalEntry
    @EntryId INT,
    @PostedBy NVARCHAR(50)
AS
BEGIN
    BEGIN TRANSACTION
    
    -- Validate balanced entry
    DECLARE @TotalDebit DECIMAL(18,2), @TotalCredit DECIMAL(18,2)
    
    SELECT 
        @TotalDebit = SUM(DebitAmount),
        @TotalCredit = SUM(CreditAmount)
    FROM JournalEntryLines
    WHERE EntryId = @EntryId
    
    IF @TotalDebit != @TotalCredit
    BEGIN
        ROLLBACK
        RAISERROR('Journal entry is not balanced', 16, 1)
        RETURN
    END
    
    -- Update entry status
    UPDATE JournalEntries
    SET Status = 2, -- Posted
        PostedDate = GETDATE(),
        ModifiedBy = @PostedBy,
        ModifiedDate = GETDATE()
    WHERE EntryId = @EntryId
    
    -- Update general ledger (implementation depends on GL structure)
    -- ...
    
    COMMIT TRANSACTION
END
```

## Query Patterns with Dapper

### Basic Query
```csharp
public async Task<Customer> GetCustomerByIdAsync(int customerId)
{
    using var connection = new SqlConnection(_connectionString);
    var sql = @"
        SELECT * FROM Customers 
        WHERE CustomerId = @CustomerId";
    
    return await connection.QuerySingleOrDefaultAsync<Customer>(
        sql, 
        new { CustomerId = customerId });
}
```

### Query with Joins
```csharp
public async Task<IEnumerable<CustomerOrderDto>> GetCustomerOrdersAsync(int customerId)
{
    using var connection = new SqlConnection(_connectionString);
    var sql = @"
        SELECT 
            c.CustomerNameEn,
            o.OrderNumber,
            o.OrderDate,
            o.TotalAmount
        FROM Customers c
        INNER JOIN SalesOrders o ON c.CustomerId = o.CustomerId
        WHERE c.CustomerId = @CustomerId
        ORDER BY o.OrderDate DESC";
    
    return await connection.QueryAsync<CustomerOrderDto>(
        sql, 
        new { CustomerId = customerId });
}
```

### Transaction with Dapper
```csharp
public async Task<int> CreateSalesOrderAsync(SalesOrder order)
{
    using var connection = new SqlConnection(_connectionString);
    await connection.OpenAsync();
    using var transaction = connection.BeginTransaction();
    
    try
    {
        // Insert order header
        var orderId = await connection.QuerySingleAsync<int>(@"
            INSERT INTO SalesOrders (OrderNumber, OrderDate, CustomerId, SubTotal, VATAmount, TotalAmount, OrderStatus, PaymentTerms, DueDate, CreatedBy, CreatedDate)
            VALUES (@OrderNumber, @OrderDate, @CustomerId, @SubTotal, @VATAmount, @TotalAmount, @OrderStatus, @PaymentTerms, @DueDate, @CreatedBy, GETDATE());
            SELECT CAST(SCOPE_IDENTITY() as int);",
            order,
            transaction);
        
        // Insert order lines
        foreach (var line in order.Lines)
        {
            line.OrderId = orderId;
            await connection.ExecuteAsync(@"
                INSERT INTO SalesOrderLines (OrderId, ProductId, Quantity, UnitPrice, DiscountPercent, DiscountAmount, VATRate, VATAmount, LineTotal, WarehouseId)
                VALUES (@OrderId, @ProductId, @Quantity, @UnitPrice, @DiscountPercent, @DiscountAmount, @VATRate, @VATAmount, @LineTotal, @WarehouseId)",
                line,
                transaction);
        }
        
        await transaction.CommitAsync();
        return orderId;
    }
    catch
    {
        await transaction.RollbackAsync();
        throw;
    }
}
```

## Performance Guidelines

1. **Always use parameterized queries** to prevent SQL injection
2. **Use async/await** for all database operations
3. **Implement connection pooling** (handled by SqlConnection)
4. **Use appropriate indexes** on frequently queried columns
5. **Avoid N+1 queries** - use joins or batch queries
6. **Use stored procedures** for complex business logic
7. **Implement caching** for reference data (using Redis)

## Migration Strategy
Since the database already exists:
- **No EF Core migrations** - Database changes handled by DBA
- **Use database-first approach** - Generate entities from existing schema
- **Version control stored procedures** in `/sql` folder
- **Document all schema changes** in this file