namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents a product/item in the inventory system
/// Maps to: stitems table
/// </summary>
public class Product
{
    /// <summary>
    /// Item Number (Primary Key) - Maps to: itemno
    /// </summary>
    public string ItemNo { get; set; } = string.Empty;

    /// <summary>
    /// Product name (English) - Maps to: name
    /// </summary>
    public string NameEn { get; set; } = string.Empty;

    /// <summary>
    /// Product name (Arabic) - Maps to: lname
    /// </summary>
    public string NameAr { get; set; } = string.Empty;

    /// <summary>
    /// Main group code - Maps to: mgroup
    /// </summary>
    public string MainGroup { get; set; } = string.Empty;

    /// <summary>
    /// Sub group code - Maps to: sgroup
    /// </summary>
    public string SubGroup { get; set; } = string.Empty;

    /// <summary>
    /// Category code - Maps to: category
    /// </summary>
    public string Category { get; set; } = string.Empty;

    /// <summary>
    /// Third level sub group - Maps to: sgroup3
    /// </summary>
    public string SubGroup3 { get; set; } = string.Empty;

    /// <summary>
    /// Fourth level sub group - Maps to: sgroup4
    /// </summary>
    public string SubGroup4 { get; set; } = string.Empty;

    /// <summary>
    /// Classification key (composite of group hierarchy) - Maps to: classkey
    /// </summary>
    public string ClassKey { get; set; } = string.Empty;

    /// <summary>
    /// Foreign currency code - Maps to: fcy
    /// </summary>
    public string CurrencyCode { get; set; } = string.Empty;

    /// <summary>
    /// Company code - Maps to: company
    /// </summary>
    public string CompanyCode { get; set; } = string.Empty;

    /// <summary>
    /// Country code - Maps to: country
    /// </summary>
    public int CountryCode { get; set; }

    /// <summary>
    /// Season code - Maps to: season
    /// </summary>
    public string Season { get; set; } = string.Empty;

    /// <summary>
    /// Supplier code - Maps to: splycode
    /// </summary>
    public string SupplierCode { get; set; } = string.Empty;

    /// <summary>
    /// Main supplier code - Maps to: msplycode
    /// </summary>
    public string MainSupplierCode { get; set; } = string.Empty;

    /// <summary>
    /// Brand ID - Maps to: brand_id
    /// </summary>
    public int BrandId { get; set; }

    /// <summary>
    /// Model number - Maps to: modelno
    /// </summary>
    public string? ModelNo { get; set; }

    /// <summary>
    /// Item type: S=Stock, N=Non-Stock, etc. - Maps to: itemtype
    /// </summary>
    public string ItemType { get; set; } = "S";

    /// <summary>
    /// Tax type - Maps to: taxtype
    /// </summary>
    public string? TaxType { get; set; }

    /// <summary>
    /// Is tax free - Maps to: taxfree
    /// </summary>
    public bool IsTaxFree { get; set; }

    /// <summary>
    /// No sales allowed - Maps to: nosales
    /// </summary>
    public bool NoSales { get; set; }

    /// <summary>
    /// Allows expiry date tracking - Maps to: exdatealw
    /// </summary>
    public bool AllowsExpiryDate { get; set; }

    /// <summary>
    /// Number of sub-items (for kits/assemblies) - Maps to: noofsbitem
    /// </summary>
    public int NumberOfSubItems { get; set; }

    /// <summary>
    /// Print as assembled item - Maps to: prntasmitm
    /// </summary>
    public bool PrintAsAssembledItem { get; set; }

    /// <summary>
    /// Compare prices - Maps to: cmpprcnt
    /// </summary>
    public bool ComparePrices { get; set; }

    /// <summary>
    /// Discount type - Maps to: dsctype
    /// </summary>
    public string DiscountType { get; set; } = string.Empty;

    /// <summary>
    /// Primary description - Maps to: prmdesc
    /// </summary>
    public string PrimaryDescription { get; set; } = string.Empty;

    /// <summary>
    /// Secondary description - Maps to: scndesc
    /// </summary>
    public string SecondaryDescription { get; set; } = string.Empty;

    /// <summary>
    /// Supplier uses local currency - Maps to: splylcact
    /// </summary>
    public bool SupplierLocalCurrency { get; set; }

    /// <summary>
    /// VAT Price - Maps to: vprice
    /// </summary>
    public decimal? VATPrice { get; set; }

    /// <summary>
    /// Fixed barcode - Maps to: fix_barcode
    /// </summary>
    public bool FixedBarcode { get; set; }

    /// <summary>
    /// Modified flag - Maps to: modified
    /// </summary>
    public bool Modified { get; set; }

    // Navigation properties
    public virtual ICollection<ProductUnit> ProductUnits { get; set; } = new List<ProductUnit>();
    public virtual ProductClassification? Classification { get; set; }
}
