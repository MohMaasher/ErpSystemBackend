namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents a line item in a stock transaction
/// Maps to: stdtl table
/// </summary>
public class StockTransactionDetail
{
    /// <summary>
    /// Item number - Maps to: itemno
    /// </summary>
    public string ItemNo { get; set; } = string.Empty;

    /// <summary>
    /// Unit code - Maps to: unicode
    /// </summary>
    public string UnitCode { get; set; } = string.Empty;

    /// <summary>
    /// Branch code - Maps to: branch
    /// </summary>
    public string BranchCode { get; set; } = string.Empty;

    /// <summary>
    /// Transaction type - Maps to: trtype
    /// </summary>
    public string TransactionType { get; set; } = string.Empty;

    /// <summary>
    /// Reference number - Maps to: refno
    /// </summary>
    public int ReferenceNo { get; set; }

    /// <summary>
    /// Folio/Line number - Maps to: folio
    /// </summary>
    public int Folio { get; set; }

    /// <summary>
    /// Quantity - Maps to: qty
    /// </summary>
    public decimal? Quantity { get; set; }

    /// <summary>
    /// Foreign quantity - Maps to: fqty
    /// </summary>
    public decimal ForeignQuantity { get; set; }

    /// <summary>
    /// Warehouse number - Maps to: whno
    /// </summary>
    public string WarehouseNo { get; set; } = string.Empty;

    /// <summary>
    /// Bin number - Maps to: binno
    /// </summary>
    public string BinNo { get; set; } = string.Empty;

    /// <summary>
    /// To warehouse number (for transfers) - Maps to: towhno
    /// </summary>
    public string? ToWarehouseNo { get; set; }

    /// <summary>
    /// To bin number (for transfers) - Maps to: tobinno
    /// </summary>
    public string? ToBinNo { get; set; }

    /// <summary>
    /// Local cost - Maps to: lcost
    /// </summary>
    public decimal LocalCost { get; set; }

    /// <summary>
    /// Foreign cost - Maps to: fcost
    /// </summary>
    public decimal? ForeignCost { get; set; }

    /// <summary>
    /// Local price - Maps to: lprice
    /// </summary>
    public decimal LocalPrice { get; set; }

    /// <summary>
    /// Foreign price - Maps to: fprice
    /// </summary>
    public decimal? ForeignPrice { get; set; }

    /// <summary>
    /// Transaction date (YYYYMMDD) - Maps to: trdate
    /// </summary>
    public string TransactionDate { get; set; } = string.Empty;

    /// <summary>
    /// System date (YYYYMMDD) - Maps to: sysdate
    /// </summary>
    public string SystemDate { get; set; } = string.Empty;

    /// <summary>
    /// Source code - Maps to: src
    /// </summary>
    public string SourceCode { get; set; } = string.Empty;

    /// <summary>
    /// Expiry date (YYYYMMDD) - Maps to: expdate
    /// </summary>
    public string? ExpiryDate { get; set; }

    /// <summary>
    /// Barcode - Maps to: barcode
    /// </summary>
    public string Barcode { get; set; } = string.Empty;

    /// <summary>
    /// Combination key - Maps to: cmbkey
    /// </summary>
    public string CombinationKey { get; set; } = string.Empty;

    /// <summary>
    /// Discount percentage - Maps to: discpc
    /// </summary>
    public decimal? DiscountPercent { get; set; }

    /// <summary>
    /// Pack code - Maps to: pack
    /// </summary>
    public string? Pack { get; set; }

    /// <summary>
    /// Should pack - Maps to: shdpk
    /// </summary>
    public decimal? ShouldPack { get; set; }

    /// <summary>
    /// Should quantity - Maps to: shdqty
    /// </summary>
    public decimal? ShouldQuantity { get; set; }

    /// <summary>
    /// Replace post flag - Maps to: rplct_post
    /// </summary>
    public bool? ReplacePost { get; set; }

    /// <summary>
    /// Quarter freight - Maps to: q_frt
    /// </summary>
    public int QuarterFreight { get; set; }

    // Navigation property
    public virtual StockTransactionHeader? Header { get; set; }
    public virtual ProductUnit? ProductUnit { get; set; }
}
