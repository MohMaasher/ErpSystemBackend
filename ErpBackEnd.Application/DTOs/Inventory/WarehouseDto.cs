namespace ErpBackEnd.Application.DTOs.Inventory;

/// <summary>
/// Data Transfer Object for Warehouse
/// </summary>
public class WarehouseDto
{
    public string WarehouseNo { get; set; } = string.Empty;
    public string NameEn { get; set; } = string.Empty;
    public string NameAr { get; set; } = string.Empty;
    public string BranchCode { get; set; } = string.Empty;
    public string Manager { get; set; } = string.Empty;
    public string Phone { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
    public bool IsSuspended { get; set; }
    public bool NoAutoSales { get; set; }
}

/// <summary>
/// Create warehouse request
/// </summary>
public class CreateWarehouseDto
{
    public string WarehouseNo { get; set; } = string.Empty;
    public string NameEn { get; set; } = string.Empty;
    public string NameAr { get; set; } = string.Empty;
    public string BranchCode { get; set; } = string.Empty;
    public string Manager { get; set; } = string.Empty;
    public string Phone { get; set; } = string.Empty;
    public string Address { get; set; } = string.Empty;
}

/// <summary>
/// Update warehouse request
/// </summary>
public class UpdateWarehouseDto : CreateWarehouseDto
{
    public bool IsSuspended { get; set; }
    public bool NoAutoSales { get; set; }
}
