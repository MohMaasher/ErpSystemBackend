# CQRS Pattern Implementation

## Command Pattern

### Command Definition
```csharp
namespace ErpBackEnd.Application.Features.Accounting.Commands;

public class CreateAccountCommand : IRequest<Result<AccountDto>>
{
    public string Code { get; set; } = string.Empty;
    public string NameAr { get; set; } = string.Empty;
    public string NameEn { get; set; } = string.Empty;
    public AccountType AccountType { get; set; }
    public AccountNature AccountNature { get; set; }
    public int? ParentAccountId { get; set; }
    public int Level { get; set; }
    public bool IsActive { get; set; } = true;
}

public class UpdateAccountCommand : IRequest<Result<AccountDto>>
{
    public int Id { get; set; }
    public string NameAr { get; set; } = string.Empty;
    public string NameEn { get; set; } = string.Empty;
    public AccountType AccountType { get; set; }
    public AccountNature AccountNature { get; set; }
    public int? ParentAccountId { get; set; }
    public bool IsActive { get; set; }
}

public class DeleteAccountCommand : IRequest<Result<bool>>
{
    public int Id { get; set; }
    
    public DeleteAccountCommand(int id)
    {
        Id = id;
    }
}
```

### Command Handler
```csharp
namespace ErpBackEnd.Application.Features.Accounting.Commands;

public class CreateAccountCommandHandler : IRequestHandler<CreateAccountCommand, Result<AccountDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IMapper _mapper;
    private readonly IValidator<CreateAccountCommand> _validator;
    private readonly ILogger<CreateAccountCommandHandler> _logger;
    private readonly IMediator _mediator;

    public CreateAccountCommandHandler(
        IUnitOfWork unitOfWork,
        IMapper mapper,
        IValidator<CreateAccountCommand> validator,
        ILogger<CreateAccountCommandHandler> logger,
        IMediator mediator)
    {
        _unitOfWork = unitOfWork;
        _mapper = mapper;
        _validator = validator;
        _logger = logger;
        _mediator = mediator;
    }

    public async Task<Result<AccountDto>> Handle(CreateAccountCommand request, CancellationToken cancellationToken)
    {
        // Validate
        var validationResult = await _validator.ValidateAsync(request, cancellationToken);
        if (!validationResult.IsValid)
        {
            return Result<AccountDto>.Failure(Error.Validation(validationResult.Errors));
        }

        try
        {
            await _unitOfWork.BeginTransactionAsync(cancellationToken: cancellationToken);

            // Check for duplicate code
            var existingAccount = await _unitOfWork.Accounts.GetByCodeAsync(request.Code, cancellationToken);
            if (existingAccount != null)
            {
                return Result<AccountDto>.Failure(Error.Conflict($"Account with code '{request.Code}' already exists"));
            }

            // Create domain entity
            var account = Account.Create(
                request.Code,
                request.NameAr,
                request.NameEn,
                request.AccountType,
                request.AccountNature,
                request.Level,
                request.ParentAccountId);

            // Persist
            var accountId = await _unitOfWork.Accounts.AddAsync(account, _unitOfWork.Transaction!, cancellationToken);
            account.Id = accountId;

            await _unitOfWork.CommitAsync(cancellationToken);

            // Publish domain event
            await _mediator.Publish(new AccountCreatedEvent(account), cancellationToken);

            _logger.LogInformation("Account created successfully. Code: {AccountCode}, Id: {AccountId}", 
                account.Code, account.Id);

            var dto = _mapper.Map<AccountDto>(account);
            return Result<AccountDto>.Success(dto, "Account created successfully");
        }
        catch (Exception ex)
        {
            await _unitOfWork.RollbackAsync(cancellationToken);
            _logger.LogError(ex, "Error creating account with code {AccountCode}", request.Code);
            return Result<AccountDto>.Failure(Error.Internal("An error occurred while creating the account"));
        }
    }
}
```

### Command Validator
```csharp
namespace ErpBackEnd.Application.Features.Accounting.Validators;

public class CreateAccountCommandValidator : AbstractValidator<CreateAccountCommand>
{
    public CreateAccountCommandValidator()
    {
        RuleFor(x => x.Code)
            .NotEmpty().WithMessage("Account code is required")
            .MaximumLength(20).WithMessage("Account code cannot exceed 20 characters")
            .Matches(@"^[A-Z0-9\-_]+$").WithMessage("Account code can only contain uppercase letters, numbers, hyphens, and underscores");

        RuleFor(x => x.NameAr)
            .NotEmpty().WithMessage("Arabic name is required")
            .MaximumLength(255).WithMessage("Arabic name cannot exceed 255 characters");

        RuleFor(x => x.NameEn)
            .NotEmpty().WithMessage("English name is required")
            .MaximumLength(255).WithMessage("English name cannot exceed 255 characters");

        RuleFor(x => x.AccountType)
            .IsInEnum().WithMessage("Invalid account type");

        RuleFor(x => x.AccountNature)
            .IsInEnum().WithMessage("Invalid account nature")
            .Must(BeValidNatureForType).WithMessage("Account nature does not match account type");

        RuleFor(x => x.Level)
            .InclusiveBetween(1, 5).WithMessage("Account level must be between 1 and 5");

        When(x => x.ParentAccountId.HasValue, () =>
        {
            RuleFor(x => x.Level)
                .GreaterThan(1).WithMessage("Child accounts must have a level greater than 1");
        });

        When(x => x.Level == 1, () =>
        {
            RuleFor(x => x.ParentAccountId)
                .Null().WithMessage("Level 1 accounts cannot have a parent");
        });
    }

    private bool BeValidNatureForType(CreateAccountCommand command, AccountNature nature)
    {
        return command.AccountType switch
        {
            AccountType.Asset => nature == AccountNature.Debit,
            AccountType.Liability => nature == AccountNature.Credit,
            AccountType.Equity => nature == AccountNature.Credit,
            AccountType.Revenue => nature == AccountNature.Credit,
            AccountType.Expense => nature == AccountNature.Debit,
            _ => false
        };
    }
}
```

## Query Pattern

### Query Definition
```csharp
namespace ErpBackEnd.Application.Features.Accounting.Queries;

public class GetAccountByIdQuery : IRequest<Result<AccountDto>>
{
    public int Id { get; set; }
    
    public GetAccountByIdQuery(int id)
    {
        Id = id;
    }
}

public class GetAccountsQuery : IRequest<Result<PagedResult<AccountDto>>>
{
    public int PageNumber { get; set; } = 1;
    public int PageSize { get; set; } = 20;
    public string? SearchTerm { get; set; }
    public AccountType? AccountType { get; set; }
    public bool? IsActive { get; set; }
    public string? SortBy { get; set; }
    public bool SortDescending { get; set; }
}

public class GetAccountBalanceQuery : IRequest<Result<AccountBalanceDto>>
{
    public int AccountId { get; set; }
    public DateTime? AsOfDate { get; set; }
    
    public GetAccountBalanceQuery(int accountId, DateTime? asOfDate = null)
    {
        AccountId = accountId;
        AsOfDate = asOfDate;
    }
}
```

### Query Handler
```csharp
namespace ErpBackEnd.Application.Features.Accounting.Queries;

public class GetAccountByIdQueryHandler : IRequestHandler<GetAccountByIdQuery, Result<AccountDto>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IMapper _mapper;
    private readonly ICacheService _cacheService;
    private readonly ILogger<GetAccountByIdQueryHandler> _logger;

    public GetAccountByIdQueryHandler(
        IUnitOfWork unitOfWork,
        IMapper mapper,
        ICacheService cacheService,
        ILogger<GetAccountByIdQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _mapper = mapper;
        _cacheService = cacheService;
        _logger = logger;
    }

    public async Task<Result<AccountDto>> Handle(GetAccountByIdQuery request, CancellationToken cancellationToken)
    {
        try
        {
            // Try to get from cache first
            var cacheKey = $"account:{request.Id}";
            var cachedAccount = await _cacheService.GetAsync<AccountDto>(cacheKey);
            
            if (cachedAccount != null)
            {
                _logger.LogDebug("Account {AccountId} retrieved from cache", request.Id);
                return Result<AccountDto>.Success(cachedAccount);
            }

            // Get from database
            var account = await _unitOfWork.Accounts.GetByIdAsync(request.Id, cancellationToken);
            
            if (account == null)
            {
                return Result<AccountDto>.Failure(Error.NotFound($"Account with ID {request.Id} not found"));
            }

            var dto = _mapper.Map<AccountDto>(account);
            
            // Cache the result
            await _cacheService.SetAsync(cacheKey, dto, TimeSpan.FromMinutes(5));
            
            return Result<AccountDto>.Success(dto);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving account with ID {AccountId}", request.Id);
            return Result<AccountDto>.Failure(Error.Internal("An error occurred while retrieving the account"));
        }
    }
}

public class GetAccountsQueryHandler : IRequestHandler<GetAccountsQuery, Result<PagedResult<AccountDto>>>
{
    private readonly IUnitOfWork _unitOfWork;
    private readonly IMapper _mapper;
    private readonly ILogger<GetAccountsQueryHandler> _logger;

    public GetAccountsQueryHandler(
        IUnitOfWork unitOfWork,
        IMapper mapper,
        ILogger<GetAccountsQueryHandler> logger)
    {
        _unitOfWork = unitOfWork;
        _mapper = mapper;
        _logger = logger;
    }

    public async Task<Result<PagedResult<AccountDto>>> Handle(GetAccountsQuery request, CancellationToken cancellationToken)
    {
        try
        {
            // Build SQL query dynamically
            var sql = new StringBuilder(@"
                SELECT 
                    AccountId AS Id,
                    Code,
                    NameAr,
                    NameEn,
                    AccountType,
                    AccountNature,
                    Level,
                    ParentAccountId,
                    IsActive,
                    Balance,
                    CreatedBy,
                    CreatedDate,
                    ModifiedBy,
                    ModifiedDate
                FROM AccountChart
                WHERE 1=1");

            var parameters = new DynamicParameters();

            // Apply filters
            if (!string.IsNullOrWhiteSpace(request.SearchTerm))
            {
                sql.AppendLine(" AND (Code LIKE @SearchTerm OR NameEn LIKE @SearchTerm OR NameAr LIKE @SearchTerm)");
                parameters.Add("SearchTerm", $"%{request.SearchTerm}%");
            }

            if (request.AccountType.HasValue)
            {
                sql.AppendLine(" AND AccountType = @AccountType");
                parameters.Add("AccountType", request.AccountType.Value);
            }

            if (request.IsActive.HasValue)
            {
                sql.AppendLine(" AND IsActive = @IsActive");
                parameters.Add("IsActive", request.IsActive.Value);
            }

            // Count total records
            var countSql = $"SELECT COUNT(*) FROM ({sql}) AS CountQuery";
            var totalCount = await _unitOfWork.Connection.ExecuteScalarAsync<int>(countSql, parameters);

            // Apply sorting
            var sortColumn = request.SortBy?.ToLower() switch
            {
                "code" => "Code",
                "namear" => "NameAr",
                "nameen" => "NameEn",
                "type" => "AccountType",
                "balance" => "Balance",
                _ => "Code"
            };

            sql.AppendLine($" ORDER BY {sortColumn} {(request.SortDescending ? "DESC" : "ASC")}");

            // Apply pagination
            sql.AppendLine(" OFFSET @Offset ROWS FETCH NEXT @PageSize ROWS ONLY");
            parameters.Add("Offset", (request.PageNumber - 1) * request.PageSize);
            parameters.Add("PageSize", request.PageSize);

            // Execute query
            var accounts = await _unitOfWork.Connection.QueryAsync<Account>(sql.ToString(), parameters);
            
            var dtos = _mapper.Map<IEnumerable<AccountDto>>(accounts);

            var pagedResult = new PagedResult<AccountDto>
            {
                Items = dtos.ToList(),
                PageNumber = request.PageNumber,
                PageSize = request.PageSize,
                TotalCount = totalCount,
                TotalPages = (int)Math.Ceiling(totalCount / (double)request.PageSize)
            };

            return Result<PagedResult<AccountDto>>.Success(pagedResult);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error retrieving accounts");
            return Result<PagedResult<AccountDto>>.Failure(Error.Internal("An error occurred while retrieving accounts"));
        }
    }
}
```

## Domain Events

### Event Definitions
```csharp
namespace ErpBackEnd.Domain.Events;

public abstract class DomainEvent : INotification
{
    public DateTime OccurredOn { get; }
    public Guid EventId { get; }

    protected DomainEvent()
    {
        OccurredOn = DateTime.UtcNow;
        EventId = Guid.NewGuid();
    }
}

public class AccountCreatedEvent : DomainEvent
{
    public Account Account { get; }

    public AccountCreatedEvent(Account account)
    {
        Account = account;
    }
}

public class AccountUpdatedEvent : DomainEvent
{
    public Account Account { get; }
    public Dictionary<string, object?> Changes { get; }

    public AccountUpdatedEvent(Account account, Dictionary<string, object?> changes)
    {
        Account = account;
        Changes = changes;
    }
}

public class AccountDeletedEvent : DomainEvent
{
    public int AccountId { get; }
    public string AccountCode { get; }

    public AccountDeletedEvent(int accountId, string accountCode)
    {
        AccountId = accountId;
        AccountCode = accountCode;
    }
}
```

### Event Handlers
```csharp
namespace ErpBackEnd.Application.Features.Accounting.EventHandlers;

public class AccountCreatedEventHandler : INotificationHandler<AccountCreatedEvent>
{
    private readonly IAuditService _auditService;
    private readonly ICacheService _cacheService;
    private readonly ILogger<AccountCreatedEventHandler> _logger;

    public AccountCreatedEventHandler(
        IAuditService auditService,
        ICacheService cacheService,
        ILogger<AccountCreatedEventHandler> logger)
    {
        _auditService = auditService;
        _cacheService = cacheService;
        _logger = logger;
    }

    public async Task Handle(AccountCreatedEvent notification, CancellationToken cancellationToken)
    {
        // Log audit entry
        await _auditService.LogAsync(new AuditLog
        {
            EntityType = "Account",
            EntityId = notification.Account.Id.ToString(),
            Action = "Create",
            NewValues = JsonSerializer.Serialize(notification.Account),
            Timestamp = notification.OccurredOn,
            EventId = notification.EventId
        });

        // Invalidate cache
        await _cacheService.DeleteAsync("accounts:all");
        await _cacheService.DeleteAsync($"accounts:type:{notification.Account.AccountType}");

        _logger.LogInformation("Handled AccountCreatedEvent for account {AccountCode}", notification.Account.Code);
    }
}

public class AccountUpdatedEventHandler : INotificationHandler<AccountUpdatedEvent>
{
    private readonly IAuditService _auditService;
    private readonly ICacheService _cacheService;
    private readonly ILogger<AccountUpdatedEventHandler> _logger;

    public AccountUpdatedEventHandler(
        IAuditService auditService,
        ICacheService cacheService,
        ILogger<AccountUpdatedEventHandler> logger)
    {
        _auditService = auditService;
        _cacheService = cacheService;
        _logger = logger;
    }

    public async Task Handle(AccountUpdatedEvent notification, CancellationToken cancellationToken)
    {
        // Log audit entry with changes
        await _auditService.LogAsync(new AuditLog
        {
            EntityType = "Account",
            EntityId = notification.Account.Id.ToString(),
            Action = "Update",
            OldValues = JsonSerializer.Serialize(notification.Changes.Where(c => c.Key.StartsWith("Old_"))),
            NewValues = JsonSerializer.Serialize(notification.Changes.Where(c => c.Key.StartsWith("New_"))),
            Timestamp = notification.OccurredOn,
            EventId = notification.EventId
        });

        // Invalidate specific cache entries
        await _cacheService.DeleteAsync($"account:{notification.Account.Id}");
        await _cacheService.DeleteAsync("accounts:all");
        await _cacheService.DeleteAsync($"accounts:type:{notification.Account.AccountType}");

        _logger.LogInformation("Handled AccountUpdatedEvent for account {AccountCode}", notification.Account.Code);
    }
}
```

## Pipeline Behaviors

### Validation Behavior
```csharp
namespace ErpBackEnd.Application.Common.Behaviors;

public class ValidationBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IRequest<TResponse>
    where TResponse : class
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

        if (failures.Any())
        {
            _logger.LogWarning("Validation errors for {RequestType}: {Errors}", 
                typeof(TRequest).Name, 
                string.Join(", ", failures.Select(f => f.ErrorMessage)));

            // If TResponse is Result<T>, return validation failure
            if (typeof(TResponse).IsGenericType && 
                typeof(TResponse).GetGenericTypeDefinition() == typeof(Result<>))
            {
                var resultType = typeof(TResponse).GetGenericArguments()[0];
                var failureMethod = typeof(Result<>)
                    .MakeGenericType(resultType)
                    .GetMethod("Failure", new[] { typeof(Error) });
                
                var error = Error.Validation(failures);
                return (TResponse)failureMethod!.Invoke(null, new object[] { error })!;
            }

            throw new ValidationException(failures);
        }

        return await next();
    }
}
```

### Logging Behavior
```csharp
namespace ErpBackEnd.Application.Common.Behaviors;

public class LoggingBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IRequest<TResponse>
{
    private readonly ILogger<LoggingBehavior<TRequest, TResponse>> _logger;
    private readonly ICurrentUserProvider _currentUserProvider;

    public LoggingBehavior(
        ILogger<LoggingBehavior<TRequest, TResponse>> logger,
        ICurrentUserProvider currentUserProvider)
    {
        _logger = logger;
        _currentUserProvider = currentUserProvider;
    }

    public async Task<TResponse> Handle(
        TRequest request, 
        RequestHandlerDelegate<TResponse> next, 
        CancellationToken cancellationToken)
    {
        var requestName = typeof(TRequest).Name;
        var userId = _currentUserProvider.UserId;
        var username = _currentUserProvider.Username;

        _logger.LogInformation(
            "Handling {RequestName} for user {UserId} ({Username})",
            requestName, userId, username);

        var stopwatch = Stopwatch.StartNew();

        try
        {
            var response = await next();
            
            stopwatch.Stop();
            
            _logger.LogInformation(
                "Handled {RequestName} in {ElapsedMilliseconds}ms",
                requestName, stopwatch.ElapsedMilliseconds);

            return response;
        }
        catch (Exception ex)
        {
            stopwatch.Stop();
            
            _logger.LogError(ex,
                "Error handling {RequestName} after {ElapsedMilliseconds}ms",
                requestName, stopwatch.ElapsedMilliseconds);
            
            throw;
        }
    }
}
```

### Performance Behavior
```csharp
namespace ErpBackEnd.Application.Common.Behaviors;

public class PerformanceBehavior<TRequest, TResponse> : IPipelineBehavior<TRequest, TResponse>
    where TRequest : IRequest<TResponse>
{
    private readonly ILogger<PerformanceBehavior<TRequest, TResponse>> _logger;
    private readonly ICurrentUserProvider _currentUserProvider;
    private const int WarningThresholdMs = 500;

    public PerformanceBehavior(
        ILogger<PerformanceBehavior<TRequest, TResponse>> logger,
        ICurrentUserProvider currentUserProvider)
    {
        _logger = logger;
        _currentUserProvider = currentUserProvider;
    }

    public async Task<TResponse> Handle(
        TRequest request, 
        RequestHandlerDelegate<TResponse> next, 
        CancellationToken cancellationToken)
    {
        var stopwatch = Stopwatch.StartNew();
        
        var response = await next();
        
        stopwatch.Stop();

        if (stopwatch.ElapsedMilliseconds > WarningThresholdMs)
        {
            var requestName = typeof(TRequest).Name;
            var userId = _currentUserProvider.UserId;
            var username = _currentUserProvider.Username;

            _logger.LogWarning(
                "Long running request: {RequestName} ({ElapsedMilliseconds}ms) for user {UserId} ({Username})",
                requestName, stopwatch.ElapsedMilliseconds, userId, username);
        }

        return response;
    }
}
```

## Service Registration
```csharp
// In Program.cs or Startup.cs
public static class ServiceCollectionExtensions
{
    public static IServiceCollection AddApplication(this IServiceCollection services)
    {
        // Add MediatR
        services.AddMediatR(cfg =>
        {
            cfg.RegisterServicesFromAssembly(Assembly.GetExecutingAssembly());
            
            // Register behaviors in order
            cfg.AddBehavior(typeof(IPipelineBehavior<,>), typeof(LoggingBehavior<,>));
            cfg.AddBehavior(typeof(IPipelineBehavior<,>), typeof(ValidationBehavior<,>));
            cfg.AddBehavior(typeof(IPipelineBehavior<,>), typeof(PerformanceBehavior<,>));
        });

        // Add FluentValidation
        services.AddValidatorsFromAssembly(Assembly.GetExecutingAssembly());

        // Add AutoMapper
        services.AddAutoMapper(Assembly.GetExecutingAssembly());

        return services;
    }
}
```