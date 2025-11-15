namespace ErpBackEnd.Domain.Interfaces;

/// <summary>
/// Provides current user context without depending on HTTP context
/// As per CLAUDE.md - ICurrentUserProvider for user context (decoupled from HTTP)
/// </summary>
public interface ICurrentUserProvider
{
    /// <summary>
    /// Get current user ID
    /// </summary>
    int UserId { get; }

    /// <summary>
    /// Get current username
    /// </summary>
    string Username { get; }

    /// <summary>
    /// Get tenant/company ID for multi-tenancy support
    /// </summary>
    string? TenantId { get; }

    /// <summary>
    /// Get user's IP address
    /// </summary>
    string? IpAddress { get; }

    /// <summary>
    /// Get current user's permissions
    /// </summary>
    IEnumerable<string> Permissions { get; }

    /// <summary>
    /// Get current user's roles
    /// </summary>
    IEnumerable<string> Roles { get; }
}
