# API Controllers Implementation

## Base Controller
```csharp
using MediatR;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;

[ApiController]
[Authorize]
[Produces("application/json")]
[ProducesResponseType(typeof(ApiErrorResponse), 400)]
[ProducesResponseType(typeof(ApiErrorResponse), 401)]
[ProducesResponseType(typeof(ApiErrorResponse), 500)]
public abstract class BaseApiController : ControllerBase
{
    protected readonly IMediator _mediator;
    protected readonly ILogger _logger;
    protected readonly ICurrentUserService _currentUser;

    protected BaseApiController(
        IMediator mediator,
        ILogger logger,
        ICurrentUserService currentUser)
    {
        _mediator = mediator;
        _logger = logger;
        _currentUser = currentUser;
    }

    protected IActionResult CreateResponse<T>(Result<T> result)
    {
        if (result.IsSuccess)
        {
            return Ok(new ApiResponse<T>
            {
                Success = true,
                Data = result.Value,
                Message = result.Message,
                Timestamp = DateTime.UtcNow,
                RequestId = HttpContext.TraceIdentifier
            });
        }

        return result.Error.Type switch
        {
            ErrorType.NotFound => NotFound(CreateErrorResponse(result.Error)),
            ErrorType.Validation => BadRequest(CreateErrorResponse(result.Error)),
            ErrorType.Conflict => Conflict(CreateErrorResponse(result.Error)),
            ErrorType.Unauthorized => Unauthorized(CreateErrorResponse(result.Error)),
            ErrorType.BusinessRule => UnprocessableEntity(CreateErrorResponse(result.Error)),
            _ => StatusCode(500, CreateErrorResponse(result.Error))
        };
    }

    protected ApiErrorResponse CreateErrorResponse(Error error)
    {
        return new ApiErrorResponse
        {
            Success = false,
            Error = new ApiError
            {
                Code = error.Code,
                Message = error.Message,
                Details = error.Details
            },
            Timestamp = DateTime.UtcNow,
            RequestId = HttpContext.TraceIdentifier
        };
    }

    protected Guid GetUserId() => _currentUser.UserId;
    protected string GetUserName() => _currentUser.UserName;
    protected int GetTenantId() => _currentUser.TenantId;
}
```

## Customer Controller
```csharp
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/customers")]
public class CustomersController : BaseApiController
{
    public CustomersController(
        IMediator mediator,
        ILogger<CustomersController> logger,
        ICurrentUserService currentUser)
        : base(mediator, logger, currentUser)
    {
    }

    /// <summary>
    /// Get all customers with pagination
    /// </summary>
    [HttpGet]
    [ProducesResponseType(typeof(ApiResponse<PagedResult<CustomerDto>>), 200)]
    public async Task<IActionResult> GetCustomers([FromQuery] GetCustomersQuery query)
    {
        query.TenantId = GetTenantId();
        var result = await _mediator.Send(query);
        return CreateResponse(result);
    }

    /// <summary>
    /// Get customer by ID
    /// </summary>
    [HttpGet("{id:guid}")]
    [ProducesResponseType(typeof(ApiResponse<CustomerDto>), 200)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> GetCustomer(Guid id)
    {
        var query = new GetCustomerByIdQuery 
        { 
            CustomerId = id,
            TenantId = GetTenantId()
        };
        var result = await _mediator.Send(query);
        return CreateResponse(result);
    }

    /// <summary>
    /// Create new customer
    /// </summary>
    [HttpPost]
    [ProducesResponseType(typeof(ApiResponse<CustomerDto>), 201)]
    [ProducesResponseType(400)]
    [ProducesResponseType(409)]
    public async Task<IActionResult> CreateCustomer([FromBody] CreateCustomerRequest request)
    {
        var command = request.ToCommand();
        command.CreatedBy = GetUserId();
        command.TenantId = GetTenantId();
        
        var result = await _mediator.Send(command);
        
        if (result.IsSuccess)
        {
            return CreatedAtAction(
                nameof(GetCustomer),
                new { id = result.Value.Id, version = "1.0" },
                new ApiResponse<CustomerDto>
                {
                    Success = true,
                    Data = result.Value,
                    Message = "Customer created successfully",
                    Timestamp = DateTime.UtcNow,
                    RequestId = HttpContext.TraceIdentifier
                });
        }

        return CreateResponse(result);
    }

    /// <summary>
    /// Update customer
    /// </summary>
    [HttpPut("{id:guid}")]
    [ProducesResponseType(typeof(ApiResponse<CustomerDto>), 200)]
    [ProducesResponseType(400)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> UpdateCustomer(Guid id, [FromBody] UpdateCustomerRequest request)
    {
        var command = request.ToCommand(id);
        command.ModifiedBy = GetUserId();
        command.TenantId = GetTenantId();
        
        var result = await _mediator.Send(command);
        return CreateResponse(result);
    }

    /// <summary>
    /// Delete customer
    /// </summary>
    [HttpDelete("{id:guid}")]
    [ProducesResponseType(204)]
    [ProducesResponseType(404)]
    [ProducesResponseType(409)]
    public async Task<IActionResult> DeleteCustomer(Guid id)
    {
        var command = new DeleteCustomerCommand
        {
            CustomerId = id,
            DeletedBy = GetUserId(),
            TenantId = GetTenantId()
        };
        
        var result = await _mediator.Send(command);
        
        if (result.IsSuccess)
        {
            return NoContent();
        }

        return CreateResponse(result);
    }

    /// <summary>
    /// Search customers
    /// </summary>
    [HttpPost("search")]
    [ProducesResponseType(typeof(ApiResponse<PagedResult<CustomerDto>>), 200)]
    public async Task<IActionResult> SearchCustomers([FromBody] SearchCustomersRequest request)
    {
        var query = request.ToQuery();
        query.TenantId = GetTenantId();
        
        var result = await _mediator.Send(query);
        return CreateResponse(result);
    }

    /// <summary>
    /// Export customers to Excel
    /// </summary>
    [HttpGet("export")]
    [ProducesResponseType(typeof(FileContentResult), 200)]
    public async Task<IActionResult> ExportCustomers([FromQuery] ExportCustomersQuery query)
    {
        query.TenantId = GetTenantId();
        var result = await _mediator.Send(query);
        
        if (result.IsSuccess)
        {
            return File(
                result.Value.Content,
                "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
                result.Value.FileName);
        }

        return CreateResponse(result);
    }

    /// <summary>
    /// Import customers from Excel
    /// </summary>
    [HttpPost("import")]
    [ProducesResponseType(typeof(ApiResponse<ImportResult>), 200)]
    [ProducesResponseType(400)]
    public async Task<IActionResult> ImportCustomers(IFormFile file)
    {
        if (file == null || file.Length == 0)
        {
            return BadRequest(CreateErrorResponse(new Error(
                "FILE_REQUIRED",
                "Please upload a file")));
        }

        var command = new ImportCustomersCommand
        {
            File = file,
            ImportedBy = GetUserId(),
            TenantId = GetTenantId()
        };

        var result = await _mediator.Send(command);
        return CreateResponse(result);
    }

    /// <summary>
    /// Get customer balance
    /// </summary>
    [HttpGet("{id:guid}/balance")]
    [ProducesResponseType(typeof(ApiResponse<CustomerBalanceDto>), 200)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> GetCustomerBalance(Guid id)
    {
        var query = new GetCustomerBalanceQuery
        {
            CustomerId = id,
            TenantId = GetTenantId()
        };
        
        var result = await _mediator.Send(query);
        return CreateResponse(result);
    }

    /// <summary>
    /// Get customer statement
    /// </summary>
    [HttpGet("{id:guid}/statement")]
    [ProducesResponseType(typeof(ApiResponse<CustomerStatementDto>), 200)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> GetCustomerStatement(
        Guid id,
        [FromQuery] DateTime fromDate,
        [FromQuery] DateTime toDate)
    {
        var query = new GetCustomerStatementQuery
        {
            CustomerId = id,
            FromDate = fromDate,
            ToDate = toDate,
            TenantId = GetTenantId()
        };
        
        var result = await _mediator.Send(query);
        return CreateResponse(result);
    }

    /// <summary>
    /// Activate customer
    /// </summary>
    [HttpPost("{id:guid}/activate")]
    [ProducesResponseType(typeof(ApiResponse<bool>), 200)]
    [ProducesResponseType(404)]
    public async Task<IActionResult> ActivateCustomer(Guid id)
    {
        var command = new ActivateCustomerCommand
        {
            CustomerId = id,
            ActivatedBy = GetUserId(),
            TenantId = GetTenantId()
        };
        
        var result = await _mediator.Send(command);
        return CreateResponse(result);
    }

    /// <summary>
    /// Deactivate customer
    /// </summary>
    [HttpPost("{id:guid}/deactivate")]
    [ProducesResponseType(typeof(ApiResponse<bool>), 200)]
    [ProducesResponseType(404)]
    [ProducesResponseType(409)]
    public async Task<IActionResult> DeactivateCustomer(Guid id, [FromBody] DeactivateRequest request)
    {
        var command = new DeactivateCustomerCommand
        {
            CustomerId = id,
            Reason = request.Reason,
            DeactivatedBy = GetUserId(),
            TenantId = GetTenantId()
        };
        
        var result = await _mediator.Send(command);
        return CreateResponse(result);
    }
}
```

## Accounting Controller
```csharp
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/accounts")]
public class AccountsController : BaseApiController
{
    public AccountsController(
        IMediator mediator,
        ILogger<AccountsController> logger,
        ICurrentUserService currentUser)
        : base(mediator, logger, currentUser)
    {
    }

    [HttpGet]
    public async Task<IActionResult> GetAccounts([FromQuery] GetAccountsQuery query)
    {
        query.TenantId = GetTenantId();
        var result = await _mediator.Send(query);
        return CreateResponse(result);
    }

    [HttpGet("tree")]
    public async Task<IActionResult> GetAccountTree()
    {
        var query = new GetAccountTreeQuery { TenantId = GetTenantId() };
        var result = await _mediator.Send(query);
        return CreateResponse(result);
    }

    [HttpPost("search")]
    public async Task<IActionResult> SearchAccounts([FromBody] SearchAccountsRequest request)
    {
        var query = request.ToQuery();
        query.TenantId = GetTenantId();
        var result = await _mediator.Send(query);
        return CreateResponse(result);
    }
}
```

## Sales Order Controller
```csharp
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/sales-orders")]
public class SalesOrdersController : BaseApiController
{
    public SalesOrdersController(
        IMediator mediator,
        ILogger<SalesOrdersController> logger,
        ICurrentUserService currentUser)
        : base(mediator, logger, currentUser)
    {
    }

    [HttpGet]
    public async Task<IActionResult> GetOrders([FromQuery] GetSalesOrdersQuery query)
    {
        query.TenantId = GetTenantId();
        var result = await _mediator.Send(query);
        return CreateResponse(result);
    }

    [HttpGet("{id:guid}")]
    public async Task<IActionResult> GetOrder(Guid id)
    {
        var query = new GetSalesOrderByIdQuery 
        { 
            OrderId = id,
            TenantId = GetTenantId()
        };
        var result = await _mediator.Send(query);
        return CreateResponse(result);
    }

    [HttpPost]
    public async Task<IActionResult> CreateOrder([FromBody] CreateSalesOrderRequest request)
    {
        var command = request.ToCommand();
        command.CreatedBy = GetUserId();
        command.TenantId = GetTenantId();
        
        var result = await _mediator.Send(command);
        
        if (result.IsSuccess)
        {
            return CreatedAtAction(
                nameof(GetOrder),
                new { id = result.Value.Id, version = "1.0" },
                new ApiResponse<SalesOrderDto>
                {
                    Success = true,
                    Data = result.Value,
                    Message = "Sales order created successfully",
                    Timestamp = DateTime.UtcNow,
                    RequestId = HttpContext.TraceIdentifier
                });
        }

        return CreateResponse(result);
    }

    [HttpPost("{id:guid}/confirm")]
    public async Task<IActionResult> ConfirmOrder(Guid id)
    {
        var command = new ConfirmSalesOrderCommand
        {
            OrderId = id,
            ConfirmedBy = GetUserId(),
            TenantId = GetTenantId()
        };
        
        var result = await _mediator.Send(command);
        return CreateResponse(result);
    }

    [HttpPost("{id:guid}/invoice")]
    public async Task<IActionResult> GenerateInvoice(Guid id)
    {
        var command = new GenerateInvoiceCommand
        {
            OrderId = id,
            GeneratedBy = GetUserId(),
            TenantId = GetTenantId()
        };
        
        var result = await _mediator.Send(command);
        return CreateResponse(result);
    }

    [HttpPost("{id:guid}/cancel")]
    public async Task<IActionResult> CancelOrder(Guid id, [FromBody] CancelOrderRequest request)
    {
        var command = new CancelSalesOrderCommand
        {
            OrderId = id,
            Reason = request.Reason,
            CancelledBy = GetUserId(),
            TenantId = GetTenantId()
        };
        
        var result = await _mediator.Send(command);
        return CreateResponse(result);
    }
}
```

## Authentication Controller
```csharp
[ApiController]
[ApiVersion("1.0")]
[Route("api/v{version:apiVersion}/auth")]
public class AuthController : ControllerBase
{
    private readonly IAuthService _authService;
    private readonly ILogger<AuthController> _logger;

    public AuthController(IAuthService authService, ILogger<AuthController> logger)
    {
        _authService = authService;
        _logger = logger;
    }

    [HttpPost("login")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(ApiResponse<TokenResponse>), 200)]
    [ProducesResponseType(typeof(ApiErrorResponse), 401)]
    public async Task<IActionResult> Login([FromBody] LoginRequest request)
    {
        var result = await _authService.LoginAsync(request);
        
        if (result.IsSuccess)
        {
            return Ok(new ApiResponse<TokenResponse>
            {
                Success = true,
                Data = result.Value,
                Message = "Login successful",
                Timestamp = DateTime.UtcNow,
                RequestId = HttpContext.TraceIdentifier
            });
        }

        return Unauthorized(new ApiErrorResponse
        {
            Success = false,
            Error = new ApiError
            {
                Code = "AUTH_001",
                Message = "Invalid credentials"
            },
            Timestamp = DateTime.UtcNow,
            RequestId = HttpContext.TraceIdentifier
        });
    }

    [HttpPost("refresh")]
    [AllowAnonymous]
    [ProducesResponseType(typeof(ApiResponse<TokenResponse>), 200)]
    [ProducesResponseType(typeof(ApiErrorResponse), 401)]
    public async Task<IActionResult> Refresh([FromBody] RefreshTokenRequest request)
    {
        var result = await _authService.RefreshTokenAsync(request.RefreshToken);
        
        if (result.IsSuccess)
        {
            return Ok(new ApiResponse<TokenResponse>
            {
                Success = true,
                Data = result.Value,
                Message = "Token refreshed successfully",
                Timestamp = DateTime.UtcNow,
                RequestId = HttpContext.TraceIdentifier
            });
        }

        return Unauthorized(new ApiErrorResponse
        {
            Success = false,
            Error = new ApiError
            {
                Code = "AUTH_002",
                Message = "Invalid or expired refresh token"
            },
            Timestamp = DateTime.UtcNow,
            RequestId = HttpContext.TraceIdentifier
        });
    }

    [HttpPost("logout")]
    [Authorize]
    public async Task<IActionResult> Logout()
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        await _authService.LogoutAsync(userId);
        
        return Ok(new ApiResponse<bool>
        {
            Success = true,
            Data = true,
            Message = "Logout successful",
            Timestamp = DateTime.UtcNow,
            RequestId = HttpContext.TraceIdentifier
        });
    }

    [HttpGet("profile")]
    [Authorize]
    [ProducesResponseType(typeof(ApiResponse<UserProfileDto>), 200)]
    public async Task<IActionResult> GetProfile()
    {
        var userId = User.FindFirst(ClaimTypes.NameIdentifier)?.Value;
        var result = await _authService.GetUserProfileAsync(userId);
        
        if (result.IsSuccess)
        {
            return Ok(new ApiResponse<UserProfileDto>
            {
                Success = true,
                Data = result.Value,
                Timestamp = DateTime.UtcNow,
                RequestId = HttpContext.TraceIdentifier
            });
        }

        return NotFound(new ApiErrorResponse
        {
            Success = false,
            Error = new ApiError
            {
                Code = "NOT_FOUND",
                Message = "User profile not found"
            },
            Timestamp = DateTime.UtcNow,
            RequestId = HttpContext.TraceIdentifier
        });
    }
}
```

## Health Check Controller
```csharp
[ApiController]
[Route("")]
public class HealthController : ControllerBase
{
    private readonly HealthCheckService _healthCheckService;

    public HealthController(HealthCheckService healthCheckService)
    {
        _healthCheckService = healthCheckService;
    }

    [HttpGet("health")]
    [AllowAnonymous]
    public async Task<IActionResult> Health()
    {
        var report = await _healthCheckService.CheckHealthAsync();
        
        return report.Status == HealthStatus.Healthy
            ? Ok(report)
            : StatusCode(503, report);
    }

    [HttpGet("health/ready")]
    [AllowAnonymous]
    public async Task<IActionResult> Ready()
    {
        var report = await _healthCheckService.CheckHealthAsync(
            predicate: check => check.Tags.Contains("ready"));
        
        return report.Status == HealthStatus.Healthy
            ? Ok(report)
            : StatusCode(503, report);
    }

    [HttpGet("health/live")]
    [AllowAnonymous]
    public IActionResult Live()
    {
        return Ok(new { status = "Healthy", timestamp = DateTime.UtcNow });
    }
}
```