namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents a warehouse/storage location
/// Maps to: stwhous table
/// </summary>
public class Warehouse
{
    /// <summary>
    /// Warehouse number (Primary Key) - Maps to: whno
    /// </summary>
    public string WarehouseNo { get; set; } = string.Empty;

    /// <summary>
    /// Warehouse name (English) - Maps to: name
    /// </summary>
    public string NameEn { get; set; } = string.Empty;

    /// <summary>
    /// Warehouse name (Arabic) - Maps to: lname
    /// </summary>
    public string NameAr { get; set; } = string.Empty;

    /// <summary>
    /// Branch code - Maps to: branch
    /// </summary>
    public string BranchCode { get; set; } = string.Empty;

    /// <summary>
    /// Manager name - Maps to: manager
    /// </summary>
    public string Manager { get; set; } = string.Empty;

    /// <summary>
    /// Phone number - Maps to: phone
    /// </summary>
    public string Phone { get; set; } = string.Empty;

    /// <summary>
    /// Fax number - Maps to: fax
    /// </summary>
    public string Fax { get; set; } = string.Empty;

    /// <summary>
    /// Address - Maps to: address
    /// </summary>
    public string Address { get; set; } = string.Empty;

    /// <summary>
    /// Serial number account - Maps to: srwhs
    /// </summary>
    public string SerialAccount { get; set; } = string.Empty;

    /// <summary>
    /// Cost center code - Maps to: cstcode
    /// </summary>
    public string? CostCenterCode { get; set; }

    /// <summary>
    /// Sales center code - Maps to: sc_code
    /// </summary>
    public string? SalesCenterCode { get; set; }

    /// <summary>
    /// Print finished goods - Maps to: prnt_fsh
    /// </summary>
    public bool? PrintFinishedGoods { get; set; }

    /// <summary>
    /// Account at end of period - Maps to: ac_end_prd
    /// </summary>
    public string? AccountEndOfPeriod { get; set; }

    /// <summary>
    /// No auto sales - Maps to: no_autosales
    /// </summary>
    public bool NoAutoSales { get; set; }

    /// <summary>
    /// Is suspended - Maps to: suspended
    /// </summary>
    public bool IsSuspended { get; set; }

    /// <summary>
    /// Bin serial number - Maps to: binsrlno
    /// </summary>
    public string? BinSerialNo { get; set; }

    /// <summary>
    /// Transfer from must have bin number - Maps to: xfrfm_mustbinnno
    /// </summary>
    public bool TransferFromRequiresBin { get; set; }

    /// <summary>
    /// Transfer to must have bin number - Maps to: xfrto_mustbinnno
    /// </summary>
    public bool TransferToRequiresBin { get; set; }

    /// <summary>
    /// Last update date - Maps to: lastupdt
    /// </summary>
    public string LastUpdateDate { get; set; } = string.Empty;

    /// <summary>
    /// Modified flag - Maps to: modified
    /// </summary>
    public bool Modified { get; set; }

    // Navigation properties
    public virtual ICollection<StockBin> StockBins { get; set; } = new List<StockBin>();
}
