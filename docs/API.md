# API Design Guidelines

## Overview
RESTful API for ERP System | ASP.NET Core 8 | Simple & Practical

## Base URL Structure
```
Development: http://localhost:5000/api/v1
Production: https://api.yourdomain.com/api/v1
```

## Authentication
- **Method**: JWT Bearer Token
- **Header**: `Authorization: Bearer {token}`
- **Login**: `POST /api/v1/auth/login`
- **Refresh**: `POST /api/v1/auth/refresh`

## Standard Responses

### Success
```json
{
  "success": true,
  "data": { },
  "message": "Success"
}
```

### Error
```json
{
  "success": false,
  "error": {
    "code": "ERROR_CODE",
    "message": "Error description"
  }
}
```

### Paginated
```json
{
  "success": true,
  "data": {
    "items": [],
    "pageNumber": 1,
    "pageSize": 20,
    "totalCount": 100
  }
}
```

## Common Status Codes
- **200**: Success
- **201**: Created
- **400**: Bad Request
- **401**: Unauthorized
- **403**: Forbidden
- **404**: Not Found
- **500**: Server Error

## Module Endpoints

### Accounting
```
GET    /api/v1/accounts           - List accounts
GET    /api/v1/accounts/{id}      - Get account
POST   /api/v1/accounts           - Create account
PUT    /api/v1/accounts/{id}      - Update account
DELETE /api/v1/accounts/{id}      - Delete account

GET    /api/v1/journal-entries    - List entries
POST   /api/v1/journal-entries    - Create entry
```

### Inventory
```
GET    /api/v1/products           - List products
GET    /api/v1/products/{id}      - Get product
POST   /api/v1/products           - Create product
PUT    /api/v1/products/{id}      - Update product
DELETE /api/v1/products/{id}      - Delete product

GET    /api/v1/warehouses         - List warehouses
GET    /api/v1/products/{id}/stock - Get stock level
```

### Customers
```
GET    /api/v1/customers          - List customers
GET    /api/v1/customers/{id}     - Get customer
POST   /api/v1/customers          - Create customer
PUT    /api/v1/customers/{id}     - Update customer
DELETE /api/v1/customers/{id}     - Delete customer
GET    /api/v1/customers/{id}/balance - Get balance
```

### Vendors
```
GET    /api/v1/vendors            - List vendors
GET    /api/v1/vendors/{id}       - Get vendor
POST   /api/v1/vendors            - Create vendor
PUT    /api/v1/vendors/{id}       - Update vendor
DELETE /api/v1/vendors/{id}       - Delete vendor
```

### Sales
```
GET    /api/v1/sales-orders       - List orders
GET    /api/v1/sales-orders/{id}  - Get order
POST   /api/v1/sales-orders       - Create order
PUT    /api/v1/sales-orders/{id}  - Update order
POST   /api/v1/sales-orders/{id}/confirm - Confirm order

GET    /api/v1/sales-invoices     - List invoices
POST   /api/v1/sales-invoices     - Create invoice
```

### Purchases
```
GET    /api/v1/purchase-orders    - List POs
GET    /api/v1/purchase-orders/{id} - Get PO
POST   /api/v1/purchase-orders    - Create PO
PUT    /api/v1/purchase-orders/{id} - Update PO
POST   /api/v1/purchase-orders/{id}/approve - Approve PO
```

### VAT/ZATCA
```
GET    /api/v1/vat/settings       - Get VAT settings
POST   /api/v1/vat/submit-invoice - Submit to ZATCA
POST   /api/v1/vat/generate-qr    - Generate QR code
```

## Query Parameters
- `pageNumber=1` - Page number
- `pageSize=20` - Items per page (max 100)
- `search=text` - Search term
- `sortBy=name` - Sort field
- `sortOrder=asc` - Sort direction (asc/desc)

## Common Headers
- `Accept-Language: ar-SA` or `en-US` - For localization
- `Content-Type: application/json`

## Rate Limiting
- **Authenticated users**: 100 requests/minute
- **Admin users**: 500 requests/minute

## Validation Rules
### Customer Example
- **Name**: Required, max 200 characters
- **Email**: Valid email format
- **Phone**: Saudi format (05xxxxxxxx)
- **VAT Number**: 15 digits
- **CR Number**: 10 digits

## Error Codes
| Code | Meaning |
|------|---------|
| AUTH_001 | Invalid login |
| AUTH_002 | Token expired |
| VAL_001 | Missing required field |
| VAL_002 | Invalid format |
| BUS_001 | Duplicate record |
| BUS_002 | Cannot delete (has references) |

## File Upload
- **Endpoint**: `POST /api/v1/files/upload`
- **Max Size**: 10MB
- **Allowed Types**: PDF, Excel, Images

## Health Check
```
GET /health          - Basic health check
GET /health/ready    - Database connection check
```

## Development Notes
- Use Swagger UI at `/swagger` for testing
- All dates in UTC format
- All IDs are GUIDs
- Use parameterized queries
- Log all errors

## Example Requests

### Login
```http
POST /api/v1/auth/login
{
  "email": "admin@company.com",
  "password": "SecurePass123"
}
```

### Create Customer
```http
POST /api/v1/customers
Authorization: Bearer {token}
{
  "nameAr": "شركة النجاح",
  "nameEn": "Success Company",
  "email": "info@success.sa",
  "phone": "0501234567",
  "vatNumber": "300000000000003"
}
```

### Get Customers (Paginated)
```http
GET /api/v1/customers?pageNumber=1&pageSize=20&search=احمد
Authorization: Bearer {token}
```

## Controller Example Pattern
```csharp
[ApiController]
[Route("api/v1/[controller]")]
[Authorize]
public class CustomersController : ControllerBase
{
    [HttpGet]
    public async Task<IActionResult> GetAll([FromQuery] PagedQuery query)
    
    [HttpGet("{id}")]
    public async Task<IActionResult> GetById(Guid id)
    
    [HttpPost]
    public async Task<IActionResult> Create([FromBody] CreateCustomerDto dto)
    
    [HttpPut("{id}")]
    public async Task<IActionResult> Update(Guid id, [FromBody] UpdateCustomerDto dto)
    
    [HttpDelete("{id}")]
    public async Task<IActionResult> Delete(Guid id)
}
```