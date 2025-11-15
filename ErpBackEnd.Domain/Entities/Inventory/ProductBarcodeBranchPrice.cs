namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents branch-specific pricing for product barcodes
/// Maps to: stitembc_brprice table
/// </summary>
public class ProductBarcodeBranchPrice
{
    /// <summary>
    /// Branch code - Maps to: branch
    /// </summary>
    public string BranchCode { get; set; } = string.Empty;

    /// <summary>
    /// Primary barcode - Maps to: pbarcode
    /// </summary>
    public string PrimaryBarcode { get; set; } = string.Empty;

    /// <summary>
    /// Combination key - Maps to: cmbkey
    /// </summary>
    public string CombinationKey { get; set; } = string.Empty;

    /// <summary>
    /// Local price 1 - Maps to: lprice1
    /// </summary>
    public decimal? LocalPrice1 { get; set; }

    /// <summary>
    /// Minimum price - Maps to: mnmprice
    /// </summary>
    public decimal? MinimumPrice { get; set; }

    /// <summary>
    /// Local price 2 - Maps to: lprice2
    /// </summary>
    public decimal? LocalPrice2 { get; set; }

    // Navigation property
    public virtual ProductBarcode? ProductBarcode { get; set; }
}
