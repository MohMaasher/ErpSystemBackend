namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents a product unit/variant with pricing and stock information
/// Maps to: stunits table
/// </summary>
public class ProductUnit
{
    /// <summary>
    /// Item Number - Maps to: itemno
    /// </summary>
    public string ItemNo { get; set; } = string.Empty;

    /// <summary>
    /// Unit code (variant identifier) - Maps to: unicode
    /// </summary>
    public string UnitCode { get; set; } = string.Empty;

    /// <summary>
    /// Unit name (English) - Maps to: name
    /// </summary>
    public string Name { get; set; } = string.Empty;

    /// <summary>
    /// Unit name (Arabic) - Maps to: scnname
    /// </summary>
    public string ScannedName { get; set; } = string.Empty;

    /// <summary>
    /// Company code - Maps to: company
    /// </summary>
    public string CompanyCode { get; set; } = string.Empty;

    /// <summary>
    /// Combination key - Maps to: cmbkey
    /// </summary>
    public string CombinationKey { get; set; } = string.Empty;

    /// <summary>
    /// Barcode - Maps to: barcode
    /// </summary>
    public string Barcode { get; set; } = string.Empty;

    /// <summary>
    /// Model number - Maps to: modelno
    /// </summary>
    public string ModelNo { get; set; } = string.Empty;

    // Cost Information
    /// <summary>
    /// Opening local cost - Maps to: openlcost
    /// </summary>
    public decimal OpeningLocalCost { get; set; }

    /// <summary>
    /// Current local cost - Maps to: lcost
    /// </summary>
    public decimal LocalCost { get; set; }

    /// <summary>
    /// Opening foreign cost - Maps to: openfcost
    /// </summary>
    public decimal OpeningForeignCost { get; set; }

    /// <summary>
    /// Current foreign cost - Maps to: fcost
    /// </summary>
    public decimal ForeignCost { get; set; }

    // Pricing - Level 1
    /// <summary>
    /// Local price 1 - Maps to: lprice1
    /// </summary>
    public decimal LocalPrice1 { get; set; }

    /// <summary>
    /// Foreign price 1 - Maps to: fprice1
    /// </summary>
    public decimal ForeignPrice1 { get; set; }

    /// <summary>
    /// Maximum discount 1 - Maps to: maxdisc1
    /// </summary>
    public decimal MaxDiscount1 { get; set; }

    // Pricing - Level 2
    /// <summary>
    /// Local price 2 - Maps to: lprice2
    /// </summary>
    public decimal? LocalPrice2 { get; set; }

    /// <summary>
    /// Foreign price 2 - Maps to: fprice2
    /// </summary>
    public decimal ForeignPrice2 { get; set; }

    /// <summary>
    /// Maximum discount 2 - Maps to: maxdisc2
    /// </summary>
    public decimal MaxDiscount2 { get; set; }

    // Pricing - Level 3
    /// <summary>
    /// Local price 3 - Maps to: lprice3
    /// </summary>
    public decimal LocalPrice3 { get; set; }

    /// <summary>
    /// Foreign price 3 - Maps to: fprice3
    /// </summary>
    public decimal ForeignPrice3 { get; set; }

    /// <summary>
    /// Maximum discount 3 - Maps to: maxdisc3
    /// </summary>
    public decimal MaxDiscount3 { get; set; }

    /// <summary>
    /// Minimum price - Maps to: mnmprice
    /// </summary>
    public decimal MinimumPrice { get; set; }

    // Stock Information
    /// <summary>
    /// Opening balance - Maps to: openbal
    /// </summary>
    public decimal? OpeningBalance { get; set; }

    /// <summary>
    /// Current balance - Maps to: curbal
    /// </summary>
    public decimal? CurrentBalance { get; set; }

    /// <summary>
    /// Reserved quantity - Maps to: rsvqty
    /// </summary>
    public decimal? ReservedQuantity { get; set; }

    /// <summary>
    /// Minimum stock level - Maps to: minstk
    /// </summary>
    public decimal MinimumStock { get; set; }

    /// <summary>
    /// Maximum stock level - Maps to: maxstk
    /// </summary>
    public decimal MaximumStock { get; set; }

    /// <summary>
    /// Reorder level - Maps to: orderlevel
    /// </summary>
    public decimal ReorderLevel { get; set; }

    /// <summary>
    /// Lead time in days - Maps to: leadday
    /// </summary>
    public int LeadDays { get; set; }

    // Packing Information
    /// <summary>
    /// Packing type - Maps to: packtp
    /// </summary>
    public string PackingType { get; set; } = string.Empty;

    /// <summary>
    /// Pack 0 code - Maps to: pack0
    /// </summary>
    public string Pack0 { get; set; } = string.Empty;

    /// <summary>
    /// Pack 1 code - Maps to: pack1
    /// </summary>
    public string Pack1 { get; set; } = string.Empty;

    /// <summary>
    /// Pack 1 quantity - Maps to: pkqty1
    /// </summary>
    public decimal PackQuantity1 { get; set; }

    /// <summary>
    /// Pack 2 code - Maps to: pack2
    /// </summary>
    public string Pack2 { get; set; } = string.Empty;

    /// <summary>
    /// Pack 2 quantity - Maps to: pkqty2
    /// </summary>
    public decimal PackQuantity2 { get; set; }

    /// <summary>
    /// Pack 3 code - Maps to: pack3
    /// </summary>
    public string Pack3 { get; set; } = string.Empty;

    /// <summary>
    /// Pack 3 quantity - Maps to: pkqty3
    /// </summary>
    public decimal PackQuantity3 { get; set; }

    // Dates
    /// <summary>
    /// Last received date - Maps to: lrcvdate
    /// </summary>
    public string LastReceivedDate { get; set; } = string.Empty;

    /// <summary>
    /// Last issue date - Maps to: lastissue
    /// </summary>
    public string LastIssueDate { get; set; } = string.Empty;

    /// <summary>
    /// Creation date - Maps to: crtdate
    /// </summary>
    public string CreationDate { get; set; } = string.Empty;

    /// <summary>
    /// Last update date - Maps to: lastupdt
    /// </summary>
    public string LastUpdateDate { get; set; } = string.Empty;

    // Codes
    /// <summary>
    /// Promotion code - Maps to: prmcode
    /// </summary>
    public string PromotionCode { get; set; } = string.Empty;

    /// <summary>
    /// Scan code - Maps to: scncode
    /// </summary>
    public string ScanCode { get; set; } = string.Empty;

    // Flags
    /// <summary>
    /// Has been moved - Maps to: moved
    /// </summary>
    public bool Moved { get; set; }

    /// <summary>
    /// Allow decimal quantities - Maps to: Xdecimal
    /// </summary>
    public bool AllowDecimal { get; set; }

    /// <summary>
    /// Is inactive - Maps to: inactive
    /// </summary>
    public bool IsInactive { get; set; }

    /// <summary>
    /// Modified flag - Maps to: modified
    /// </summary>
    public bool Modified { get; set; }

    // Supplier Invoice Information
    /// <summary>
    /// Supplier item number - Maps to: splyitemno
    /// </summary>
    public string? SupplierItemNo { get; set; }

    /// <summary>
    /// Supplier invoice number - Maps to: splyinv
    /// </summary>
    public string? SupplierInvoice { get; set; }

    /// <summary>
    /// Invoice price - Maps to: invprice
    /// </summary>
    public decimal? InvoicePrice { get; set; }

    /// <summary>
    /// Invoice quantity - Maps to: invqty
    /// </summary>
    public decimal? InvoiceQuantity { get; set; }

    /// <summary>
    /// Invoice pack - Maps to: invpk
    /// </summary>
    public string? InvoicePack { get; set; }

    /// <summary>
    /// Profit percentage 2 - Maps to: pp2
    /// </summary>
    public decimal? ProfitPercent2 { get; set; }

    /// <summary>
    /// Profit percentage 3 - Maps to: pp3
    /// </summary>
    public decimal? ProfitPercent3 { get; set; }

    // Navigation property
    public virtual Product? Product { get; set; }
    public virtual ICollection<StockBin> StockBins { get; set; } = new List<StockBin>();
    public virtual ICollection<ProductBarcode> Barcodes { get; set; } = new List<ProductBarcode>();
}
