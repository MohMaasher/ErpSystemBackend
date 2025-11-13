# ZATCA E-Invoicing Integration Documentation

## Overview
This document covers the implementation of Saudi Arabia's ZATCA (Zakat, Tax and Customs Authority) e-invoicing requirements, specifically Phase 2 (Integration Phase).

## ZATCA Requirements Summary

### Phase 2 - Integration Phase
- **Mandatory for:** Companies with revenue > 3 million SAR
- **Start Date:** January 1, 2024 (phased rollout)
- **Key Requirements:**
  - Real-time invoice reporting to ZATCA
  - Invoice clearance for B2B transactions
  - QR code generation with specific format
  - Digital signature and cryptographic stamp
  - UUID for each invoice

## Technical Implementation

### 1. Invoice Structure (UBL 2.1 Format)
```xml
<?xml version="1.0" encoding="UTF-8"?>
<Invoice xmlns="urn:oasis:names:specification:ubl:schema:xsd:Invoice-2"
         xmlns:cac="urn:oasis:names:specification:ubl:schema:xsd:CommonAggregateComponents-2"
         xmlns:cbc="urn:oasis:names:specification:ubl:schema:xsd:CommonBasicComponents-2">
    <!-- Invoice content following ZATCA specifications -->
</Invoice>
```

### 2. QR Code Format
```csharp
public class ZatcaQRCodeGenerator
{
    public string GenerateQRCode(ZatcaInvoice invoice)
    {
        var tlvData = new List<TLVField>
        {
            new TLVField(1, invoice.SellerName),
            new TLVField(2, invoice.VATNumber),
            new TLVField(3, invoice.Timestamp.ToString("yyyy-MM-dd'T'HH:mm:ss'Z'")),
            new TLVField(4, invoice.TotalWithVAT.ToString("F2")),
            new TLVField(5, invoice.VATAmount.ToString("F2")),
            new TLVField(6, invoice.Hash),
            new TLVField(7, invoice.PublicKey),
            new TLVField(8, invoice.Signature),
            new TLVField(9, invoice.CertificateSignature) // Phase 2 only
        };

        var tlvBytes = EncodeTLV(tlvData);
        return Convert.ToBase64String(tlvBytes);
    }

    private byte[] EncodeTLV(List<TLVField> fields)
    {
        using var stream = new MemoryStream();
        foreach (var field in fields)
        {
            stream.WriteByte(field.Tag);
            var valueBytes = Encoding.UTF8.GetBytes(field.Value);
            stream.WriteByte((byte)valueBytes.Length);
            stream.Write(valueBytes, 0, valueBytes.Length);
        }
        return stream.ToArray();
    }
}
```

### 3. Invoice Types
```csharp
public enum ZatcaInvoiceType
{
    Standard = 388,           // Standard Invoice
    Simplified = 383,        // Simplified Tax Invoice
    StandardCreditNote = 381, // Credit Note
    StandardDebitNote = 383,  // Debit Note
    SimplifiedCreditNote = 381,
    SimplifiedDebitNote = 383
}

public enum ZatcaTransactionType
{
    B2B,     // Business to Business (Clearance required)
    B2C,     // Business to Consumer (Reporting only)
    B2G,     // Business to Government
    Export   // Export transactions (0% VAT)
}
```

### 4. API Integration Service
```csharp
public interface IZatcaService
{
    Task<ZatcaClearanceResponse> ClearInvoiceAsync(ZatcaInvoice invoice);
    Task<ZatcaReportingResponse> ReportInvoiceAsync(ZatcaInvoice invoice);
    Task<ZatcaComplianceResponse> ValidateInvoiceAsync(ZatcaInvoice invoice);
    Task<string> GenerateCSIDAsync(ZatcaOnboardingRequest request);
}

public class ZatcaService : IZatcaService
{
    private readonly HttpClient _httpClient;
    private readonly IZatcaCryptoService _cryptoService;
    private readonly ILogger<ZatcaService> _logger;
    private readonly ZatcaSettings _settings;

    public ZatcaService(
        HttpClient httpClient, 
        IZatcaCryptoService cryptoService,
        IOptions<ZatcaSettings> settings,
        ILogger<ZatcaService> logger)
    {
        _httpClient = httpClient;
        _cryptoService = cryptoService;
        _settings = settings.Value;
        _logger = logger;
    }

    public async Task<ZatcaClearanceResponse> ClearInvoiceAsync(ZatcaInvoice invoice)
    {
        // Step 1: Validate invoice locally
        var validationResult = await ValidateInvoiceAsync(invoice);
        if (!validationResult.IsValid)
        {
            throw new ZatcaValidationException(validationResult.Errors);
        }

        // Step 2: Sign the invoice
        var signedInvoice = await _cryptoService.SignInvoiceAsync(invoice);

        // Step 3: Convert to UBL format
        var ublInvoice = ConvertToUBL(signedInvoice);

        // Step 4: Submit for clearance
        var request = new HttpRequestMessage(HttpMethod.Post, $"{_settings.BaseUrl}/clearance")
        {
            Content = new StringContent(ublInvoice, Encoding.UTF8, "application/xml"),
            Headers = 
            {
                { "Accept-Version", "V2" },
                { "Accept-Language", "en" },
                { "OTP", await GetOTPAsync() },
                { "Authorization", $"Bearer {_settings.AccessToken}" }
            }
        };

        var response = await _httpClient.SendAsync(request);
        var responseContent = await response.Content.ReadAsStringAsync();

        if (response.IsSuccessStatusCode)
        {
            return JsonSerializer.Deserialize<ZatcaClearanceResponse>(responseContent);
        }

        _logger.LogError("ZATCA clearance failed: {Response}", responseContent);
        throw new ZatcaApiException($"Clearance failed: {responseContent}");
    }

    public async Task<ZatcaReportingResponse> ReportInvoiceAsync(ZatcaInvoice invoice)
    {
        // Similar to clearance but for B2C transactions
        // No clearance required, just reporting
    }

    private string ConvertToUBL(ZatcaInvoice invoice)
    {
        // Convert invoice to UBL 2.1 XML format
        // Implementation depends on ZATCA specifications
    }
}
```

### 5. Cryptographic Operations
```csharp
public interface IZatcaCryptoService
{
    Task<ZatcaInvoice> SignInvoiceAsync(ZatcaInvoice invoice);
    Task<string> GenerateInvoiceHashAsync(ZatcaInvoice invoice);
    Task<bool> ValidateSignatureAsync(ZatcaInvoice invoice);
}

public class ZatcaCryptoService : IZatcaCryptoService
{
    private readonly X509Certificate2 _certificate;
    
    public ZatcaCryptoService(IOptions<ZatcaSettings> settings)
    {
        _certificate = LoadCertificate(settings.Value.CertificatePath, settings.Value.CertificatePassword);
    }

    public async Task<ZatcaInvoice> SignInvoiceAsync(ZatcaInvoice invoice)
    {
        // Step 1: Generate invoice hash
        invoice.Hash = await GenerateInvoiceHashAsync(invoice);
        
        // Step 2: Create digital signature
        using var rsa = _certificate.GetRSAPrivateKey();
        var invoiceBytes = Encoding.UTF8.GetBytes(invoice.ToCanonicalString());
        var signature = rsa.SignData(invoiceBytes, HashAlgorithmName.SHA256, RSASignaturePadding.Pkcs1);
        invoice.Signature = Convert.ToBase64String(signature);
        
        // Step 3: Add certificate chain
        invoice.CertificateChain = Convert.ToBase64String(_certificate.Export(X509ContentType.Cert));
        
        return invoice;
    }

    public async Task<string> GenerateInvoiceHashAsync(ZatcaInvoice invoice)
    {
        var canonicalInvoice = invoice.ToCanonicalString();
        using var sha256 = SHA256.Create();
        var hashBytes = sha256.ComputeHash(Encoding.UTF8.GetBytes(canonicalInvoice));
        return Convert.ToBase64String(hashBytes);
    }
}
```

### 6. Database Schema for ZATCA
```sql
-- ZATCA Invoice Metadata
CREATE TABLE ZatcaInvoices (
    ZatcaInvoiceId INT PRIMARY KEY IDENTITY(1,1),
    InvoiceId INT NOT NULL FOREIGN KEY REFERENCES Invoices(InvoiceId),
    UUID UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID(),
    InvoiceHash NVARCHAR(500) NOT NULL,
    QRCode NVARCHAR(MAX) NOT NULL,
    PIH NVARCHAR(500) NULL, -- Previous Invoice Hash
    InvoiceCounter INT NOT NULL,
    ClearanceStatus INT NOT NULL, -- Pending, Cleared, Rejected, Reported
    ClearanceDateTime DATETIME2 NULL,
    ZatcaResponse NVARCHAR(MAX) NULL, -- JSON response from ZATCA
    RetryCount INT NOT NULL DEFAULT 0,
    LastRetryDate DATETIME2 NULL,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    CONSTRAINT UK_ZatcaInvoice_UUID UNIQUE (UUID)
)

-- ZATCA Configuration
CREATE TABLE ZatcaConfiguration (
    ConfigId INT PRIMARY KEY IDENTITY(1,1),
    TenantId INT NOT NULL,
    CSID NVARCHAR(500) NOT NULL, -- Cryptographic Stamp Identifier
    CSIDExpiryDate DATETIME2 NOT NULL,
    PrivateKey NVARCHAR(MAX) NOT NULL, -- Encrypted
    PublicKey NVARCHAR(MAX) NOT NULL,
    CertificateChain NVARCHAR(MAX) NOT NULL,
    Environment NVARCHAR(20) NOT NULL, -- Sandbox, Production
    IsActive BIT NOT NULL DEFAULT 1,
    CreatedDate DATETIME2 NOT NULL DEFAULT GETUTCDATE(),
    ModifiedDate DATETIME2 NULL
)

-- ZATCA Error Log
CREATE TABLE ZatcaErrorLog (
    ErrorId INT PRIMARY KEY IDENTITY(1,1),
    InvoiceId INT NULL,
    ErrorCode NVARCHAR(50) NOT NULL,
    ErrorMessage NVARCHAR(MAX) NOT NULL,
    ErrorDetails NVARCHAR(MAX) NULL,
    Timestamp DATETIME2 NOT NULL DEFAULT GETUTCDATE()
)
```

### 7. ZATCA Compliance Validator
```csharp
public class ZatcaInvoiceValidator : AbstractValidator<ZatcaInvoice>
{
    public ZatcaInvoiceValidator()
    {
        RuleFor(x => x.SellerName)
            .NotEmpty().WithMessage("Seller name is required")
            .MaximumLength(300).WithMessage("Seller name cannot exceed 300 characters");

        RuleFor(x => x.VATNumber)
            .NotEmpty().WithMessage("VAT number is required")
            .Matches(@"^3\d{14}$").WithMessage("VAT number must start with 3 and be 15 digits");

        RuleFor(x => x.InvoiceDate)
            .NotEmpty().WithMessage("Invoice date is required")
            .LessThanOrEqualTo(DateTime.UtcNow).WithMessage("Invoice date cannot be in the future");

        RuleFor(x => x.TotalWithVAT)
            .GreaterThan(0).WithMessage("Total amount must be greater than zero");

        RuleFor(x => x.VATAmount)
            .GreaterThanOrEqualTo(0).WithMessage("VAT amount cannot be negative");

        RuleFor(x => x.BuyerVATNumber)
            .Matches(@"^3\d{14}$")
            .When(x => x.TransactionType == ZatcaTransactionType.B2B)
            .WithMessage("Buyer VAT number is required for B2B transactions");

        RuleFor(x => x.InvoiceLines)
            .NotEmpty().WithMessage("Invoice must have at least one line item")
            .ForEach(line => line.SetValidator(new ZatcaInvoiceLineValidator()));
    }
}

public class ZatcaInvoiceLineValidator : AbstractValidator<ZatcaInvoiceLine>
{
    public ZatcaInvoiceLineValidator()
    {
        RuleFor(x => x.ItemName)
            .NotEmpty().WithMessage("Item name is required");

        RuleFor(x => x.Quantity)
            .GreaterThan(0).WithMessage("Quantity must be greater than zero");

        RuleFor(x => x.UnitPrice)
            .GreaterThanOrEqualTo(0).WithMessage("Unit price cannot be negative");

        RuleFor(x => x.VATRate)
            .Must(rate => new[] { 0m, 5m, 15m }.Contains(rate))
            .WithMessage("VAT rate must be 0%, 5%, or 15%");
    }
}
```

## ZATCA Integration Workflow

### Invoice Creation Flow
1. Create invoice in ERP system
2. Validate invoice data
3. Generate UUID and invoice counter
4. Calculate invoice hash (including PIH)
5. Sign invoice with private key
6. Generate QR code
7. Submit to ZATCA API:
   - B2B: Clearance endpoint (real-time)
   - B2C: Reporting endpoint (within 24 hours)
8. Store ZATCA response
9. Update invoice status

### Error Handling
```csharp
public class ZatcaRetryPolicy
{
    private readonly ILogger<ZatcaRetryPolicy> _logger;
    
    public async Task<T> ExecuteWithRetryAsync<T>(
        Func<Task<T>> operation,
        int maxRetries = 3,
        int baseDelayMs = 1000)
    {
        for (int i = 0; i < maxRetries; i++)
        {
            try
            {
                return await operation();
            }
            catch (ZatcaApiException ex) when (IsRetriable(ex) && i < maxRetries - 1)
            {
                var delay = baseDelayMs * Math.Pow(2, i); // Exponential backoff
                _logger.LogWarning($"ZATCA operation failed, retrying in {delay}ms. Attempt {i + 1}/{maxRetries}");
                await Task.Delay(TimeSpan.FromMilliseconds(delay));
            }
        }
        
        throw new ZatcaMaxRetriesExceededException($"Operation failed after {maxRetries} attempts");
    }
    
    private bool IsRetriable(ZatcaApiException ex)
    {
        // Network errors and 5xx errors are retriable
        return ex.StatusCode >= 500 || ex.IsNetworkError;
    }
}
```

## Testing

### Sandbox Environment
- Base URL: `https://gw-apic-gov.gazt.gov.sa/e-invoicing/developer-portal`
- Test VAT Numbers: Provided by ZATCA
- Test Scenarios: Cover all invoice types and error cases

### Test Data Generator
```csharp
public class ZatcaTestDataGenerator
{
    public ZatcaInvoice GenerateTestInvoice(ZatcaTransactionType type)
    {
        return new ZatcaInvoice
        {
            InvoiceNumber = $"INV-{DateTime.Now.Ticks}",
            InvoiceDate = DateTime.UtcNow,
            TransactionType = type,
            SellerName = "Test Company Ltd",
            VATNumber = "300000000000003", // Test VAT number
            BuyerName = type == ZatcaTransactionType.B2B ? "Test Buyer Company" : "Walk-in Customer",
            BuyerVATNumber = type == ZatcaTransactionType.B2B ? "311111111111113" : null,
            InvoiceLines = GenerateTestLines(),
            // Calculate totals...
        };
    }
}
```

## Compliance Checklist

- [ ] UBL 2.1 XML format implementation
- [ ] Digital signature using qualified certificate
- [ ] QR code generation with all required fields
- [ ] Invoice hash chain (PIH) implementation
- [ ] UUID generation for each invoice
- [ ] API integration (clearance and reporting)
- [ ] Error handling and retry logic
- [ ] Audit trail for all ZATCA operations
- [ ] Sandbox testing completed
- [ ] Production certificate obtained
- [ ] Monitoring and alerting configured
- [ ] Backup submission mechanism
- [ ] Compliance validation rules
- [ ] Performance optimization (<3 seconds response)

## Monitoring

### Key Metrics
- Clearance success rate
- Average clearance time
- Failed invoice count
- Retry rate
- API availability

### Alerts
- Clearance failures > 5% in 1 hour
- API timeout > 10 seconds
- Certificate expiry < 30 days
- CSID expiry < 7 days

## References
- [ZATCA E-Invoicing Portal](https://zatca.gov.sa/en/E-Invoicing/Pages/default.aspx)
- [Developer Guidelines](https://zatca.gov.sa/en/E-Invoicing/SystemsDevelopers/Pages/default.aspx)
- [XML Implementation Standards](https://zatca.gov.sa/en/E-Invoicing/SystemsDevelopers/Documents/20230519_EInvoicing_XML_Implementation_Standard_vF.pdf)
- [API Documentation](https://zatca.gov.sa/en/E-Invoicing/SystemsDevelopers/Documents/E-invoicing_API_Documentation.pdf)