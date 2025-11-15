using ErpBackEnd.Domain.Interfaces;

namespace ErpBackEnd.Infrastructure.Services;

/// <summary>
/// System user provider for background jobs and system operations
/// </summary>
public class SystemUserProvider : ICurrentUserProvider
{
    public int UserId { get; set; } = 0; // System user
    public string Username { get; set; } = "System";
    public string? TenantId { get; set; }
    public string? IpAddress => "::1"; // Localhost
    public IEnumerable<string> Permissions { get; set; } = new[] { "*" }; // All permissions for system
    public IEnumerable<string> Roles { get; set; } = new[] { "System" };
}

/// <summary>
/// Background job user provider for scheduled tasks
/// </summary>
public class BackgroundJobUserProvider : ICurrentUserProvider
{
    private readonly int _userId;
    private readonly string _username;
    private readonly string? _tenantId;

    public BackgroundJobUserProvider(int userId, string username, string? tenantId = null)
    {
        _userId = userId;
        _username = username;
        _tenantId = tenantId;
    }

    public int UserId => _userId;
    public string Username => _username;
    public string? TenantId => _tenantId;
    public string? IpAddress => "BackgroundJob";
    public IEnumerable<string> Permissions => Enumerable.Empty<string>();
    public IEnumerable<string> Roles => new[] { "BackgroundJob" };
}
