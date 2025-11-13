# API Validation with FluentValidation

## Base Validator
```csharp
using FluentValidation;
using System.Text.RegularExpressions;

public abstract class BaseValidator<T> : AbstractValidator<T> where T : class
{
    protected bool BeAValidGuid(string guid)
    {
        return Guid.TryParse(guid, out _);
    }

    protected bool BeAValidEmail(string email)
    {
        try
        {
            var addr = new System.Net.Mail.MailAddress(email);
            return addr.Address == email;
        }
        catch
        {
            return false;
        }
    }

    protected bool BeAValidPhoneNumber(string phone)
    {
        // Saudi phone number validation
        return Regex.IsMatch(phone, @"^(\+966|0)?5[0-9]{8}$");
    }

    protected bool BeAValidVATNumber(string vatNumber)
    {
        // Saudi VAT number validation (15 digits)
        return Regex.IsMatch(vatNumber, @"^\d{15}$");
    }

    protected bool BeAValidCRNumber(string crNumber)
    {
        // Saudi Commercial Registration validation (10 digits)
        return Regex.IsMatch(crNumber, @"^\d{10}$");
    }
}
```

## Customer Validators
```csharp
public class CreateCustomerRequestValidator : BaseValidator<CreateCustomerRequest>
{
    public CreateCustomerRequestValidator()
    {
        RuleFor(x => x.CustomerNameAr)
            .NotEmpty().WithMessage("Arabic name is required")
            .MaximumLength(200).WithMessage("Arabic name must not exceed 200 characters")
            .Matches(@"^[\u0600-\u06FF\s]+$").WithMessage("Arabic name must contain only Arabic characters");

        RuleFor(x => x.CustomerNameEn)
            .NotEmpty().WithMessage("English name is required")
            .MaximumLength(200).WithMessage("English name must not exceed 200 characters")
            .Matches(@"^[a-zA-Z\s]+$").WithMessage("English name must contain only English characters");

        RuleFor(x => x.CustomerType)
            .IsInEnum().WithMessage("Invalid customer type");

        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required")
            .Must(BeAValidEmail).WithMessage("Invalid email format")
            .MaximumLength(100);

        RuleFor(x => x.Phone)
            .NotEmpty().WithMessage("Phone is required")
            .Must(BeAValidPhoneNumber).WithMessage("Invalid Saudi phone number");

        RuleFor(x => x.VATNumber)
            .Must(BeAValidVATNumber).When(x => !string.IsNullOrEmpty(x.VATNumber))
            .WithMessage("VAT number must be exactly 15 digits");

        RuleFor(x => x.CRNumber)
            .Must(BeAValidCRNumber).When(x => x.CustomerType == CustomerType.Company)
            .WithMessage("CR number is required for companies and must be 10 digits");

        RuleFor(x => x.CreditLimit)
            .GreaterThanOrEqualTo(0).WithMessage("Credit limit cannot be negative")
            .LessThanOrEqualTo(1000000).WithMessage("Credit limit cannot exceed 1,000,000");

        RuleForEach(x => x.Addresses)
            .SetValidator(new AddressValidator());
    }
}

public class UpdateCustomerRequestValidator : BaseValidator<UpdateCustomerRequest>
{
    public UpdateCustomerRequestValidator()
    {
        RuleFor(x => x.CustomerNameAr)
            .MaximumLength(200).When(x => !string.IsNullOrEmpty(x.CustomerNameAr))
            .Matches(@"^[\u0600-\u06FF\s]+$").When(x => !string.IsNullOrEmpty(x.CustomerNameAr));

        RuleFor(x => x.CustomerNameEn)
            .MaximumLength(200).When(x => !string.IsNullOrEmpty(x.CustomerNameEn))
            .Matches(@"^[a-zA-Z\s]+$").When(x => !string.IsNullOrEmpty(x.CustomerNameEn));

        RuleFor(x => x.Email)
            .Must(BeAValidEmail).When(x => !string.IsNullOrEmpty(x.Email));

        RuleFor(x => x.Phone)
            .Must(BeAValidPhoneNumber).When(x => !string.IsNullOrEmpty(x.Phone));

        RuleFor(x => x.CreditLimit)
            .GreaterThanOrEqualTo(0).When(x => x.CreditLimit.HasValue)
            .LessThanOrEqualTo(1000000).When(x => x.CreditLimit.HasValue);
    }
}

public class AddressValidator : BaseValidator<AddressDto>
{
    public AddressValidator()
    {
        RuleFor(x => x.AddressType)
            .IsInEnum().WithMessage("Invalid address type");

        RuleFor(x => x.Street)
            .NotEmpty().WithMessage("Street is required")
            .MaximumLength(200);

        RuleFor(x => x.City)
            .NotEmpty().WithMessage("City is required")
            .MaximumLength(100);

        RuleFor(x => x.Country)
            .NotEmpty().WithMessage("Country is required")
            .Must(x => x == "SA").WithMessage("Only Saudi Arabia is supported");

        RuleFor(x => x.PostalCode)
            .Matches(@"^\d{5}$").When(x => !string.IsNullOrEmpty(x.PostalCode))
            .WithMessage("Postal code must be 5 digits");
    }
}
```

## Sales Order Validators
```csharp
public class CreateSalesOrderRequestValidator : BaseValidator<CreateSalesOrderRequest>
{
    private readonly ICustomerRepository _customerRepository;

    public CreateSalesOrderRequestValidator(ICustomerRepository customerRepository)
    {
        _customerRepository = customerRepository;

        RuleFor(x => x.CustomerId)
            .NotEmpty().WithMessage("Customer is required")
            .MustAsync(CustomerExists).WithMessage("Customer not found");

        RuleFor(x => x.OrderDate)
            .NotEmpty().WithMessage("Order date is required")
            .LessThanOrEqualTo(DateTime.UtcNow).WithMessage("Order date cannot be in the future");

        RuleFor(x => x.PaymentTerms)
            .IsInEnum().WithMessage("Invalid payment terms");

        RuleFor(x => x.Lines)
            .NotEmpty().WithMessage("Order must have at least one line")
            .Must(x => x.Count > 0).WithMessage("Order must have at least one line");

        RuleForEach(x => x.Lines)
            .SetValidator(new OrderLineValidator());

        RuleFor(x => x.Lines)
            .Must(HaveUniqueProductIds).WithMessage("Duplicate products in order lines");
    }

    private async Task<bool> CustomerExists(Guid customerId, CancellationToken ct)
    {
        return await _customerRepository.ExistsAsync(customerId, ct);
    }

    private bool HaveUniqueProductIds(List<CreateOrderLineDto> lines)
    {
        var productIds = lines.Select(l => l.ProductId).ToList();
        return productIds.Count == productIds.Distinct().Count();
    }
}

public class OrderLineValidator : BaseValidator<CreateOrderLineDto>
{
    public OrderLineValidator()
    {
        RuleFor(x => x.ProductId)
            .NotEmpty().WithMessage("Product is required");

        RuleFor(x => x.Quantity)
            .GreaterThan(0).WithMessage("Quantity must be greater than zero")
            .LessThanOrEqualTo(10000).WithMessage("Quantity cannot exceed 10,000");

        RuleFor(x => x.UnitPrice)
            .GreaterThan(0).WithMessage("Unit price must be greater than zero")
            .LessThanOrEqualTo(1000000).WithMessage("Unit price cannot exceed 1,000,000");

        RuleFor(x => x.DiscountPercent)
            .InclusiveBetween(0, 100).WithMessage("Discount must be between 0 and 100");

        RuleFor(x => x.VATPercent)
            .Must(x => x == 0 || x == 5 || x == 15)
            .WithMessage("VAT must be 0%, 5%, or 15%");
    }
}
```

## Accounting Validators
```csharp
public class CreateAccountRequestValidator : BaseValidator<CreateAccountRequest>
{
    public CreateAccountRequestValidator()
    {
        RuleFor(x => x.AccountCode)
            .NotEmpty().WithMessage("Account code is required")
            .Matches(@"^\d{1,4}(-\d{1,4})*$").WithMessage("Invalid account code format")
            .MaximumLength(20);

        RuleFor(x => x.AccountNameAr)
            .NotEmpty().WithMessage("Arabic name is required")
            .MaximumLength(200);

        RuleFor(x => x.AccountNameEn)
            .NotEmpty().WithMessage("English name is required")
            .MaximumLength(200);

        RuleFor(x => x.AccountType)
            .IsInEnum().WithMessage("Invalid account type");

        RuleFor(x => x.AccountNature)
            .IsInEnum().WithMessage("Invalid account nature");

        RuleFor(x => x.Level)
            .InclusiveBetween(1, 5).WithMessage("Account level must be between 1 and 5");

        RuleFor(x => x.ParentAccountId)
            .NotEmpty().When(x => x.Level > 1)
            .WithMessage("Parent account is required for sub-accounts");
    }
}

public class CreateJournalEntryRequestValidator : BaseValidator<CreateJournalEntryRequest>
{
    public CreateJournalEntryRequestValidator()
    {
        RuleFor(x => x.EntryDate)
            .NotEmpty().WithMessage("Entry date is required")
            .LessThanOrEqualTo(DateTime.UtcNow);

        RuleFor(x => x.Description)
            .NotEmpty().WithMessage("Description is required")
            .MaximumLength(500);

        RuleFor(x => x.Lines)
            .NotEmpty().WithMessage("Journal entry must have at least two lines")
            .Must(x => x.Count >= 2).WithMessage("Journal entry must have at least two lines");

        RuleFor(x => x.Lines)
            .Must(BeBalanced).WithMessage("Journal entry must be balanced (Total Debit = Total Credit)");

        RuleForEach(x => x.Lines)
            .SetValidator(new JournalLineValidator());
    }

    private bool BeBalanced(List<JournalLineDto> lines)
    {
        var totalDebit = lines.Sum(l => l.DebitAmount);
        var totalCredit = lines.Sum(l => l.CreditAmount);
        return Math.Abs(totalDebit - totalCredit) < 0.01m;
    }
}

public class JournalLineValidator : BaseValidator<JournalLineDto>
{
    public JournalLineValidator()
    {
        RuleFor(x => x.AccountId)
            .NotEmpty().WithMessage("Account is required");

        RuleFor(x => x)
            .Must(x => (x.DebitAmount > 0 && x.CreditAmount == 0) || 
                      (x.CreditAmount > 0 && x.DebitAmount == 0))
            .WithMessage("Line must have either debit or credit amount, not both");

        RuleFor(x => x.DebitAmount)
            .GreaterThanOrEqualTo(0).WithMessage("Debit amount cannot be negative")
            .LessThanOrEqualTo(10000000).WithMessage("Amount exceeds maximum allowed");

        RuleFor(x => x.CreditAmount)
            .GreaterThanOrEqualTo(0).WithMessage("Credit amount cannot be negative")
            .LessThanOrEqualTo(10000000).WithMessage("Amount exceeds maximum allowed");

        RuleFor(x => x.Description)
            .MaximumLength(200).When(x => !string.IsNullOrEmpty(x.Description));
    }
}
```

## Product Validators
```csharp
public class CreateProductRequestValidator : BaseValidator<CreateProductRequest>
{
    public CreateProductRequestValidator()
    {
        RuleFor(x => x.ProductCode)
            .NotEmpty().WithMessage("Product code is required")
            .MaximumLength(50)
            .Matches(@"^[A-Z0-9-]+$").WithMessage("Product code can only contain uppercase letters, numbers, and hyphens");

        RuleFor(x => x.ProductNameAr)
            .NotEmpty().WithMessage("Arabic name is required")
            .MaximumLength(200);

        RuleFor(x => x.ProductNameEn)
            .NotEmpty().WithMessage("English name is required")
            .MaximumLength(200);

        RuleFor(x => x.Barcode)
            .Matches(@"^\d{8,13}$").When(x => !string.IsNullOrEmpty(x.Barcode))
            .WithMessage("Barcode must be 8-13 digits");

        RuleFor(x => x.CategoryId)
            .NotEmpty().WithMessage("Category is required");

        RuleFor(x => x.UnitOfMeasureId)
            .NotEmpty().WithMessage("Unit of measure is required");

        RuleFor(x => x.CostPrice)
            .GreaterThanOrEqualTo(0).WithMessage("Cost price cannot be negative")
            .LessThanOrEqualTo(1000000);

        RuleFor(x => x.SellingPrice)
            .GreaterThan(0).WithMessage("Selling price must be greater than zero")
            .LessThanOrEqualTo(1000000)
            .GreaterThan(x => x.CostPrice).WithMessage("Selling price should be greater than cost price");

        RuleFor(x => x.VATRate)
            .Must(x => x == 0 || x == 5 || x == 15)
            .WithMessage("VAT rate must be 0%, 5%, or 15%");

        RuleFor(x => x.ReorderLevel)
            .GreaterThanOrEqualTo(0).WithMessage("Reorder level cannot be negative");

        RuleFor(x => x.MinimumStock)
            .GreaterThanOrEqualTo(0).WithMessage("Minimum stock cannot be negative");

        RuleFor(x => x.MaximumStock)
            .GreaterThan(x => x.MinimumStock)
            .When(x => x.MaximumStock.HasValue)
            .WithMessage("Maximum stock must be greater than minimum stock");
    }
}
```

## Vendor Validators
```csharp
public class CreateVendorRequestValidator : BaseValidator<CreateVendorRequest>
{
    public CreateVendorRequestValidator()
    {
        RuleFor(x => x.VendorNameAr)
            .NotEmpty().WithMessage("Arabic name is required")
            .MaximumLength(200);

        RuleFor(x => x.VendorNameEn)
            .NotEmpty().WithMessage("English name is required")
            .MaximumLength(200);

        RuleFor(x => x.VendorType)
            .IsInEnum().WithMessage("Invalid vendor type");

        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required")
            .Must(BeAValidEmail).WithMessage("Invalid email format");

        RuleFor(x => x.Phone)
            .NotEmpty().WithMessage("Phone is required")
            .Must(BeAValidPhoneNumber).WithMessage("Invalid phone number");

        RuleFor(x => x.VATNumber)
            .Must(BeAValidVATNumber).When(x => !string.IsNullOrEmpty(x.VATNumber))
            .WithMessage("VAT number must be exactly 15 digits");

        RuleFor(x => x.CRNumber)
            .Must(BeAValidCRNumber).When(x => x.VendorType == VendorType.Company)
            .WithMessage("CR number is required for companies and must be 10 digits");

        RuleFor(x => x.PaymentTerms)
            .IsInEnum().WithMessage("Invalid payment terms");

        RuleFor(x => x.CreditLimit)
            .GreaterThanOrEqualTo(0).WithMessage("Credit limit cannot be negative")
            .LessThanOrEqualTo(10000000);

        RuleFor(x => x.BankAccount)
            .Matches(@"^SA\d{22}$").When(x => !string.IsNullOrEmpty(x.BankAccount))
            .WithMessage("Invalid Saudi IBAN format");
    }
}
```

## Authentication Validators
```csharp
public class LoginRequestValidator : AbstractValidator<LoginRequest>
{
    public LoginRequestValidator()
    {
        RuleFor(x => x.Username)
            .NotEmpty().WithMessage("Username is required")
            .MinimumLength(3).WithMessage("Username must be at least 3 characters")
            .MaximumLength(50);

        RuleFor(x => x.Password)
            .NotEmpty().WithMessage("Password is required")
            .MinimumLength(8).WithMessage("Password must be at least 8 characters");
    }
}

public class RegisterRequestValidator : AbstractValidator<RegisterRequest>
{
    public RegisterRequestValidator()
    {
        RuleFor(x => x.Username)
            .NotEmpty().WithMessage("Username is required")
            .MinimumLength(3).WithMessage("Username must be at least 3 characters")
            .MaximumLength(50)
            .Matches(@"^[a-zA-Z0-9_]+$").WithMessage("Username can only contain letters, numbers, and underscores");

        RuleFor(x => x.Email)
            .NotEmpty().WithMessage("Email is required")
            .EmailAddress().WithMessage("Invalid email format");

        RuleFor(x => x.Password)
            .NotEmpty().WithMessage("Password is required")
            .MinimumLength(8).WithMessage("Password must be at least 8 characters")
            .Matches("[A-Z]").WithMessage("Password must contain at least one uppercase letter")
            .Matches("[a-z]").WithMessage("Password must contain at least one lowercase letter")
            .Matches("[0-9]").WithMessage("Password must contain at least one digit")
            .Matches("[^a-zA-Z0-9]").WithMessage("Password must contain at least one special character");

        RuleFor(x => x.ConfirmPassword)
            .Equal(x => x.Password).WithMessage("Passwords do not match");

        RuleFor(x => x.FullName)
            .NotEmpty().WithMessage("Full name is required")
            .MaximumLength(100);

        RuleFor(x => x.Phone)
            .Matches(@"^(\+966|0)?5[0-9]{8}$").When(x => !string.IsNullOrEmpty(x.Phone))
            .WithMessage("Invalid Saudi phone number");
    }
}
```

## Validation Pipeline Behavior
```csharp
using MediatR;
using FluentValidation;

public class ValidationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IRequest<TResponse>
{
    private readonly IEnumerable<IValidator<TRequest>> _validators;
    private readonly ILogger<ValidationBehavior<TRequest, TResponse>> _logger;

    public ValidationBehavior(
        IEnumerable<IValidator<TRequest>> validators,
        ILogger<ValidationBehavior<TRequest, TResponse>> logger)
    {
        _validators = validators;
        _logger = logger;
    }

    public async Task<TResponse> Handle(
        TRequest request,
        RequestHandlerDelegate<TResponse> next,
        CancellationToken cancellationToken)
    {
        if (!_validators.Any())
        {
            return await next();
        }

        var context = new ValidationContext<TRequest>(request);
        
        var validationResults = await Task.WhenAll(
            _validators.Select(v => v.ValidateAsync(context, cancellationToken)));
        
        var failures = validationResults
            .SelectMany(r => r.Errors)
            .Where(f => f != null)
            .ToList();
        
        if (failures.Count != 0)
        {
            _logger.LogWarning("Validation failed for {Request}: {@Errors}",
                typeof(TRequest).Name, failures);
            
            throw new ValidationException(failures);
        }

        return await next();
    }
}
```

## Validation Exception Handler
```csharp
public class ValidationException : Exception
{
    public List<ValidationFailure> Errors { get; }

    public ValidationException(List<ValidationFailure> failures)
        : base("One or more validation failures have occurred.")
    {
        Errors = failures;
    }

    public ValidationException(string message) : base(message)
    {
        Errors = new List<ValidationFailure>();
    }
}

public class ValidationExceptionHandler : IExceptionHandler
{
    public async ValueTask<bool> TryHandleAsync(
        HttpContext httpContext,
        Exception exception,
        CancellationToken cancellationToken)
    {
        if (exception is not ValidationException validationException)
        {
            return false;
        }

        httpContext.Response.StatusCode = StatusCodes.Status400BadRequest;
        httpContext.Response.ContentType = "application/json";

        var response = new ApiErrorResponse
        {
            Success = false,
            Error = new ApiError
            {
                Code = "VALIDATION_ERROR",
                Message = "Validation failed",
                Details = validationException.Errors.Select(e => new ErrorDetail
                {
                    Field = e.PropertyName,
                    Message = e.ErrorMessage
                }).ToList()
            },
            Timestamp = DateTime.UtcNow,
            RequestId = httpContext.TraceIdentifier
        };

        await httpContext.Response.WriteAsync(
            JsonSerializer.Serialize(response),
            cancellationToken);

        return true;
    }
}
```

## Dependency Injection Setup
```csharp
// In Program.cs or Startup.cs
public static class ValidationExtensions
{
    public static IServiceCollection AddValidation(this IServiceCollection services)
    {
        // Add FluentValidation
        services.AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());
        
        // Add validation behavior for MediatR pipeline
        services.AddTransient(typeof(IPipelineBehavior<,>), typeof(ValidationBehavior<,>));
        
        // Configure FluentValidation to work with ASP.NET Core
        services.AddFluentValidationAutoValidation();
        services.AddFluentValidationClientsideAdapters();
        
        return services;
    }
}
```