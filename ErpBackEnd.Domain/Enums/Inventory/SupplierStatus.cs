namespace ErpBackEnd.Domain.Enums.Inventory;

/// <summary>
/// Represents supplier/vendor status
/// </summary>
public enum SupplierStatus
{
    /// <summary>
    /// Active supplier
    /// </summary>
    Active = 0,

    /// <summary>
    /// Inactive supplier
    /// </summary>
    Inactive = 1,

    /// <summary>
    /// Suspended supplier
    /// </summary>
    Suspended = 2,

    /// <summary>
    /// Blacklisted supplier
    /// </summary>
    Blacklisted = 3
}
