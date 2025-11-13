# Infrastructure Documentation

## Overview
This document describes the infrastructure setup, configuration, and best practices for the ERP system.

## Architecture Diagram
```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│                 │     │                 │     │                 │
│   Azure CDN     │────▶│  Load Balancer  │────▶│   API Gateway   │
│                 │     │   (Azure LB)    │     │  (Azure APIM)   │
└─────────────────┘     └─────────────────┘     └─────────────────┘
                                                          │
                                ┌─────────────────────────┴─────────────────────────┐
                                │                                                   │
                        ┌───────▼──────┐                                   ┌────────▼──────┐
                        │              │                                   │               │
                        │  AKS Cluster │                                   │  AKS Cluster  │
                        │   (Primary)  │                                   │  (Secondary)  │
                        │              │                                   │               │
                        └───────┬──────┘                                   └───────────────┘
                                │
                ┌───────────────┼───────────────┬───────────────┬────────────────┐
                │               │               │               │                │
        ┌───────▼──────┐ ┌─────▼──────┐ ┌─────▼──────┐ ┌─────▼──────┐  ┌───────▼──────┐
        │              │ │            │ │            │ │            │  │              │
        │  SQL Server  │ │   Redis    │ │ Azure Blob │ │  Key Vault │  │  App Config  │
        │   (Primary)  │ │  (Cache)   │ │  Storage   │ │            │  │              │
        │              │ │            │ │            │ │            │  │              │
        └──────────────┘ └────────────┘ └────────────┘ └────────────┘  └──────────────┘
```

## Environment Setup

### Development Environment
```json
{
  "Environment": "Development",
  "ConnectionStrings": {
    "DefaultConnection": "Server=localhost;Database=ErpDev;User Id=sa;Password=YourStrong@Password;TrustServerCertificate=true;",
    "Redis": "localhost:6379"
  },
  "Services": {
    "BlobStorage": "UseDevelopmentStorage=true",
    "KeyVault": null,
    "AppInsights": null
  }
}
```

### Staging Environment
```json
{
  "Environment": "Staging",
  "ConnectionStrings": {
    "DefaultConnection": "Server=erp-staging.database.windows.net;Database=ErpStaging;",
    "Redis": "erp-staging.redis.cache.windows.net:6380,ssl=true,password=..."
  },
  "Services": {
    "BlobStorage": "DefaultEndpointsProtocol=https;AccountName=erpstaging;",
    "KeyVault": "https://erp-staging-kv.vault.azure.net/",
    "AppInsights": "InstrumentationKey=..."
  }
}
```

### Production Environment
```json
{
  "Environment": "Production",
  "ConnectionStrings": {
    "DefaultConnection": "[Retrieved from Key Vault]",
    "Redis": "[Retrieved from Key Vault]"
  },
  "Services": {
    "BlobStorage": "[Retrieved from Key Vault]",
    "KeyVault": "https://erp-prod-kv.vault.azure.net/",
    "AppInsights": "[Retrieved from Key Vault]"
  }
}
```

## Docker Configuration

### Dockerfile
```dockerfile
# Build stage
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /src

# Copy solution and project files
COPY ["ErpBackEnd.sln", "./"]
COPY ["src/Core/ErpBackEnd.Domain/ErpBackEnd.Domain.csproj", "src/Core/ErpBackEnd.Domain/"]
COPY ["src/Core/ErpBackEnd.Application/ErpBackEnd.Application.csproj", "src/Core/ErpBackEnd.Application/"]
COPY ["src/Infrastructure/ErpBackEnd.Infrastructure/ErpBackEnd.Infrastructure.csproj", "src/Infrastructure/ErpBackEnd.Infrastructure/"]
COPY ["src/Presentation/ErpBackEnd.API/ErpBackEnd.API.csproj", "src/Presentation/ErpBackEnd.API/"]

# Restore packages
RUN dotnet restore "ErpBackEnd.sln"

# Copy source code
COPY . .

# Build
WORKDIR "/src/src/Presentation/ErpBackEnd.API"
RUN dotnet build "ErpBackEnd.API.csproj" -c Release -o /app/build

# Publish
FROM build AS publish
RUN dotnet publish "ErpBackEnd.API.csproj" -c Release -o /app/publish /p:UseAppHost=false

# Runtime stage
FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS final
WORKDIR /app

# Install culture data for globalization
RUN apt-get update && apt-get install -y locales
RUN locale-gen ar_SA.UTF-8
ENV LANG ar_SA.UTF-8
ENV LANGUAGE ar_SA:ar
ENV LC_ALL ar_SA.UTF-8

# Security: Run as non-root user
RUN useradd -m -u 1000 -s /bin/bash appuser
USER appuser

COPY --from=publish /app/publish .

# Health check
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl --fail http://localhost:8080/health || exit 1

EXPOSE 8080
ENTRYPOINT ["dotnet", "ErpBackEnd.API.dll"]
```

### Docker Compose (Development)
```yaml
version: '3.8'

services:
  api:
    build:
      context: .
      dockerfile: Dockerfile
    ports:
      - "5000:8080"
    environment:
      - ASPNETCORE_ENVIRONMENT=Development
      - ConnectionStrings__DefaultConnection=Server=sqlserver;Database=ErpDev;User Id=sa;Password=YourStrong@Password;
      - ConnectionStrings__Redis=redis:6379
    depends_on:
      - sqlserver
      - redis
    networks:
      - erp-network

  sqlserver:
    image: mcr.microsoft.com/mssql/server:2022-latest
    ports:
      - "1433:1433"
    environment:
      - SA_PASSWORD=YourStrong@Password
      - ACCEPT_EULA=Y
      - MSSQL_PID=Developer
    volumes:
      - sqldata:/var/opt/mssql
    networks:
      - erp-network

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    command: redis-server --appendonly yes
    volumes:
      - redisdata:/data
    networks:
      - erp-network

  seq:
    image: datalust/seq:latest
    ports:
      - "5341:80"
    environment:
      - ACCEPT_EULA=Y
    volumes:
      - seqdata:/data
    networks:
      - erp-network

volumes:
  sqldata:
  redisdata:
  seqdata:

networks:
  erp-network:
    driver: bridge
```

## Kubernetes Deployment

### Deployment Manifest
```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: erp-api
  namespace: erp-system
spec:
  replicas: 3
  selector:
    matchLabels:
      app: erp-api
  template:
    metadata:
      labels:
        app: erp-api
    spec:
      containers:
      - name: api
        image: erpacr.azurecr.io/erp-api:latest
        ports:
        - containerPort: 8080
        env:
        - name: ASPNETCORE_ENVIRONMENT
          value: "Production"
        - name: KeyVault__Uri
          value: "https://erp-prod-kv.vault.azure.net/"
        resources:
          requests:
            memory: "256Mi"
            cpu: "250m"
          limits:
            memory: "512Mi"
            cpu: "500m"
        livenessProbe:
          httpGet:
            path: /health/live
            port: 8080
          initialDelaySeconds: 30
          periodSeconds: 30
        readinessProbe:
          httpGet:
            path: /health/ready
            port: 8080
          initialDelaySeconds: 5
          periodSeconds: 10
        volumeMounts:
        - name: secrets
          mountPath: /app/secrets
          readOnly: true
      volumes:
      - name: secrets
        csi:
          driver: secrets-store.csi.k8s.io
          readOnly: true
          volumeAttributes:
            secretProviderClass: azure-keyvault
---
apiVersion: v1
kind: Service
metadata:
  name: erp-api-service
  namespace: erp-system
spec:
  selector:
    app: erp-api
  ports:
  - port: 80
    targetPort: 8080
  type: LoadBalancer
---
apiVersion: autoscaling/v2
kind: HorizontalPodAutoscaler
metadata:
  name: erp-api-hpa
  namespace: erp-system
spec:
  scaleTargetRef:
    apiVersion: apps/v1
    kind: Deployment
    name: erp-api
  minReplicas: 3
  maxReplicas: 10
  metrics:
  - type: Resource
    resource:
      name: cpu
      target:
        type: Utilization
        averageUtilization: 70
  - type: Resource
    resource:
      name: memory
      target:
        type: Utilization
        averageUtilization: 80
```

## Redis Configuration

### Cache Strategy
```csharp
public class RedisCacheService : ICacheService
{
    private readonly IConnectionMultiplexer _redis;
    private readonly IDatabase _cache;
    private readonly ILogger<RedisCacheService> _logger;

    public RedisCacheService(IConnectionMultiplexer redis, ILogger<RedisCacheService> logger)
    {
        _redis = redis;
        _cache = redis.GetDatabase();
        _logger = logger;
    }

    public async Task<T?> GetAsync<T>(string key) where T : class
    {
        try
        {
            var value = await _cache.StringGetAsync(key);
            if (value.IsNull) return null;
            
            return JsonSerializer.Deserialize<T>(value!);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error getting cache key: {Key}", key);
            return null; // Fail gracefully
        }
    }

    public async Task SetAsync<T>(string key, T value, TimeSpan? expiry = null) where T : class
    {
        try
        {
            var json = JsonSerializer.Serialize(value);
            await _cache.StringSetAsync(key, json, expiry ?? TimeSpan.FromMinutes(5));
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error setting cache key: {Key}", key);
            // Don't throw - caching should not break the application
        }
    }

    public async Task<bool> DeleteAsync(string key)
    {
        try
        {
            return await _cache.KeyDeleteAsync(key);
        }
        catch (Exception ex)
        {
            _logger.LogError(ex, "Error deleting cache key: {Key}", key);
            return false;
        }
    }

    public async Task FlushAsync(string pattern)
    {
        var endpoints = _redis.GetEndPoints();
        var server = _redis.GetServer(endpoints.First());
        
        var keys = server.Keys(pattern: pattern);
        foreach (var key in keys)
        {
            await DeleteAsync(key);
        }
    }
}
```

### Cache Key Patterns
```
{tenant}:{module}:{entity}:{id}
{tenant}:{module}:{entity}:list:{hash}
{tenant}:user:{userId}:permissions
{tenant}:config:{key}

Examples:
- tenant1:accounting:account:123
- tenant1:accounting:account:list:abc123
- tenant1:user:456:permissions
- tenant1:config:vat-rate
```

### Cache Invalidation Strategy
1. **Time-based**: Default 5 minutes for reference data, 1 minute for transactional data
2. **Event-based**: Invalidate on domain events (e.g., EntityUpdated, EntityDeleted)
3. **Manual**: Provide admin endpoints to flush specific cache patterns

## SQL Server Configuration

### Connection Pooling
```csharp
services.AddSingleton<IDbConnection>(sp =>
{
    var connectionString = configuration.GetConnectionString("DefaultConnection");
    return new SqlConnection(connectionString);
});

// Connection string with pooling parameters
"Server=erp.database.windows.net;Database=ErpProd;User Id=erpuser;Password=***;
 Min Pool Size=10;Max Pool Size=100;Connect Timeout=30;
 Application Name=ERP-API;MultipleActiveResultSets=true;"
```

### Performance Optimization
```sql
-- Enable Query Store
ALTER DATABASE ErpProd SET QUERY_STORE = ON
(
    OPERATION_MODE = READ_WRITE,
    CLEANUP_POLICY = (STALE_QUERY_THRESHOLD_DAYS = 30),
    DATA_FLUSH_INTERVAL_SECONDS = 900,
    MAX_STORAGE_SIZE_MB = 1000,
    INTERVAL_LENGTH_MINUTES = 60
);

-- Create maintenance plan
-- Weekly index rebuild
EXEC sp_MSforeachtable 'ALTER INDEX ALL ON ? REBUILD WITH (ONLINE = ON)';

-- Daily statistics update
EXEC sp_updatestats;

-- Monitor expensive queries
SELECT TOP 10
    qs.total_elapsed_time / qs.execution_count AS avg_elapsed_time,
    qs.total_logical_reads / qs.execution_count AS avg_logical_reads,
    qs.execution_count,
    SUBSTRING(st.text, (qs.statement_start_offset/2)+1,
        ((CASE qs.statement_end_offset
            WHEN -1 THEN DATALENGTH(st.text)
            ELSE qs.statement_end_offset
        END - qs.statement_start_offset)/2) + 1) AS statement_text
FROM sys.dm_exec_query_stats qs
CROSS APPLY sys.dm_exec_sql_text(qs.sql_handle) st
ORDER BY avg_elapsed_time DESC;
```

## Monitoring & Observability

### Application Insights Configuration
```csharp
// Program.cs
builder.Services.AddApplicationInsightsTelemetry(options =>
{
    options.ConnectionString = configuration["ApplicationInsights:ConnectionString"];
    options.EnableAdaptiveSampling = true;
    options.EnableDependencyTrackingTelemetryModule = true;
    options.EnablePerformanceCounterCollectionModule = true;
    options.EnableRequestTrackingTelemetryModule = true;
});

builder.Services.AddSingleton<ITelemetryInitializer, CustomTelemetryInitializer>();

// Custom telemetry
public class CustomTelemetryInitializer : ITelemetryInitializer
{
    public void Initialize(ITelemetry telemetry)
    {
        telemetry.Context.GlobalProperties["Environment"] = Environment.GetEnvironmentVariable("ASPNETCORE_ENVIRONMENT");
        telemetry.Context.GlobalProperties["Version"] = Assembly.GetExecutingAssembly().GetName().Version?.ToString();
        
        if (telemetry is RequestTelemetry request)
        {
            // Add user context
            request.Properties["UserId"] = HttpContext.Current?.User?.FindFirst("sub")?.Value;
            request.Properties["TenantId"] = HttpContext.Current?.User?.FindFirst("tid")?.Value;
        }
    }
}
```

### Health Checks
```csharp
builder.Services.AddHealthChecks()
    .AddSqlServer(
        configuration.GetConnectionString("DefaultConnection"),
        name: "sql-server",
        tags: new[] { "db", "critical" })
    .AddRedis(
        configuration.GetConnectionString("Redis"),
        name: "redis",
        tags: new[] { "cache" })
    .AddAzureBlobStorage(
        configuration["AzureStorage:ConnectionString"],
        name: "blob-storage",
        tags: new[] { "storage" })
    .AddCheck<CustomHealthCheck>("custom-check");

// Custom health check
public class CustomHealthCheck : IHealthCheck
{
    public async Task<HealthCheckResult> CheckHealthAsync(
        HealthCheckContext context,
        CancellationToken cancellationToken = default)
    {
        try
        {
            // Check critical services
            var isHealthy = await CheckCriticalServicesAsync();
            
            return isHealthy
                ? HealthCheckResult.Healthy("All systems operational")
                : HealthCheckResult.Unhealthy("One or more critical services are down");
        }
        catch (Exception ex)
        {
            return HealthCheckResult.Unhealthy("Health check failed", ex);
        }
    }
}
```

### Logging Configuration (Serilog)
```csharp
// Program.cs
builder.Host.UseSerilog((context, services, configuration) => configuration
    .ReadFrom.Configuration(context.Configuration)
    .ReadFrom.Services(services)
    .Enrich.FromLogContext()
    .Enrich.WithMachineName()
    .Enrich.WithEnvironmentName()
    .Enrich.WithProperty("Application", "ERP-API")
    .WriteTo.Console(
        outputTemplate: "[{Timestamp:HH:mm:ss} {Level:u3}] {Message:lj} {Properties:j}{NewLine}{Exception}")
    .WriteTo.ApplicationInsights(
        services.GetRequiredService<TelemetryConfiguration>(),
        TelemetryConverter.Traces)
    .WriteTo.File(
        path: "logs/erp-.log",
        rollingInterval: RollingInterval.Day,
        retainedFileCountLimit: 30));

// appsettings.json
{
  "Serilog": {
    "MinimumLevel": {
      "Default": "Information",
      "Override": {
        "Microsoft": "Warning",
        "Microsoft.Hosting.Lifetime": "Information",
        "Microsoft.EntityFrameworkCore": "Warning"
      }
    }
  }
}
```

## Security Hardening

### Network Security
```yaml
# Network Policy for Kubernetes
apiVersion: networking.k8s.io/v1
kind: NetworkPolicy
metadata:
  name: erp-api-network-policy
  namespace: erp-system
spec:
  podSelector:
    matchLabels:
      app: erp-api
  policyTypes:
  - Ingress
  - Egress
  ingress:
  - from:
    - namespaceSelector:
        matchLabels:
          name: ingress-nginx
    ports:
    - protocol: TCP
      port: 8080
  egress:
  - to:
    - namespaceSelector: {}
    ports:
    - protocol: TCP
      port: 1433  # SQL Server
    - protocol: TCP
      port: 6379  # Redis
    - protocol: TCP
      port: 443   # HTTPS for external services
```

### Secrets Management
```csharp
// Azure Key Vault integration
builder.Configuration.AddAzureKeyVault(
    new Uri($"https://{configuration["KeyVault:Name"]}.vault.azure.net/"),
    new DefaultAzureCredential(),
    new AzureKeyVaultConfigurationOptions
    {
        ReloadInterval = TimeSpan.FromMinutes(5)
    });

// Kubernetes secrets
apiVersion: v1
kind: Secret
metadata:
  name: erp-secrets
  namespace: erp-system
type: Opaque
data:
  db-password: <base64-encoded>
  redis-password: <base64-encoded>
  jwt-key: <base64-encoded>
```

## Backup & Disaster Recovery

### Database Backup Strategy
1. **Full Backup**: Daily at 2 AM UTC
2. **Differential Backup**: Every 6 hours
3. **Transaction Log Backup**: Every 15 minutes
4. **Retention**: 30 days local, 1 year in cold storage
5. **Geo-replication**: Active-passive to secondary region

### Recovery Procedures
```sql
-- Point-in-time recovery
RESTORE DATABASE ErpProd FROM DISK = 'backup.bak'
WITH NORECOVERY;

RESTORE DATABASE ErpProd FROM DISK = 'diff.bak'
WITH NORECOVERY;

RESTORE LOG ErpProd FROM DISK = 'log1.trn'
WITH NORECOVERY;

RESTORE LOG ErpProd FROM DISK = 'log2.trn'
WITH RECOVERY, STOPAT = '2024-01-15 14:30:00';
```

### RTO & RPO Targets
- **RTO (Recovery Time Objective)**: < 4 hours
- **RPO (Recovery Point Objective)**: < 15 minutes
- **Availability SLA**: 99.9% (8.76 hours downtime/year)

## Performance Benchmarks

### Target Metrics
| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| API Response Time (p50) | < 100ms | - | ⏳ |
| API Response Time (p95) | < 200ms | - | ⏳ |
| API Response Time (p99) | < 500ms | - | ⏳ |
| Database Query Time (p95) | < 50ms | - | ⏳ |
| Redis Cache Hit Rate | > 90% | - | ⏳ |
| Concurrent Users | > 1000 | - | ⏳ |
| Requests per Second | > 500 | - | ⏳ |
| CPU Usage | < 70% | - | ⏳ |
| Memory Usage | < 80% | - | ⏳ |

### Load Testing Script (K6)
```javascript
import http from 'k6/http';
import { check, sleep } from 'k6';

export let options = {
  stages: [
    { duration: '2m', target: 100 }, // Ramp up
    { duration: '5m', target: 100 }, // Stay at 100 users
    { duration: '2m', target: 200 }, // Ramp up
    { duration: '5m', target: 200 }, // Stay at 200 users
    { duration: '2m', target: 0 },   // Ramp down
  ],
  thresholds: {
    http_req_duration: ['p(95)<200'], // 95% of requests must complete below 200ms
    http_req_failed: ['rate<0.01'],   // Error rate must be below 1%
  },
};

export default function () {
  let response = http.get('https://api.erp.com/api/v1/health');
  check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 200ms': (r) => r.timings.duration < 200,
  });
  sleep(1);
}
```

## Deployment Checklist

### Pre-deployment
- [ ] All tests passing (unit, integration, E2E)
- [ ] Code review completed
- [ ] Security scan passed
- [ ] Performance benchmarks met
- [ ] Documentation updated
- [ ] Database migrations prepared
- [ ] Rollback plan documented

### Deployment
- [ ] Create database backup
- [ ] Deploy to staging
- [ ] Run smoke tests
- [ ] Deploy to production (blue-green)
- [ ] Verify health checks
- [ ] Monitor metrics

### Post-deployment
- [ ] Verify all services healthy
- [ ] Check error rates
- [ ] Monitor performance metrics
- [ ] User acceptance verification
- [ ] Update status page
- [ ] Archive deployment artifacts