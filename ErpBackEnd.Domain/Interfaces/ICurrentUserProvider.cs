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
    string? UserId { get; }

    /// <summary>
    /// Get current username
    /// </summary>
    string? Username { get; }

    /// <summary>
    /// Get current user email
    /// </summary>
    string? Email { get; }

    /// <summary>
    /// Get current user's branch code
    /// </summary>
    string? BranchCode { get; }

    /// <summary>
    /// Get current user's company code
    /// </summary>
    string? CompanyCode { get; }

    /// <summary>
    /// Get current user's roles
    /// </summary>
    IEnumerable<string> Roles { get; }

    /// <summary>
    /// Get current user's permissions
    /// </summary>
    IEnumerable<string> Permissions { get; }

    /// <summary>
    /// Check if user has a specific permission
    /// </summary>
    bool HasPermission(string permission);

    /// <summary>
    /// Check if user has a specific role
    /// </summary>
    bool HasRole(string role);

    /// <summary>
    /// Get user's IP address
    /// </summary>
    string? IPAddress { get; }

    /// <summary>
    /// Get user's browser/client information
    /// </summary>
    string? UserAgent { get; }

    /// <summary>
    /// Check if user is authenticated
    /// </summary>
    bool IsAuthenticated { get; }
}
