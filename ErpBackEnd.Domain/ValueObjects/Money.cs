namespace ErpBackEnd.Domain.ValueObjects;

/// <summary>
/// Value object representing monetary amount with currency
/// </summary>
public record Money
{
    public decimal Amount { get; init; }
    public string Currency { get; init; } = "SAR"; // Default to Saudi Riyal

    public Money(decimal amount, string currency = "SAR")
    {
        if (amount < 0)
            throw new ArgumentException("Amount cannot be negative", nameof(amount));

        if (string.IsNullOrWhiteSpace(currency))
            throw new ArgumentException("Currency cannot be empty", nameof(currency));

        Amount = amount;
        Currency = currency.ToUpperInvariant();
    }

    public static Money Zero(string currency = "SAR") => new(0, currency);

    public static Money operator +(Money a, Money b)
    {
        if (a.Currency != b.Currency)
            throw new InvalidOperationException($"Cannot add amounts in different currencies: {a.Currency} and {b.Currency}");

        return new Money(a.Amount + b.Amount, a.Currency);
    }

    public static Money operator -(Money a, Money b)
    {
        if (a.Currency != b.Currency)
            throw new InvalidOperationException($"Cannot subtract amounts in different currencies: {a.Currency} and {b.Currency}");

        return new Money(a.Amount - b.Amount, a.Currency);
    }

    public static Money operator *(Money money, decimal multiplier)
    {
        return new Money(money.Amount * multiplier, money.Currency);
    }

    public static bool operator >(Money a, Money b)
    {
        if (a.Currency != b.Currency)
            throw new InvalidOperationException($"Cannot compare amounts in different currencies: {a.Currency} and {b.Currency}");

        return a.Amount > b.Amount;
    }

    public static bool operator <(Money a, Money b)
    {
        if (a.Currency != b.Currency)
            throw new InvalidOperationException($"Cannot compare amounts in different currencies: {a.Currency} and {b.Currency}");

        return a.Amount < b.Amount;
    }

    public override string ToString() => $"{Amount:N2} {Currency}";
}
