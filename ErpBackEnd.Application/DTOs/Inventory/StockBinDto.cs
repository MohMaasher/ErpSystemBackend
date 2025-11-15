namespace ErpBackEnd.Application.DTOs.Inventory;

/// <summary>
/// Data Transfer Object for Stock Bin
/// </summary>
public class StockBinDto
{
    public string BranchCode { get; set; } = string.Empty;
    public string ItemNo { get; set; } = string.Empty;
    public string UnitCode { get; set; } = string.Empty;
    public string WarehouseNo { get; set; } = string.Empty;
    public string BinNo { get; set; } = string.Empty;
    public decimal Quantity { get; set; }
    public decimal ReservedQuantity { get; set; }
    public decimal AvailableQuantity => Quantity - ReservedQuantity;
    public decimal LocalCost { get; set; }
    public string? ExpiryDate { get; set; }
}

/// <summary>
/// Stock summary across all bins
/// </summary>
public class StockSummaryDto
{
    public string ItemNo { get; set; } = string.Empty;
    public string UnitCode { get; set; } = string.Empty;
    public string ProductNameEn { get; set; } = string.Empty;
    public string ProductNameAr { get; set; } = string.Empty;
    public decimal TotalQuantity { get; set; }
    public decimal TotalReserved { get; set; }
    public decimal TotalAvailable => TotalQuantity - TotalReserved;
    public decimal AverageCost { get; set; }
    public decimal TotalValue => TotalQuantity * AverageCost;
    public List<StockBinDto>? BinDetails { get; set; }
}

/// <summary>
/// Stock by warehouse
/// </summary>
public class StockByWarehouseDto
{
    public string WarehouseNo { get; set; } = string.Empty;
    public string WarehouseName { get; set; } = string.Empty;
    public decimal TotalQuantity { get; set; }
    public decimal AvailableQuantity { get; set; }
    public int UniqueProducts { get; set; }
    public decimal TotalValue { get; set; }
}
