namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents stock quantity in a specific bin location
/// Maps to: stbins table
/// </summary>
public class StockBin
{
    /// <summary>
    /// Branch code - Maps to: branch
    /// </summary>
    public string BranchCode { get; set; } = string.Empty;

    /// <summary>
    /// Item number - Maps to: itemno
    /// </summary>
    public string ItemNo { get; set; } = string.Empty;

    /// <summary>
    /// Unit code - Maps to: unicode
    /// </summary>
    public string UnitCode { get; set; } = string.Empty;

    /// <summary>
    /// Warehouse number - Maps to: whno
    /// </summary>
    public string WarehouseNo { get; set; } = string.Empty;

    /// <summary>
    /// Bin number - Maps to: binno
    /// </summary>
    public string BinNo { get; set; } = string.Empty;

    /// <summary>
    /// Quantity on hand - Maps to: qty
    /// </summary>
    public decimal? Quantity { get; set; }

    /// <summary>
    /// Reserved quantity - Maps to: rsvqty
    /// </summary>
    public decimal? ReservedQuantity { get; set; }

    /// <summary>
    /// Opening balance - Maps to: openbal
    /// </summary>
    public decimal? OpeningBalance { get; set; }

    /// <summary>
    /// Local cost - Maps to: lcost
    /// </summary>
    public decimal LocalCost { get; set; }

    /// <summary>
    /// Foreign cost - Maps to: fcost
    /// </summary>
    public decimal ForeignCost { get; set; }

    /// <summary>
    /// Opening local cost - Maps to: openlcost
    /// </summary>
    public decimal OpeningLocalCost { get; set; }

    /// <summary>
    /// Opening foreign cost - Maps to: openfcost
    /// </summary>
    public decimal OpeningForeignCost { get; set; }

    /// <summary>
    /// Expiry date (YYYYMMDD) - Maps to: expdate
    /// </summary>
    public string ExpiryDate { get; set; } = string.Empty;

    // Computed property for available quantity
    public decimal AvailableQuantity => (Quantity ?? 0) - (ReservedQuantity ?? 0);

    // Navigation properties
    public virtual ProductUnit? ProductUnit { get; set; }
    public virtual Warehouse? Warehouse { get; set; }
}
