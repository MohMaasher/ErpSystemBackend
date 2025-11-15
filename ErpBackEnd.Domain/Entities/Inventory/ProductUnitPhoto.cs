namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents extended product unit information including photos and metadata
/// Maps to: stitmphoto table
/// </summary>
public class ProductUnitPhoto
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
    /// Remarks/Description - Maps to: remarks
    /// </summary>
    public string? Remarks { get; set; }

    /// <summary>
    /// Picture/Image path - Maps to: ipicture
    /// </summary>
    public string? ImagePath { get; set; }

    /// <summary>
    /// Order quantity - Maps to: ord_qty
    /// </summary>
    public decimal OrderQuantity { get; set; }

    /// <summary>
    /// Minimum date (YYYYMMDD) - Maps to: mnimumdt
    /// </summary>
    public string MinimumDate { get; set; } = string.Empty;

    /// <summary>
    /// Customer percentage - Maps to: cust_pctg
    /// </summary>
    public decimal CustomerPercentage { get; set; }

    /// <summary>
    /// Is double width - Maps to: is_double_width
    /// </summary>
    public bool IsDoubleWidth { get; set; }

    /// <summary>
    /// Is price per length - Maps to: is_price_per_length
    /// </summary>
    public bool IsPricePerLength { get; set; }

    /// <summary>
    /// Is accessory stock item - Maps to: is_accessory_stk_item
    /// </summary>
    public bool IsAccessoryStockItem { get; set; }

    /// <summary>
    /// Discount amount 1 - Maps to: dsc_amt1
    /// </summary>
    public decimal DiscountAmount1 { get; set; }

    /// <summary>
    /// Discount amount 2 - Maps to: dsc_amt2
    /// </summary>
    public decimal DiscountAmount2 { get; set; }

    /// <summary>
    /// Discount amount 3 - Maps to: dsc_amt3
    /// </summary>
    public decimal DiscountAmount3 { get; set; }

    /// <summary>
    /// User ID - Maps to: usrid
    /// </summary>
    public string? UserId { get; set; }

    /// <summary>
    /// User ID last changed - Maps to: usrid_lstchg
    /// </summary>
    public string? UserIdLastChanged { get; set; }

    /// <summary>
    /// Exemption reason code - Maps to: exemption_reason_code
    /// </summary>
    public string? ExemptionReasonCode { get; set; }

    /// <summary>
    /// Online sales enabled - Maps to: onlinesales
    /// </summary>
    public bool OnlineSales { get; set; }

    /// <summary>
    /// Extra tax percentage - Maps to: extra_tax_p
    /// </summary>
    public decimal ExtraTaxPercent { get; set; }

    /// <summary>
    /// Start date (YYYYMMDD) - Maps to: startdate
    /// </summary>
    public string? StartDate { get; set; }

    /// <summary>
    /// End date (YYYYMMDD) - Maps to: enddate
    /// </summary>
    public string? EndDate { get; set; }

    // Navigation property
    public virtual ProductUnit? ProductUnit { get; set; }
}
