namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents product classification/category
/// Maps to: stclass table
/// </summary>
public class ProductClassification
{
    /// <summary>
    /// Classification name (English) - Maps to: name
    /// </summary>
    public string NameEn { get; set; } = string.Empty;

    /// <summary>
    /// Classification name (Arabic) - Maps to: lname
    /// </summary>
    public string NameAr { get; set; } = string.Empty;

    /// <summary>
    /// Combination key (Primary Key) - Maps to: cmbkey
    /// </summary>
    public string CombinationKey { get; set; } = string.Empty;

    /// <summary>
    /// Main group - Maps to: mgroup
    /// </summary>
    public string MainGroup { get; set; } = string.Empty;

    /// <summary>
    /// Sub group - Maps to: sgroup
    /// </summary>
    public string SubGroup { get; set; } = string.Empty;

    /// <summary>
    /// Category - Maps to: category
    /// </summary>
    public string Category { get; set; } = string.Empty;

    /// <summary>
    /// Sub group 3 - Maps to: sgroup3
    /// </summary>
    public string SubGroup3 { get; set; } = string.Empty;

    /// <summary>
    /// Sub group 4 - Maps to: sgroup4
    /// </summary>
    public string SubGroup4 { get; set; } = string.Empty;

    // Sales Accounts
    /// <summary>
    /// Sales cash account - Maps to: sercsh
    /// </summary>
    public string SalesCashAccount { get; set; } = string.Empty;

    /// <summary>
    /// Sales credit account - Maps to: sercrd
    /// </summary>
    public string SalesCreditAccount { get; set; } = string.Empty;

    /// <summary>
    /// Sales return cash account - Maps to: serrch
    /// </summary>
    public string SalesReturnCashAccount { get; set; } = string.Empty;

    /// <summary>
    /// Sales return credit account - Maps to: serrcr
    /// </summary>
    public string SalesReturnCreditAccount { get; set; } = string.Empty;

    /// <summary>
    /// Sales discount account - Maps to: serdsc
    /// </summary>
    public string SalesDiscountAccount { get; set; } = string.Empty;

    // Purchase Accounts
    /// <summary>
    /// Purchase cash account - Maps to: serpcsh
    /// </summary>
    public string PurchaseCashAccount { get; set; } = string.Empty;

    /// <summary>
    /// Purchase credit account - Maps to: serpcrd
    /// </summary>
    public string PurchaseCreditAccount { get; set; } = string.Empty;

    /// <summary>
    /// Purchase return cash account - Maps to: serprch
    /// </summary>
    public string PurchaseReturnCashAccount { get; set; } = string.Empty;

    /// <summary>
    /// Purchase return credit account - Maps to: serprcr
    /// </summary>
    public string PurchaseReturnCreditAccount { get; set; } = string.Empty;

    /// <summary>
    /// Purchase discount account - Maps to: serpdsc
    /// </summary>
    public string PurchaseDiscountAccount { get; set; } = string.Empty;

    /// <summary>
    /// Maximum sales limit - Maps to: max_sl_limit
    /// </summary>
    public decimal? MaxSalesLimit { get; set; }

    /// <summary>
    /// Parent key - Maps to: pkey
    /// </summary>
    public int ParentKey { get; set; }

    /// <summary>
    /// Child key - Maps to: chkey
    /// </summary>
    public int ChildKey { get; set; }

    /// <summary>
    /// Last update date - Maps to: lastupdt
    /// </summary>
    public string LastUpdateDate { get; set; } = string.Empty;

    /// <summary>
    /// Modified flag - Maps to: modified
    /// </summary>
    public bool Modified { get; set; }

    // Navigation properties
    public virtual ICollection<Product> Products { get; set; } = new List<Product>();
}
