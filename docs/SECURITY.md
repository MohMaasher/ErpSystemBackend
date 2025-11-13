# Security Documentation

## JWT Authentication

### Configuration
```json
{
  "JwtSettings": {
    "SecretKey": "{{AZURE_KEY_VAULT}}",
    "Issuer": "https://api.erp.com",
    "Audience": "https://api.erp.com",
    "TokenExpiration": 60,
    "RefreshTokenDays": 7
  }
}
```

### Setup (Program.cs)
```csharp
builder.Services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
    .AddJwtBearer(options => {
        options.TokenValidationParameters = new TokenValidationParameters {
            ValidateIssuerSigningKey = true,
            IssuerSigningKey = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(config["JwtSettings:SecretKey"])),
            ValidateIssuer = true,
            ValidIssuer = config["JwtSettings:Issuer"],
            ValidateAudience = true,
            ValidAudience = config["JwtSettings:Audience"]
        };
    });
```

## Authorization (RBAC)

### Database Tables
```sql
-- Users -> UserRoles -> Roles -> RolePermissions -> Permissions
CREATE TABLE Users (
    UserId INT PRIMARY KEY IDENTITY,
    Username VARCHAR(50) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    PasswordHash VARCHAR(500),
    IsActive BIT DEFAULT 1
);

CREATE TABLE Roles (
    RoleId INT PRIMARY KEY IDENTITY,
    RoleName VARCHAR(50) UNIQUE
);

CREATE TABLE Permissions (
    PermissionId INT PRIMARY KEY IDENTITY,
    PermissionName VARCHAR(100) UNIQUE,
    Module VARCHAR(50)
);
```

### Authorization Policies
```csharp
builder.Services.AddAuthorization(options => {
    options.AddPolicy("Accounting.View", p => p.RequireClaim("permission", "Accounting.View"));
    options.AddPolicy("Admin", p => p.RequireRole("Administrator"));
});
```

### Controller Usage
```csharp
[ApiController]
[Authorize]
public class AccountingController : ControllerBase
{
    [HttpGet]
    [Authorize(Policy = "Accounting.View")]
    public async Task<IActionResult> GetData() { }
}
```

## Password Security

### Hashing Service
```csharp
public interface IPasswordService
{
    string HashPassword(string password);
    bool VerifyPassword(string password, string hash);
}

// Use BCrypt or Argon2
public class PasswordService : IPasswordService
{
    private readonly PasswordHasher<object> _hasher = new();
    
    public string HashPassword(string password) 
        => _hasher.HashPassword(null, password);
    
    public bool VerifyPassword(string password, string hash)
        => _hasher.VerifyHashedPassword(null, hash, password) == PasswordVerificationResult.Success;
}
```

### Password Validation
```csharp
// Minimum 8 chars, 1 upper, 1 lower, 1 digit
RuleFor(x => x.Password)
    .MinimumLength(8)
    .Matches(@"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$");
```

## Data Encryption

### AES Encryption Service
```csharp
public interface IEncryptionService
{
    string Encrypt(string text);
    string Decrypt(string cipherText);
}

// Store keys in Azure Key Vault
// Use for sensitive fields only (NationalId, BankAccount, etc.)
```

## API Security

### Security Headers
```csharp
app.Use(async (context, next) => {
    context.Response.Headers.Add("X-Content-Type-Options", "nosniff");
    context.Response.Headers.Add("X-Frame-Options", "DENY");
    context.Response.Headers.Add("X-XSS-Protection", "1; mode=block");
    context.Response.Headers.Remove("Server");
    await next();
});
```

### CORS
```csharp
builder.Services.AddCors(options => {
    options.AddDefaultPolicy(policy => {
        policy.WithOrigins("https://app.erp.com")
              .AllowAnyHeader()
              .AllowAnyMethod()
              .AllowCredentials();
    });
});
```

### Rate Limiting
```csharp
builder.Services.AddRateLimiter(options => {
    options.GlobalLimiter = PartitionedRateLimiter.Create<HttpContext, string>(
        context => RateLimitPartition.GetFixedWindowLimiter(
            context.User?.Identity?.Name ?? context.Connection.RemoteIpAddress?.ToString(),
            _ => new FixedWindowRateLimiterOptions {
                PermitLimit = 100,
                Window = TimeSpan.FromMinutes(1)
            }));
});
```

## SQL Injection Prevention

```csharp
// ✅ SAFE - Always use parameters
var sql = "SELECT * FROM Users WHERE Id = @Id";
await connection.QueryAsync<User>(sql, new { Id = userId });

// ❌ NEVER - String concatenation
var sql = $"SELECT * FROM Users WHERE Id = {userId}"; // SQL Injection!
```

## Audit Logging

```sql
CREATE TABLE AuditLogs (
    LogId INT IDENTITY PRIMARY KEY,
    UserId VARCHAR(50),
    Action VARCHAR(100),
    EntityType VARCHAR(50),
    EntityId VARCHAR(50),
    Timestamp DATETIME2,
    IPAddress VARCHAR(45)
);
```

```csharp
public interface IAuditService
{
    Task LogAsync(string action, string entityType, string entityId);
}
```

## Security Checklist

### Essential Security
- [x] JWT authentication with secure keys
- [x] Password hashing (BCrypt/Argon2)
- [x] HTTPS only in production
- [x] Parameterized queries (no SQL injection)
- [x] Input validation on all endpoints
- [x] CORS configured properly

### API Protection
- [x] Rate limiting enabled
- [x] Security headers configured
- [x] File upload validation (type & size)
- [x] Error messages don't expose sensitive info

### Data Security
- [x] Sensitive data encrypted (PII)
- [x] Connection strings in environment variables
- [x] Secrets in Azure Key Vault
- [x] Database backups configured

### Monitoring
- [x] Failed login attempts logged
- [x] Audit trail for critical operations
- [x] Security alerts configured
- [x] Regular dependency updates

## Quick Reference

| Component | Library/Tool | Purpose |
|-----------|-------------|---------|
| Authentication | JWT Bearer | Token-based auth |
| Password Hash | BCrypt/Argon2 | Secure password storage |
| Encryption | AES-256 | Sensitive data protection |
| SQL | Dapper/EF Core | Parameterized queries |
| Secrets | Azure Key Vault | Secure key storage |
| Monitoring | Application Insights | Logging & alerts |

## Common Mistakes to Avoid

1. **Never** store passwords in plain text
2. **Never** use string concatenation for SQL
3. **Never** expose sensitive data in logs
4. **Never** hardcode secrets in code
5. **Never** trust user input without validation
6. **Never** use HTTP in production