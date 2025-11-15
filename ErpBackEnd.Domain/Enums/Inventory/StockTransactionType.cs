namespace ErpBackEnd.Domain.Enums.Inventory;

/// <summary>
/// Represents stock transaction types
/// Based on legacy trtype codes
/// </summary>
public enum StockTransactionType
{
    /// <summary>
    /// Purchase receipt
    /// </summary>
    PurchaseReceipt = 1,

    /// <summary>
    /// Purchase return
    /// </summary>
    PurchaseReturn = 2,

    /// <summary>
    /// Sales invoice
    /// </summary>
    SalesInvoice = 3,

    /// <summary>
    /// Sales return
    /// </summary>
    SalesReturn = 4,

    /// <summary>
    /// Stock adjustment - increase
    /// </summary>
    StockAdjustmentIncrease = 5,

    /// <summary>
    /// Stock adjustment - decrease
    /// </summary>
    StockAdjustmentDecrease = 6,

    /// <summary>
    /// Stock transfer between warehouses
    /// </summary>
    StockTransfer = 7,

    /// <summary>
    /// Stock transfer between bins
    /// </summary>
    BinTransfer = 8,

    /// <summary>
    /// Opening balance
    /// </summary>
    OpeningBalance = 9,

    /// <summary>
    /// Assembly/Kit production
    /// </summary>
    Assembly = 10,

    /// <summary>
    /// Disassembly
    /// </summary>
    Disassembly = 11,

    /// <summary>
    /// Physical count
    /// </summary>
    PhysicalCount = 12,

    /// <summary>
    /// Damaged goods
    /// </summary>
    DamagedGoods = 13,

    /// <summary>
    /// Inter-branch transfer
    /// </summary>
    InterBranchTransfer = 14
}
