namespace ErpBackEnd.Application.DTOs.Inventory;

/// <summary>
/// Data Transfer Object for Product Unit
/// </summary>
public class ProductUnitDto
{
    public string ItemNo { get; set; } = string.Empty;
    public string UnitCode { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Barcode { get; set; } = string.Empty;

    // Cost
    public decimal LocalCost { get; set; }
    public decimal ForeignCost { get; set; }

    // Pricing
    public decimal LocalPrice1 { get; set; }
    public decimal LocalPrice2 { get; set; }
    public decimal LocalPrice3 { get; set; }
    public decimal MinimumPrice { get; set; }
    public decimal MaxDiscount1 { get; set; }
    public decimal MaxDiscount2 { get; set; }
    public decimal MaxDiscount3 { get; set; }

    // Stock
    public decimal? CurrentBalance { get; set; }
    public decimal? ReservedQuantity { get; set; }
    public decimal? AvailableQuantity => (CurrentBalance ?? 0) - (ReservedQuantity ?? 0);
    public decimal MinimumStock { get; set; }
    public decimal MaximumStock { get; set; }
    public decimal ReorderLevel { get; set; }

    // Packing
    public string Pack1 { get; set; } = string.Empty;
    public decimal PackQuantity1 { get; set; }
    public string Pack2 { get; set; } = string.Empty;
    public decimal PackQuantity2 { get; set; }

    // Flags
    public bool IsInactive { get; set; }
    public bool AllowDecimal { get; set; }
}

/// <summary>
/// Product unit with stock bin details
/// </summary>
public class ProductUnitWithStockDto : ProductUnitDto
{
    public List<StockBinDto>? StockBins { get; set; }
}

/// <summary>
/// Create product unit request
/// </summary>
public class CreateProductUnitDto
{
    public string ItemNo { get; set; } = string.Empty;
    public string UnitCode { get; set; } = string.Empty;
    public string Name { get; set; } = string.Empty;
    public string Barcode { get; set; } = string.Empty;
    public decimal LocalCost { get; set; }
    public decimal LocalPrice1 { get; set; }
    public decimal MinimumStock { get; set; }
    public decimal MaximumStock { get; set; }
    public decimal ReorderLevel { get; set; }
}

/// <summary>
/// Update product unit request
/// </summary>
public class UpdateProductUnitDto : CreateProductUnitDto
{
    public decimal? LocalPrice2 { get; set; }
    public decimal? LocalPrice3 { get; set; }
    public decimal MaxDiscount1 { get; set; }
    public decimal MaxDiscount2 { get; set; }
    public decimal MaxDiscount3 { get; set; }
    public bool IsInactive { get; set; }
}
