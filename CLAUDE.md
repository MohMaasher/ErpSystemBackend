# ERP System Context - v2.1

## Overview
Saudi ERP | 200+ SQL Server tables | ASP.NET Core 8 | Dapper | Redis | Clean Architecture + DDD + CQRS

## Guiding Principles
- **Performance First:** Decisions must prioritize API response time and database efficiency
- **Security by Design:** Security is a core feature, not an afterthought
- **Pragmatism over Dogma:** Choose the right tool for the job, even if it deviates from a pattern
- **Maintainability is Key:** Code and documentation should be clear for future developers
- **Automate Everything:** From testing to deployment and infrastructure

## Project Structure
```
/src
  /Core
    /ErpBackEnd.Domain          # Entities, Value Objects, Domain Events, Interfaces
    /ErpBackEnd.Application     # CQRS, DTOs, Validators, Application Services
  /Infrastructure
    /ErpBackEnd.Infrastructure  # Data Access, External Services, Caching
  /Presentation
    /ErpBackEnd.API             # Controllers, Middleware, API Configuration
/tests
  /ErpBackEnd.UnitTests
  /ErpBackEnd.IntegrationTests
/docs                           # Documentation
/snippets                       # Code templates and patterns
/sql                           # Database scripts and stored procedures
```

## Critical Decisions
| Area          | Choice                             | Reason & Trade-off                                      |
|---------------|------------------------------------|---------------------------------------------------------|
| ORM           | Dapper only                        | Max performance & control over SQL. Trade-off: More boilerplate code |
| Delete        | Hard delete + TransactionLog       | ID reuse, performance. Trade-off: Recovery is via logs, not simple flags |
| Localization  | DB columns (NameAr/En/Fr)          | Query performance. Trade-off: Less flexible; re-evaluate if >3 languages |
| Communication | Domain Events (MediatR)            | Loose coupling, extensible business logic |
| Auth          | JWT + RBAC (Permissions)           | Standard, granular control. Refresh tokens for better UX |
| Caching       | Redis (distributed)                | Scalability. Trade-off: Added infrastructure complexity |
| Testing       | xUnit + Moq + FluentAssertions     | Industry standard, readable assertions |

## Modules (Bounded Contexts)
1. **Accounting** - Chart of Accounts, Journal Entries, Financial Reports
2. **Inventory** - Products, Stock Management, Warehouses, Transfers
3. **Customers** - Customer Management, Credit Limits, Aging Reports
4. **Vendors** - Vendor Management, Contracts, Performance Tracking
5. **Sales** - Orders, Quotations, Invoices, Returns
6. **Purchases** - Purchase Orders, Receipts, Vendor Invoices
7. **VAT/ZATCA** - Tax Compliance, E-Invoicing, QR Codes, Phase 2 Integration

## Prohibited Practices ❌
- Entity Framework (use Dapper)
- Database migrations (DB first approach)
- Soft delete (use TransactionLog for history)
- Synchronous DB/IO calls
- Raw SQL without parameters (Dapper.SqlBuilder is allowed)
- Exposing DB IDs in URLs (use GUIDs or hashed IDs)
- Direct HTTP context access in business logic
- Circular dependencies between layers
- Business logic in controllers

## Required Practices ✅
- Async/await for all IO operations
- UnitOfWork for transaction management
- TransactionLog for critical data changes
- FluentValidation for all API inputs
- Always use parameterized queries
- ICurrentUserProvider for user context (decoupled from HTTP)
- CQRS pattern for complex operations
- Domain events for side effects
- Comprehensive unit tests (>80% coverage)
- API versioning from day one

## Database Strategy
- Existing 200+ tables (no migrations)
- Use stored procedures where they exist
- Views for complex reporting queries
- Indexes reviewed quarterly
- All entities need audit fields: CreatedBy, CreatedDate, ModifiedBy, ModifiedDate

## Current Sprint
- [ ] Generic Repository pattern
- [ ] UnitOfWork + TransactionLog
- [ ] User Authentication (JWT + Refresh)
- [ ] Customer CRUD operations
- [ ] Basic ZATCA integration setup

**Definition of Done:** Merged to main with unit tests + docs updated

## Development Workflow
1. Create feature branch from `develop`
2. Write failing tests first (TDD)
3. Implement feature
4. Ensure all tests pass
5. Update documentation if needed
6. Create pull request with description
7. Code review by at least one team member
8. Merge to `develop` after approval

## Quick Start
```bash
# 1. Clone repository
git clone https://github.com/company/erp-backend.git

# 2. Restore packages
dotnet restore

# 3. Update connection strings in appsettings.Development.json

# 4. Run Redis locally (Docker)
docker run -d -p 6379:6379 redis:latest

# 5. Run the API
dotnet run --project src/Presentation/ErpBackEnd.API

# 6. Access Swagger
http://localhost:5000/swagger
```

## Performance Targets
- API Response Time: <200ms (p95)
- Database Query Time: <50ms (p95)
- Redis Cache Hit Rate: >90%
- Concurrent Users: 1000+
- Requests per Second: 500+

## Security Requirements
- OWASP Top 10 compliance
- PCI DSS compliance for payment data
- GDPR compliance for EU customers
- Saudi PDPL compliance
- ZATCA Phase 2 security requirements
- Regular penetration testing
- Automated vulnerability scanning

## Monitoring & Observability
- Application Insights for APM
- Structured logging with Serilog
- Distributed tracing with OpenTelemetry
- Health checks at `/health`
- Metrics exposed for Prometheus at `/metrics`

## Important Notes
- Check existing stored procedures before writing new SQL
- Use IOptions pattern for configuration
- Redis keys follow pattern: `{module}:{entity}:{id}` (e.g., `accounting:account:123`)
- Background jobs use Hangfire with Redis storage
- File uploads go to Azure Blob Storage, never to database
- ZATCA certificates stored in Azure Key Vault

## Project Management
- **Backlog & Sprints:** Azure DevOps
- **CI/CD Pipeline:** GitHub Actions → Azure Container Registry → AKS
- **Source Code:** Private GitHub Repository
- **Communication:** Microsoft Teams
- **Documentation:** This repository + Confluence

## References
- API Design → @docs/API.md
- Security & Auth → @docs/SECURITY.md
- Database Schema → @docs/DATABASE.md
- VAT/ZATCA Integration → @docs/ZATCA.md
- Infrastructure → @docs/INFRA.md
- Testing Strategy → @docs/TESTING.md
- Project Roadmap → @docs/ROADMAP.md
- Code Patterns → @snippets/