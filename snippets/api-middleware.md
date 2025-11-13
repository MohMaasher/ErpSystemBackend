# API Middleware Components

## Global Error Handling Middleware
```csharp
using System.Text.Json;
using Microsoft.AspNetCore.Http;
using Microsoft.Extensions.Hosting;
using Microsoft.Extensions.Logging;

public class GlobalErrorHandlingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<GlobalErrorHandlingMiddleware> _logger;
    private readonly IWebHostEnvironment _environment;

    public GlobalErrorHandlingMiddleware(
        RequestDelegate next,
        ILogger<GlobalErrorHandlingMiddleware> logger,
        IWebHostEnvironment environment)
    {
        _next = next;
        _logger = logger;
        _environment = environment;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        try
        {
            await _next(context);
        }
        catch (Exception ex)
        {
            await HandleExceptionAsync(context, ex);
        }
    }

    private async Task HandleExceptionAsync(HttpContext context, Exception exception)
    {
        var requestId = context.TraceIdentifier;
        
        _logger.LogError(exception,
            "Unhandled exception occurred. RequestId: {RequestId}, Path: {Path}",
            requestId, context.Request.Path);

        context.Response.ContentType = "application/json";
        
        var response = new ApiErrorResponse
        {
            Success = false,
            Timestamp = DateTime.UtcNow,
            RequestId = requestId
        };

        switch (exception)
        {
            case ValidationException validationException:
                context.Response.StatusCode = StatusCodes.Status400BadRequest;
                response.Error = new ApiError
                {
                    Code = "VALIDATION_ERROR",
                    Message = "Validation failed",
                    Details = validationException.Errors.Select(e => new ErrorDetail
                    {
                        Field = e.PropertyName,
                        Message = e.ErrorMessage
                    }).ToList()
                };
                break;

            case NotFoundException notFoundException:
                context.Response.StatusCode = StatusCodes.Status404NotFound;
                response.Error = new ApiError
                {
                    Code = "NOT_FOUND",
                    Message = notFoundException.Message
                };
                break;

            case UnauthorizedException unauthorizedException:
                context.Response.StatusCode = StatusCodes.Status401Unauthorized;
                response.Error = new ApiError
                {
                    Code = "UNAUTHORIZED",
                    Message = "Unauthorized access"
                };
                break;

            case ForbiddenException forbiddenException:
                context.Response.StatusCode = StatusCodes.Status403Forbidden;
                response.Error = new ApiError
                {
                    Code = "FORBIDDEN",
                    Message = "Access denied"
                };
                break;

            case ConflictException conflictException:
                context.Response.StatusCode = StatusCodes.Status409Conflict;
                response.Error = new ApiError
                {
                    Code = "CONFLICT",
                    Message = conflictException.Message
                };
                break;

            case BusinessRuleException businessException:
                context.Response.StatusCode = StatusCodes.Status422UnprocessableEntity;
                response.Error = new ApiError
                {
                    Code = businessException.Code,
                    Message = businessException.Message
                };
                break;

            default:
                context.Response.StatusCode = StatusCodes.Status500InternalServerError;
                response.Error = new ApiError
                {
                    Code = "INTERNAL_ERROR",
                    Message = _environment.IsDevelopment() 
                        ? exception.Message 
                        : "An error occurred while processing your request"
                };
                
                if (_environment.IsDevelopment())
                {
                    response.Error.Details = new List<ErrorDetail>
                    {
                        new() { Field = "StackTrace", Message = exception.StackTrace }
                    };
                }
                break;
        }

        var jsonResponse = JsonSerializer.Serialize(response, new JsonSerializerOptions
        {
            PropertyNamingPolicy = JsonNamingPolicy.CamelCase
        });
        
        await context.Response.WriteAsync(jsonResponse);
    }
}
```

## Request Logging Middleware
```csharp
public class RequestLoggingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ILogger<RequestLoggingMiddleware> _logger;

    public RequestLoggingMiddleware(RequestDelegate next, ILogger<RequestLoggingMiddleware> logger)
    {
        _next = next;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        var requestId = context.TraceIdentifier;
        var startTime = DateTime.UtcNow;

        // Log request
        _logger.LogInformation(
            "Request starting {Method} {Path} {QueryString} - RequestId: {RequestId}",
            context.Request.Method,
            context.Request.Path,
            context.Request.QueryString,
            requestId);

        try
        {
            await _next(context);
        }
        finally
        {
            var elapsedMs = (DateTime.UtcNow - startTime).TotalMilliseconds;
            
            _logger.LogInformation(
                "Request finished {Method} {Path} - Status: {StatusCode} - Duration: {Duration}ms - RequestId: {RequestId}",
                context.Request.Method,
                context.Request.Path,
                context.Response.StatusCode,
                elapsedMs,
                requestId);

            // Add custom headers
            context.Response.Headers.Add("X-Request-ID", requestId);
            context.Response.Headers.Add("X-Response-Time", $"{elapsedMs}ms");
        }
    }
}
```

## Rate Limiting Middleware Configuration
```csharp
using Microsoft.AspNetCore.RateLimiting;
using System.Threading.RateLimiting;

public static class RateLimitingExtensions
{
    public static IServiceCollection AddCustomRateLimiting(this IServiceCollection services)
    {
        services.AddRateLimiter(options =>
        {
            options.RejectionStatusCode = StatusCodes.Status429TooManyRequests;
            
            // Global limiter
            options.GlobalLimiter = PartitionedRateLimiter.Create<HttpContext, string>(
                httpContext => RateLimitPartition.GetFixedWindowLimiter(
                    partitionKey: GetPartitionKey(httpContext),
                    factory: partition => new FixedWindowRateLimiterOptions
                    {
                        AutoReplenishment = true,
                        PermitLimit = 100,
                        QueueLimit = 10,
                        Window = TimeSpan.FromMinutes(1)
                    }));

            // Anonymous policy
            options.AddPolicy("anonymous", httpContext =>
                RateLimitPartition.GetFixedWindowLimiter(
                    partitionKey: GetClientIp(httpContext),
                    factory: partition => new FixedWindowRateLimiterOptions
                    {
                        AutoReplenishment = true,
                        PermitLimit = 20,
                        QueueLimit = 0,
                        Window = TimeSpan.FromMinutes(1)
                    }));

            // Authenticated policy
            options.AddPolicy("authenticated", httpContext =>
                RateLimitPartition.GetFixedWindowLimiter(
                    partitionKey: httpContext.User?.Identity?.Name ?? "anonymous",
                    factory: partition => new FixedWindowRateLimiterOptions
                    {
                        AutoReplenishment = true,
                        PermitLimit = 100,
                        QueueLimit = 10,
                        Window = TimeSpan.FromMinutes(1)
                    }));

            // Premium policy
            options.AddPolicy("premium", httpContext =>
                RateLimitPartition.GetFixedWindowLimiter(
                    partitionKey: httpContext.User?.Identity?.Name ?? "anonymous",
                    factory: partition => new FixedWindowRateLimiterOptions
                    {
                        AutoReplenishment = true,
                        PermitLimit = 500,
                        QueueLimit = 50,
                        Window = TimeSpan.FromMinutes(1)
                    }));

            // Admin policy (higher limits)
            options.AddPolicy("admin", httpContext =>
                RateLimitPartition.GetFixedWindowLimiter(
                    partitionKey: httpContext.User?.Identity?.Name ?? "anonymous",
                    factory: partition => new FixedWindowRateLimiterOptions
                    {
                        AutoReplenishment = true,
                        PermitLimit = 1000,
                        QueueLimit = 100,
                        Window = TimeSpan.FromMinutes(1)
                    }));

            options.OnRejected = async (context, ct) =>
            {
                context.HttpContext.Response.StatusCode = StatusCodes.Status429TooManyRequests;
                context.HttpContext.Response.ContentType = "application/json";

                var response = new ApiErrorResponse
                {
                    Success = false,
                    Error = new ApiError
                    {
                        Code = "RATE_LIMIT_EXCEEDED",
                        Message = "Too many requests. Please try again later."
                    },
                    Timestamp = DateTime.UtcNow,
                    RequestId = context.HttpContext.TraceIdentifier
                };

                await context.HttpContext.Response.WriteAsync(
                    JsonSerializer.Serialize(response),
                    cancellationToken: ct);
            };
        });

        return services;
    }

    private static string GetPartitionKey(HttpContext context)
    {
        return context.User?.Identity?.IsAuthenticated == true
            ? context.User.Identity.Name ?? GetClientIp(context)
            : GetClientIp(context);
    }

    private static string GetClientIp(HttpContext context)
    {
        return context.Connection.RemoteIpAddress?.ToString() ?? "unknown";
    }
}
```

## CORS Middleware Configuration
```csharp
public static class CorsExtensions
{
    public static IServiceCollection AddCustomCors(
        this IServiceCollection services,
        IConfiguration configuration)
    {
        services.AddCors(options =>
        {
            options.AddPolicy("DefaultPolicy", policy =>
            {
                var allowedOrigins = configuration
                    .GetSection("Cors:AllowedOrigins")
                    .Get<string[]>() ?? new[] { "http://localhost:3000" };

                policy.WithOrigins(allowedOrigins)
                      .AllowAnyMethod()
                      .AllowAnyHeader()
                      .AllowCredentials()
                      .SetPreflightMaxAge(TimeSpan.FromHours(1))
                      .WithExposedHeaders(
                          "X-Request-ID",
                          "X-Response-Time",
                          "X-Total-Count",
                          "X-Page-Number",
                          "X-Page-Size");
            });

            options.AddPolicy("PublicApi", policy =>
            {
                policy.AllowAnyOrigin()
                      .AllowAnyMethod()
                      .AllowAnyHeader()
                      .SetPreflightMaxAge(TimeSpan.FromHours(1));
            });
        });

        return services;
    }
}
```

## Security Headers Middleware
```csharp
public class SecurityHeadersMiddleware
{
    private readonly RequestDelegate _next;

    public SecurityHeadersMiddleware(RequestDelegate next)
    {
        _next = next;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        // Add security headers
        context.Response.Headers.Add("X-Content-Type-Options", "nosniff");
        context.Response.Headers.Add("X-Frame-Options", "DENY");
        context.Response.Headers.Add("X-XSS-Protection", "1; mode=block");
        context.Response.Headers.Add("Referrer-Policy", "strict-origin-when-cross-origin");
        context.Response.Headers.Add(
            "Content-Security-Policy",
            "default-src 'self'; script-src 'self' 'unsafe-inline'; style-src 'self' 'unsafe-inline';");
        context.Response.Headers.Add(
            "Strict-Transport-Security",
            "max-age=31536000; includeSubDomains");

        // Remove server header
        context.Response.Headers.Remove("Server");
        context.Response.Headers.Remove("X-Powered-By");

        await _next(context);
    }
}
```

## Request/Response Compression
```csharp
using Microsoft.AspNetCore.ResponseCompression;

public static class CompressionExtensions
{
    public static IServiceCollection AddCustomCompression(this IServiceCollection services)
    {
        services.Configure<GzipCompressionProviderOptions>(options =>
        {
            options.Level = System.IO.Compression.CompressionLevel.Optimal;
        });

        services.Configure<BrotliCompressionProviderOptions>(options =>
        {
            options.Level = System.IO.Compression.CompressionLevel.Optimal;
        });

        services.AddResponseCompression(options =>
        {
            options.EnableForHttps = true;
            options.Providers.Add<BrotliCompressionProvider>();
            options.Providers.Add<GzipCompressionProvider>();
            options.MimeTypes = ResponseCompressionDefaults.MimeTypes.Concat(new[]
            {
                "application/json",
                "application/xml",
                "text/xml",
                "text/json",
                "text/plain",
                "text/csv"
            });
        });

        return services;
    }
}
```

## API Versioning Middleware
```csharp
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.Versioning;

public static class ApiVersioningExtensions
{
    public static IServiceCollection AddCustomApiVersioning(this IServiceCollection services)
    {
        services.AddApiVersioning(options =>
        {
            options.DefaultApiVersion = new ApiVersion(1, 0);
            options.AssumeDefaultVersionWhenUnspecified = true;
            options.ReportApiVersions = true;
            options.ApiVersionReader = ApiVersionReader.Combine(
                new UrlSegmentApiVersionReader(),
                new HeaderApiVersionReader("x-api-version"),
                new MediaTypeApiVersionReader("x-api-version")
            );
        });

        services.AddVersionedApiExplorer(options =>
        {
            options.GroupNameFormat = "'v'VVV";
            options.SubstituteApiVersionInUrl = true;
        });

        return services;
    }
}
```

## Request/Response Caching Middleware
```csharp
public class CachingMiddleware
{
    private readonly RequestDelegate _next;
    private readonly IMemoryCache _cache;
    private readonly ILogger<CachingMiddleware> _logger;

    public CachingMiddleware(
        RequestDelegate next,
        IMemoryCache cache,
        ILogger<CachingMiddleware> logger)
    {
        _next = next;
        _cache = cache;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        // Only cache GET requests
        if (!HttpMethods.IsGet(context.Request.Method))
        {
            await _next(context);
            return;
        }

        var cacheKey = GenerateCacheKey(context.Request);

        // Try to get from cache
        if (_cache.TryGetValue<CachedResponse>(cacheKey, out var cachedResponse))
        {
            _logger.LogDebug("Cache hit for {CacheKey}", cacheKey);
            await WriteResponseFromCache(context, cachedResponse);
            return;
        }

        // Store original response body stream
        var originalBodyStream = context.Response.Body;

        using var responseBody = new MemoryStream();
        context.Response.Body = responseBody;

        await _next(context);

        // Only cache successful responses
        if (context.Response.StatusCode == 200)
        {
            context.Response.Body.Seek(0, SeekOrigin.Begin);
            var responseText = await new StreamReader(context.Response.Body).ReadToEndAsync();
            context.Response.Body.Seek(0, SeekOrigin.Begin);

            var cacheEntry = new CachedResponse
            {
                Content = responseText,
                ContentType = context.Response.ContentType,
                StatusCode = context.Response.StatusCode
            };

            var cacheOptions = new MemoryCacheEntryOptions
            {
                AbsoluteExpirationRelativeToNow = TimeSpan.FromMinutes(5),
                SlidingExpiration = TimeSpan.FromMinutes(2)
            };

            _cache.Set(cacheKey, cacheEntry, cacheOptions);
            _logger.LogDebug("Response cached for {CacheKey}", cacheKey);
        }

        // Copy response to original stream
        await responseBody.CopyToAsync(originalBodyStream);
    }

    private string GenerateCacheKey(HttpRequest request)
    {
        var keyBuilder = new StringBuilder();
        keyBuilder.Append($"{request.Path}");
        
        foreach (var (key, value) in request.Query.OrderBy(x => x.Key))
        {
            keyBuilder.Append($"|{key}:{value}");
        }

        return keyBuilder.ToString();
    }

    private async Task WriteResponseFromCache(HttpContext context, CachedResponse cachedResponse)
    {
        context.Response.ContentType = cachedResponse.ContentType;
        context.Response.StatusCode = cachedResponse.StatusCode;
        context.Response.Headers.Add("X-Cache", "HIT");
        await context.Response.WriteAsync(cachedResponse.Content);
    }

    private class CachedResponse
    {
        public string Content { get; set; }
        public string ContentType { get; set; }
        public int StatusCode { get; set; }
    }
}
```

## Tenant Resolution Middleware
```csharp
public class TenantResolutionMiddleware
{
    private readonly RequestDelegate _next;
    private readonly ITenantService _tenantService;
    private readonly ILogger<TenantResolutionMiddleware> _logger;

    public TenantResolutionMiddleware(
        RequestDelegate next,
        ITenantService tenantService,
        ILogger<TenantResolutionMiddleware> logger)
    {
        _next = next;
        _tenantService = tenantService;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        var tenantId = ResolveTenantId(context);
        
        if (tenantId == null && !IsPublicEndpoint(context))
        {
            context.Response.StatusCode = StatusCodes.Status400BadRequest;
            await context.Response.WriteAsync("Tenant identification required");
            return;
        }

        if (tenantId != null)
        {
            var tenant = await _tenantService.GetTenantAsync(tenantId.Value);
            
            if (tenant == null)
            {
                context.Response.StatusCode = StatusCodes.Status404NotFound;
                await context.Response.WriteAsync("Tenant not found");
                return;
            }

            context.Items["TenantId"] = tenant.Id;
            context.Items["Tenant"] = tenant;
            
            _logger.LogDebug("Tenant resolved: {TenantId}", tenant.Id);
        }

        await _next(context);
    }

    private int? ResolveTenantId(HttpContext context)
    {
        // Try to get from JWT claim
        if (context.User?.Identity?.IsAuthenticated == true)
        {
            var tenantClaim = context.User.FindFirst("tenant_id")?.Value;
            if (int.TryParse(tenantClaim, out var tenantId))
            {
                return tenantId;
            }
        }

        // Try to get from header
        if (context.Request.Headers.TryGetValue("X-Tenant-ID", out var headerValue))
        {
            if (int.TryParse(headerValue, out var tenantId))
            {
                return tenantId;
            }
        }

        // Try to get from subdomain
        var host = context.Request.Host.Host;
        var subdomain = host.Split('.').FirstOrDefault();
        if (!string.IsNullOrEmpty(subdomain) && subdomain != "www" && subdomain != "api")
        {
            return _tenantService.GetTenantIdBySubdomain(subdomain).Result;
        }

        return null;
    }

    private bool IsPublicEndpoint(HttpContext context)
    {
        var publicPaths = new[]
        {
            "/health",
            "/swagger",
            "/api/v1/auth/login",
            "/api/v1/auth/register"
        };

        return publicPaths.Any(path => 
            context.Request.Path.StartsWithSegments(path, StringComparison.OrdinalIgnoreCase));
    }
}
```

## Performance Monitoring Middleware
```csharp
public class PerformanceMonitoringMiddleware
{
    private readonly RequestDelegate _next;
    private readonly IMetrics _metrics;
    private readonly ILogger<PerformanceMonitoringMiddleware> _logger;

    public PerformanceMonitoringMiddleware(
        RequestDelegate next,
        IMetrics metrics,
        ILogger<PerformanceMonitoringMiddleware> logger)
    {
        _next = next;
        _metrics = metrics;
        _logger = logger;
    }

    public async Task InvokeAsync(HttpContext context)
    {
        var stopwatch = Stopwatch.StartNew();
        var path = context.Request.Path.Value;
        var method = context.Request.Method;

        try
        {
            await _next(context);
        }
        finally
        {
            stopwatch.Stop();
            
            // Record metrics
            _metrics.RecordResponseTime(path, method, stopwatch.ElapsedMilliseconds);
            _metrics.IncrementRequestCount(path, method, context.Response.StatusCode);

            // Log slow requests
            if (stopwatch.ElapsedMilliseconds > 1000)
            {
                _logger.LogWarning(
                    "Slow request detected: {Method} {Path} took {Duration}ms",
                    method, path, stopwatch.ElapsedMilliseconds);
            }

            // Add performance headers
            context.Response.Headers.Add("X-Processing-Time", $"{stopwatch.ElapsedMilliseconds}ms");
        }
    }
}
```

## Middleware Registration in Program.cs
```csharp
public class Program
{
    public static void Main(string[] args)
    {
        var builder = WebApplication.CreateBuilder(args);

        // Add services
        builder.Services.AddControllers();
        builder.Services.AddEndpointsApiExplorer();
        builder.Services.AddSwaggerGen();
        
        // Add custom services
        builder.Services.AddCustomCors(builder.Configuration);
        builder.Services.AddCustomRateLimiting();
        builder.Services.AddCustomCompression();
        builder.Services.AddCustomApiVersioning();
        
        // Add caching
        builder.Services.AddMemoryCache();
        builder.Services.AddResponseCaching();
        
        // Add health checks
        builder.Services.AddHealthChecks();
        
        var app = builder.Build();

        // Configure middleware pipeline (ORDER MATTERS!)
        
        // 1. Exception handling (should be first)
        app.UseMiddleware<GlobalErrorHandlingMiddleware>();
        
        // 2. HTTPS redirection
        if (!app.Environment.IsDevelopment())
        {
            app.UseHsts();
            app.UseHttpsRedirection();
        }
        
        // 3. Response compression
        app.UseResponseCompression();
        
        // 4. Security headers
        app.UseMiddleware<SecurityHeadersMiddleware>();
        
        // 5. Request logging
        app.UseMiddleware<RequestLoggingMiddleware>();
        
        // 6. Performance monitoring
        app.UseMiddleware<PerformanceMonitoringMiddleware>();
        
        // 7. CORS
        app.UseCors("DefaultPolicy");
        
        // 8. Rate limiting
        app.UseRateLimiter();
        
        // 9. Response caching
        app.UseResponseCaching();
        app.UseMiddleware<CachingMiddleware>();
        
        // 10. Authentication & Authorization
        app.UseAuthentication();
        app.UseAuthorization();
        
        // 11. Tenant resolution (after auth)
        app.UseMiddleware<TenantResolutionMiddleware>();
        
        // 12. API versioning
        app.UseApiVersioning();
        
        // 13. Swagger (development only)
        if (app.Environment.IsDevelopment())
        {
            app.UseSwagger();
            app.UseSwaggerUI();
        }
        
        // 14. Endpoints
        app.MapControllers();
        app.MapHealthChecks("/health");
        
        app.Run();
    }
}
```

## Custom Exception Types
```csharp
public class NotFoundException : Exception
{
    public NotFoundException(string message) : base(message) { }
    public NotFoundException(string message, Exception innerException) 
        : base(message, innerException) { }
}

public class UnauthorizedException : Exception
{
    public UnauthorizedException(string message = "Unauthorized access") 
        : base(message) { }
}

public class ForbiddenException : Exception
{
    public ForbiddenException(string message = "Access denied") 
        : base(message) { }
}

public class ConflictException : Exception
{
    public ConflictException(string message) : base(message) { }
}

public class BusinessRuleException : Exception
{
    public string Code { get; }
    
    public BusinessRuleException(string code, string message) : base(message)
    {
        Code = code;
    }
}

public class ValidationException : Exception
{
    public List<ValidationError> Errors { get; }
    
    public ValidationException(List<ValidationError> errors) 
        : base("Validation failed")
    {
        Errors = errors;
    }
}

public class ValidationError
{
    public string PropertyName { get; set; }
    public string ErrorMessage { get; set; }
}
```