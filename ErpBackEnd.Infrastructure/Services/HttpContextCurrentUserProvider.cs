using System.Security.Claims;
using ErpBackEnd.Domain.Interfaces;
using Microsoft.AspNetCore.Http;

namespace ErpBackEnd.Infrastructure.Services;

public class HttpContextCurrentUserProvider : ICurrentUserProvider
{
    private readonly IHttpContextAccessor _httpContextAccessor;

    public HttpContextCurrentUserProvider(IHttpContextAccessor httpContextAccessor)
    {
        _httpContextAccessor = httpContextAccessor;
    }

    private ClaimsPrincipal? User => _httpContextAccessor.HttpContext?.User;

    public int UserId
    {
        get
        {
            var userIdClaim = User?.FindFirst(ClaimTypes.NameIdentifier)?.Value
                           ?? User?.FindFirst("sub")?.Value;

            return int.TryParse(userIdClaim, out var userId) ? userId : 0;
        }
    }

    public string Username => User?.Identity?.Name ?? "System";

    public string? TenantId => User?.FindFirst("tid")?.Value;

    public string? IpAddress => _httpContextAccessor.HttpContext?.Connection?.RemoteIpAddress?.ToString();

    public IEnumerable<string> Permissions => User?.FindAll("permission").Select(c => c.Value) ?? Enumerable.Empty<string>();

    public IEnumerable<string> Roles => User?.FindAll(ClaimTypes.Role).Select(c => c.Value) ?? Enumerable.Empty<string>();
}
