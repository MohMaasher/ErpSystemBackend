namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents product barcode information
/// Maps to: stitembc table
/// </summary>
public class ProductBarcode
{
    /// <summary>
    /// Primary barcode - Maps to: pbarcode
    /// </summary>
    public string PrimaryBarcode { get; set; } = string.Empty;

    /// <summary>
    /// Item number - Maps to: itemno
    /// </summary>
    public string ItemNo { get; set; } = string.Empty;

    /// <summary>
    /// Unit code - Maps to: unicode
    /// </summary>
    public string? UnitCode { get; set; }

    /// <summary>
    /// Combination key - Maps to: cmbkey
    /// </summary>
    public string CombinationKey { get; set; } = string.Empty;

    /// <summary>
    /// Pack code - Maps to: pack
    /// </summary>
    public string Pack { get; set; } = string.Empty;

    /// <summary>
    /// Pack quantity - Maps to: pkqty
    /// </summary>
    public decimal PackQuantity { get; set; }

    /// <summary>
    /// Local price 1 - Maps to: lprice1
    /// </summary>
    public decimal? LocalPrice1 { get; set; }

    /// <summary>
    /// Local price 2 - Maps to: lprice2
    /// </summary>
    public decimal? LocalPrice2 { get; set; }

    /// <summary>
    /// Weight - Maps to: weight
    /// </summary>
    public decimal? Weight { get; set; }

    /// <summary>
    /// Minimum price - Maps to: mnmprice
    /// </summary>
    public decimal? MinimumPrice { get; set; }

    /// <summary>
    /// Item text (English) - Maps to: itext
    /// </summary>
    public string? ItemText { get; set; }

    /// <summary>
    /// Item text (Arabic) - Maps to: litext
    /// </summary>
    public string? LocalItemText { get; set; }

    /// <summary>
    /// Pack order - Maps to: pkorder
    /// </summary>
    public int? PackOrder { get; set; }

    /// <summary>
    /// Last received date (YYYYMMDD) - Maps to: lastrcvd
    /// </summary>
    public string? LastReceivedDate { get; set; }

    // Navigation property
    public virtual ProductUnit? ProductUnit { get; set; }
    public virtual ICollection<ProductBarcodeBranchPrice> BranchPrices { get; set; } = new List<ProductBarcodeBranchPrice>();
}
