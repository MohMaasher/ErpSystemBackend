namespace ErpBackEnd.Domain.Enums.Inventory;

/// <summary>
/// Represents the type of inventory item
/// </summary>
public enum ItemType
{
    /// <summary>
    /// Stock item - Regular inventory item
    /// </summary>
    Stock = 'S',

    /// <summary>
    /// Non-stock item - Services or non-tracked items
    /// </summary>
    NonStock = 'N',

    /// <summary>
    /// Kit/Assembly - Composed of multiple items
    /// </summary>
    Kit = 'K',

    /// <summary>
    /// Service item
    /// </summary>
    Service = 'V'
}
