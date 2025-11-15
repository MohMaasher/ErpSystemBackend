namespace ErpBackEnd.Application.DTOs.Inventory;

/// <summary>
/// Data Transfer Object for Product
/// </summary>
public class ProductDto
{
    public string ItemNo { get; set; } = string.Empty;
    public string NameEn { get; set; } = string.Empty;
    public string NameAr { get; set; } = string.Empty;
    public string MainGroup { get; set; } = string.Empty;
    public string SubGroup { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public string ClassKey { get; set; } = string.Empty;
    public string CompanyCode { get; set; } = string.Empty;
    public string SupplierCode { get; set; } = string.Empty;
    public int BrandId { get; set; }
    public string? ModelNo { get; set; }
    public string ItemType { get; set; } = "S";
    public bool IsTaxFree { get; set; }
    public bool NoSales { get; set; }
    public bool AllowsExpiryDate { get; set; }
    public decimal? VATPrice { get; set; }

    // Related data (optional - can be loaded on demand)
    public List<ProductUnitDto>? Units { get; set; }
}

/// <summary>
/// Minimal product DTO for list views
/// </summary>
public class ProductListDto
{
    public string ItemNo { get; set; } = string.Empty;
    public string NameEn { get; set; } = string.Empty;
    public string NameAr { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public string SupplierCode { get; set; } = string.Empty;
    public bool IsActive { get; set; } = true;
}

/// <summary>
/// Product with full details including units and stock
/// </summary>
public class ProductDetailDto : ProductDto
{
    public decimal? TotalStockQuantity { get; set; }
    public decimal? TotalAvailableQuantity { get; set; }
    public decimal? TotalReservedQuantity { get; set; }
    public string? SupplierName { get; set; }
    public string? BrandName { get; set; }
}
