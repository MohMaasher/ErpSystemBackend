namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents a packing unit/unit of measure
/// Maps to: orpacking table
/// </summary>
public class PackingUnit
{
    /// <summary>
    /// Pack ID (Primary Key) - Maps to: pack_id
    /// </summary>
    public string PackId { get; set; } = string.Empty;

    /// <summary>
    /// Pack name (English) - Maps to: pkname
    /// </summary>
    public string? PackName { get; set; }

    /// <summary>
    /// Pack name (Arabic) - Maps to: lpkname
    /// </summary>
    public string LocalPackName { get; set; } = string.Empty;

    /// <summary>
    /// Pack order - Maps to: pkorder
    /// </summary>
    public string PackOrder { get; set; } = string.Empty;

    /// <summary>
    /// Pack default quantity - Maps to: pkdfqty
    /// </summary>
    public decimal? PackDefaultQuantity { get; set; }

    /// <summary>
    /// Pack wholesale flag - Maps to: pkwhlsl
    /// </summary>
    public bool PackWholesale { get; set; }

    /// <summary>
    /// Standard unit code - Maps to: standard_unit_code
    /// </summary>
    public string? StandardUnitCode { get; set; }
}
