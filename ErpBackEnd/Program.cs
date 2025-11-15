using System.Data;
using System.Reflection;
using ErpBackEnd.Domain.Interfaces;
using ErpBackEnd.Domain.Interfaces.Repositories;
using ErpBackEnd.Infrastructure.Persistence;
using ErpBackEnd.Infrastructure.Persistence.Repositories;
using ErpBackEnd.Infrastructure.Services;
using FluentValidation;
using Microsoft.Data.SqlClient;
using Microsoft.OpenApi.Models;

var builder = WebApplication.CreateBuilder(args);

// ===== Database Configuration =====
builder.Services.AddScoped<IDbConnection>(sp =>
{
    var connectionString = builder.Configuration.GetConnectionString("DefaultConnection")
        ?? throw new InvalidOperationException("Database connection string not configured");
    return new SqlConnection(connectionString);
});

// ===== HTTP Context Accessor =====
builder.Services.AddHttpContextAccessor();

// ===== Current User Provider =====
builder.Services.AddScoped<ICurrentUserProvider, HttpContextCurrentUserProvider>();

// ===== Unit of Work =====
builder.Services.AddScoped<IUnitOfWork, UnitOfWork>();

// ===== Repositories =====
builder.Services.AddScoped<IProductRepository, ProductRepository>();
builder.Services.AddScoped<IProductUnitRepository, ProductUnitRepository>();
builder.Services.AddScoped<IWarehouseRepository, WarehouseRepository>();
builder.Services.AddScoped<IStockBinRepository, StockBinRepository>();

// ===== Transaction Log Service =====
builder.Services.AddScoped<ITransactionLogService, TransactionLogService>();

// ===== MediatR for CQRS =====
builder.Services.AddMediatR(cfg => cfg.RegisterServicesFromAssembly(
    Assembly.Load("ErpBackEnd.Application")));

// ===== FluentValidation =====
builder.Services.AddValidatorsFromAssembly(Assembly.Load("ErpBackEnd.Application"));

// ===== Controllers with JSON Configuration =====
builder.Services.AddControllers()
    .AddJsonOptions(options =>
    {
        options.JsonSerializerOptions.PropertyNamingPolicy = null; // Use PascalCase
        options.JsonSerializerOptions.WriteIndented = true;
    });

// ===== CORS Configuration =====
builder.Services.AddCors(options =>
{
    options.AddDefaultPolicy(policy =>
    {
        policy.WithOrigins(
                builder.Configuration.GetSection("Cors:AllowedOrigins").Get<string[]>()
                ?? new[] { "http://localhost:3000", "http://localhost:4200" })
            .AllowAnyHeader()
            .AllowAnyMethod()
            .AllowCredentials();
    });
});

// ===== API Documentation (Swagger/OpenAPI) =====
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen(options =>
{
    options.SwaggerDoc("v1", new OpenApiInfo
    {
        Title = "ERP System API",
        Version = "v1",
        Description = "API for ERP System - Inventory Module",
        Contact = new OpenApiContact
        {
            Name = "ERP System",
            Email = "support@erpsystem.com"
        }
    });

    // Add XML comments for better documentation
    var xmlFile = $"{Assembly.GetExecutingAssembly().GetName().Name}.xml";
    var xmlPath = Path.Combine(AppContext.BaseDirectory, xmlFile);
    if (File.Exists(xmlPath))
    {
        options.IncludeXmlComments(xmlPath);
    }

    // Add JWT authentication to Swagger
    options.AddSecurityDefinition("Bearer", new OpenApiSecurityScheme
    {
        Description = "JWT Authorization header using the Bearer scheme. Enter 'Bearer' [space] and then your token.",
        Name = "Authorization",
        In = ParameterLocation.Header,
        Type = SecuritySchemeType.ApiKey,
        Scheme = "Bearer"
    });

    options.AddSecurityRequirement(new OpenApiSecurityRequirement
    {
        {
            new OpenApiSecurityScheme
            {
                Reference = new OpenApiReference
                {
                    Type = ReferenceType.SecurityScheme,
                    Id = "Bearer"
                }
            },
            Array.Empty<string>()
        }
    });
});

// ===== Build Application =====
var app = builder.Build();

// ===== Development Environment Configuration =====
if (app.Environment.IsDevelopment())
{
    app.UseSwagger();
    app.UseSwaggerUI(options =>
    {
        options.SwaggerEndpoint("/swagger/v1/swagger.json", "ERP System API v1");
        options.RoutePrefix = "swagger";
    });
}

// ===== HTTP Request Pipeline =====
app.UseHttpsRedirection();

app.UseCors();

app.UseAuthentication();
app.UseAuthorization();

app.MapControllers();

// ===== Health Check Endpoint =====
app.MapGet("/health", () => Results.Ok(new
{
    Status = "Healthy",
    Timestamp = DateTime.UtcNow,
    Environment = app.Environment.EnvironmentName
}))
.WithName("HealthCheck")
.WithOpenApi();

app.Run();
