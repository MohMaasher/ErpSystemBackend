namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents a supplier/vendor
/// Maps to: supplier table
/// </summary>
public class Supplier
{
    /// <summary>
    /// Supplier name (English) - Maps to: cu_name
    /// </summary>
    public string NameEn { get; set; } = string.Empty;

    /// <summary>
    /// Supplier name (Arabic) - Maps to: cu_lname
    /// </summary>
    public string NameAr { get; set; } = string.Empty;

    /// <summary>
    /// Company code - Maps to: cu_company
    /// </summary>
    public string CompanyCode { get; set; } = string.Empty;

    /// <summary>
    /// Supplier code - Maps to: cu_code
    /// </summary>
    public string SupplierCode { get; set; } = string.Empty;

    /// <summary>
    /// Supplier class - Maps to: cu_class
    /// </summary>
    public string SupplierClass { get; set; } = string.Empty;

    /// <summary>
    /// Address (English) - Maps to: cu_addrs
    /// </summary>
    public string AddressEn { get; set; } = string.Empty;

    /// <summary>
    /// Address (Arabic) - Maps to: cu_laddrs
    /// </summary>
    public string AddressAr { get; set; } = string.Empty;

    /// <summary>
    /// Telephone - Maps to: cu_tel
    /// </summary>
    public string Telephone { get; set; } = string.Empty;

    /// <summary>
    /// Mobile - Maps to: cu_mobile
    /// </summary>
    public string Mobile { get; set; } = string.Empty;

    /// <summary>
    /// Fax - Maps to: cu_fax
    /// </summary>
    public string Fax { get; set; } = string.Empty;

    /// <summary>
    /// Telex - Maps to: cu_tlx
    /// </summary>
    public string Telex { get; set; } = string.Empty;

    /// <summary>
    /// Email - Maps to: cu_email
    /// </summary>
    public string Email { get; set; } = string.Empty;

    /// <summary>
    /// Contact person - Maps to: cu_cntactp
    /// </summary>
    public string ContactPerson { get; set; } = string.Empty;

    /// <summary>
    /// Title - Maps to: cu_title
    /// </summary>
    public string Title { get; set; } = string.Empty;

    /// <summary>
    /// City code - Maps to: cu_city
    /// </summary>
    public string? CityCode { get; set; }

    /// <summary>
    /// Country code - Maps to: cu_country
    /// </summary>
    public int CountryCode { get; set; }

    /// <summary>
    /// Credit limit - Maps to: cu_crlmt
    /// </summary>
    public decimal CreditLimit { get; set; }

    /// <summary>
    /// Payment terms (days) - Maps to: cu_pymnt
    /// </summary>
    public int PaymentTerms { get; set; }

    /// <summary>
    /// Status - Maps to: cu_status
    /// </summary>
    public int Status { get; set; }

    /// <summary>
    /// Opening balance - Maps to: cu_opnbal
    /// </summary>
    public decimal? OpeningBalance { get; set; }

    /// <summary>
    /// Current balance - Maps to: cu_curbal
    /// </summary>
    public decimal? CurrentBalance { get; set; }

    /// <summary>
    /// Currency code - Maps to: cf_fcy
    /// </summary>
    public string CurrencyCode { get; set; } = string.Empty;

    /// <summary>
    /// Opening foreign currency - Maps to: cf_opnfcy
    /// </summary>
    public decimal? OpeningForeignCurrency { get; set; }

    /// <summary>
    /// Current foreign currency - Maps to: cf_curfcy
    /// </summary>
    public decimal? CurrentForeignCurrency { get; set; }

    /// <summary>
    /// Cross reference - Maps to: cu_xrf
    /// </summary>
    public string CrossReference { get; set; } = string.Empty;

    /// <summary>
    /// Allow credit - Maps to: cu_alwcr
    /// </summary>
    public bool AllowCredit { get; set; }

    /// <summary>
    /// Control serial account - Maps to: cu_ctlser
    /// </summary>
    public string ControlSerialAccount { get; set; } = string.Empty;

    /// <summary>
    /// Local allocated - Maps to: cu_lcaloc
    /// </summary>
    public decimal? LocalAllocated { get; set; }

    /// <summary>
    /// Foreign allocated - Maps to: cu_fcaloc
    /// </summary>
    public decimal? ForeignAllocated { get; set; }

    /// <summary>
    /// Common code - Maps to: cmncode
    /// </summary>
    public string CommonCode { get; set; } = string.Empty;

    /// <summary>
    /// Warehouse number - Maps to: whno
    /// </summary>
    public string? WarehouseNo { get; set; }

    /// <summary>
    /// Section code - Maps to: section
    /// </summary>
    public string? Section { get; set; }

    /// <summary>
    /// Vendor tax code - Maps to: vndr_taxcode
    /// </summary>
    public string? VendorTaxCode { get; set; }

    /// <summary>
    /// Is tax free - Maps to: taxFree
    /// </summary>
    public bool? IsTaxFree { get; set; }

    /// <summary>
    /// Kind - Maps to: cu_kind
    /// </summary>
    public string? Kind { get; set; }

    /// <summary>
    /// Type - Maps to: cu_type
    /// </summary>
    public string? Type { get; set; }

    /// <summary>
    /// Price includes VAT - Maps to: PriceIncludeVat
    /// </summary>
    public bool? PriceIncludesVAT { get; set; }

    /// <summary>
    /// Send SMS - Maps to: cu_sendsms
    /// </summary>
    public bool? SendSMS { get; set; }

    /// <summary>
    /// User ID - Maps to: usrid
    /// </summary>
    public string? UserId { get; set; }

    /// <summary>
    /// User ID changed - Maps to: usridchg
    /// </summary>
    public string? UserIdChanged { get; set; }

    /// <summary>
    /// Added date (YYYYMMDD) - Maps to: Added_date
    /// </summary>
    public string? AddedDate { get; set; }

    /// <summary>
    /// Last update date (YYYYMMDD) - Maps to: lastupdt
    /// </summary>
    public string LastUpdateDate { get; set; } = string.Empty;

    /// <summary>
    /// Modified flag - Maps to: modified
    /// </summary>
    public bool Modified { get; set; }
}
