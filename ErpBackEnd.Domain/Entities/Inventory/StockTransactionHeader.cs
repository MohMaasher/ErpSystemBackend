namespace ErpBackEnd.Domain.Entities.Inventory;

/// <summary>
/// Represents a stock transaction header
/// Maps to: sthdr table
/// </summary>
public class StockTransactionHeader
{
    /// <summary>
    /// Branch code - Maps to: branch
    /// </summary>
    public string BranchCode { get; set; } = string.Empty;

    /// <summary>
    /// Transaction type code - Maps to: trtype
    /// </summary>
    public string TransactionType { get; set; } = string.Empty;

    /// <summary>
    /// Reference number - Maps to: refno
    /// </summary>
    public int ReferenceNo { get; set; }

    /// <summary>
    /// Transaction date (YYYYMMDD) - Maps to: trdate
    /// </summary>
    public string TransactionDate { get; set; } = string.Empty;

    /// <summary>
    /// Description - Maps to: description
    /// </summary>
    public string? Description { get; set; }

    /// <summary>
    /// Amount total - Maps to: amnttl
    /// </summary>
    public decimal AmountTotal { get; set; }

    /// <summary>
    /// Cost total - Maps to: costttl
    /// </summary>
    public decimal CostTotal { get; set; }

    /// <summary>
    /// System date (YYYYMMDD) - Maps to: sysdate
    /// </summary>
    public string? SystemDate { get; set; }

    /// <summary>
    /// Source code - Maps to: src
    /// </summary>
    public string SourceCode { get; set; } = string.Empty;

    /// <summary>
    /// Is released - Maps to: released
    /// </summary>
    public bool IsReleased { get; set; }

    /// <summary>
    /// Is posted - Maps to: posted
    /// </summary>
    public bool IsPosted { get; set; }

    /// <summary>
    /// Foreign currency code - Maps to: fcy
    /// </summary>
    public string CurrencyCode { get; set; } = string.Empty;

    /// <summary>
    /// Foreign currency rate - Maps to: fcyrate
    /// </summary>
    public decimal? CurrencyRate { get; set; }

    /// <summary>
    /// Warehouse number - Maps to: whno
    /// </summary>
    public string WarehouseNo { get; set; } = string.Empty;

    /// <summary>
    /// To warehouse number (for transfers) - Maps to: towhno
    /// </summary>
    public string? ToWarehouseNo { get; set; }

    /// <summary>
    /// Number of entries - Maps to: entries
    /// </summary>
    public int? NumberOfEntries { get; set; }

    /// <summary>
    /// Last update date - Maps to: lastupdt
    /// </summary>
    public string? LastUpdateDate { get; set; }

    /// <summary>
    /// Modified flag - Maps to: modified
    /// </summary>
    public bool Modified { get; set; }

    /// <summary>
    /// Received transaction flag - Maps to: rcvdtrn
    /// </summary>
    public bool? ReceivedTransaction { get; set; }

    /// <summary>
    /// Customer number - Maps to: custno
    /// </summary>
    public string? CustomerNo { get; set; }

    /// <summary>
    /// User ID - Maps to: usrid
    /// </summary>
    public string UserId { get; set; } = string.Empty;

    /// <summary>
    /// Branch supplier - Maps to: brsupp
    /// </summary>
    public string? BranchSupplier { get; set; }

    /// <summary>
    /// To branch number (for inter-branch transfers) - Maps to: tobrno
    /// </summary>
    public string? ToBranchNo { get; set; }

    /// <summary>
    /// Branch cross reference - Maps to: brxref
    /// </summary>
    public int? BranchCrossRef { get; set; }

    /// <summary>
    /// GL reference - Maps to: glref
    /// </summary>
    public int? GLReference { get; set; }

    /// <summary>
    /// Is branch transaction - Maps to: isbrtrx
    /// </summary>
    public bool? IsBranchTransaction { get; set; }

    /// <summary>
    /// Assembly type - Maps to: asmtype
    /// </summary>
    public int? AssemblyType { get; set; }

    /// <summary>
    /// Repost flag - Maps to: repost
    /// </summary>
    public bool Repost { get; set; }

    /// <summary>
    /// Items received flag - Maps to: items_rcvd
    /// </summary>
    public bool ItemsReceived { get; set; }

    /// <summary>
    /// Transaction printed count - Maps to: trx_printed
    /// </summary>
    public int TransactionPrinted { get; set; }

    /// <summary>
    /// Price type - Maps to: pricetp
    /// </summary>
    public string? PriceType { get; set; }

    /// <summary>
    /// Damaged goods flag - Maps to: Damaged
    /// </summary>
    public bool IsDamaged { get; set; }

    // Navigation properties
    public virtual ICollection<StockTransactionDetail> Details { get; set; } = new List<StockTransactionDetail>();
}
