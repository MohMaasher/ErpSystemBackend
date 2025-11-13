# Testing Strategy Documentation

## Overview
Comprehensive testing strategy following the testing pyramid principle with emphasis on unit tests, complemented by integration and E2E tests.

## Testing Pyramid
```
         /\
        /E2E\        (5%)  - Critical user journeys
       /------\
      /  Integ \     (20%) - API & Database tests
     /----------\
    /    Unit    \   (75%) - Business logic & domain
   /--------------\
```

## Test Coverage Requirements
- **Overall**: Minimum 80%
- **Domain Layer**: Minimum 90%
- **Application Layer**: Minimum 85%
- **Infrastructure Layer**: Minimum 70%
- **API Layer**: Minimum 75%

## Unit Testing

### Test Naming Convention
```csharp
[MethodName]_[Scenario]_[ExpectedBehavior]

Examples:
- CreateAccount_ValidData_ReturnsAccountWithId
- CreateAccount_DuplicateCode_ThrowsBusinessException
- CalculateVAT_StandardRate_Returns15Percent
```

### Domain Entity Tests
```csharp
public class AccountTests
{
    [Fact]
    public void CreateAccount_ValidData_ReturnsAccountWithId()
    {
        // Arrange
        var accountData = new CreateAccountData
        {
            Code = "1001",
            NameAr = "حساب نقدي",
            NameEn = "Cash Account",
            Type = AccountType.Asset,
            Nature = AccountNature.Debit
        };

        // Act
        var account = Account.Create(accountData);

        // Assert
        account.Should().NotBeNull();
        account.Code.Should().Be("1001");
        account.NameAr.Should().Be("حساب نقدي");
        account.NameEn.Should().Be("Cash Account");
        account.Type.Should().Be(AccountType.Asset);
        account.Nature.Should().Be(AccountNature.Debit);
        account.IsActive.Should().BeTrue();
    }

    [Fact]
    public void UpdateBalance_DebitAccount_IncreasesWithDebit()
    {
        // Arrange
        var account = AccountBuilder.Create()
            .WithNature(AccountNature.Debit)
            .WithBalance(1000)
            .Build();

        // Act
        account.UpdateBalance(500, TransactionType.Debit);

        // Assert
        account.Balance.Should().Be(1500);
    }

    [Theory]
    [InlineData("")]
    [InlineData(null)]
    [InlineData("   ")]
    public void CreateAccount_InvalidCode_ThrowsValidationException(string invalidCode)
    {
        // Arrange
        var accountData = new CreateAccountData
        {
            Code = invalidCode,
            NameAr = "حساب",
            NameEn = "Account",
            Type = AccountType.Asset
        };

        // Act & Assert
        var action = () => Account.Create(accountData);
        action.Should().Throw<DomainValidationException>()
            .WithMessage("Account code is required");
    }
}
```

### Application Service Tests
```csharp
public class CreateAccountCommandHandlerTests
{
    private readonly Mock<IUnitOfWork> _unitOfWorkMock;
    private readonly Mock<IAccountRepository> _accountRepositoryMock;
    private readonly Mock<IAuditService> _auditServiceMock;
    private readonly CreateAccountCommandHandler _handler;

    public CreateAccountCommandHandlerTests()
    {
        _unitOfWorkMock = new Mock<IUnitOfWork>();
        _accountRepositoryMock = new Mock<IAccountRepository>();
        _auditServiceMock = new Mock<IAuditService>();
        
        _unitOfWorkMock.Setup(x => x.Accounts).Returns(_accountRepositoryMock.Object);
        
        _handler = new CreateAccountCommandHandler(
            _unitOfWorkMock.Object,
            _auditServiceMock.Object);
    }

    [Fact]
    public async Task Handle_ValidCommand_CreatesAccount()
    {
        // Arrange
        var command = new CreateAccountCommand
        {
            Code = "1001",
            NameAr = "حساب نقدي",
            NameEn = "Cash Account",
            Type = AccountType.Asset,
            Nature = AccountNature.Debit
        };

        _accountRepositoryMock
            .Setup(x => x.GetByCodeAsync(It.IsAny<string>(), It.IsAny<CancellationToken>()))
            .ReturnsAsync((Account)null);

        _accountRepositoryMock
            .Setup(x => x.AddAsync(It.IsAny<Account>(), It.IsAny<IDbTransaction>(), It.IsAny<CancellationToken>()))
            .ReturnsAsync(1);

        // Act
        var result = await _handler.Handle(command, CancellationToken.None);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeTrue();
        result.Value.AccountId.Should().Be(1);
        
        _accountRepositoryMock.Verify(x => x.AddAsync(
            It.Is<Account>(a => a.Code == "1001"),
            It.IsAny<IDbTransaction>(),
            It.IsAny<CancellationToken>()), Times.Once);
        
        _unitOfWorkMock.Verify(x => x.CommitAsync(), Times.Once);
        _auditServiceMock.Verify(x => x.LogAsync(It.IsAny<AuditLog>()), Times.Once);
    }

    [Fact]
    public async Task Handle_DuplicateCode_ReturnsFailure()
    {
        // Arrange
        var command = new CreateAccountCommand { Code = "1001" };
        
        _accountRepositoryMock
            .Setup(x => x.GetByCodeAsync("1001", It.IsAny<CancellationToken>()))
            .ReturnsAsync(new Account());

        // Act
        var result = await _handler.Handle(command, CancellationToken.None);

        // Assert
        result.Should().NotBeNull();
        result.IsSuccess.Should().BeFalse();
        result.Error.Code.Should().Be("DUPLICATE_ACCOUNT_CODE");
        
        _accountRepositoryMock.Verify(x => x.AddAsync(
            It.IsAny<Account>(),
            It.IsAny<IDbTransaction>(),
            It.IsAny<CancellationToken>()), Times.Never);
        
        _unitOfWorkMock.Verify(x => x.CommitAsync(), Times.Never);
    }
}
```

### Validator Tests
```csharp
public class CreateAccountCommandValidatorTests
{
    private readonly CreateAccountCommandValidator _validator;

    public CreateAccountCommandValidatorTests()
    {
        _validator = new CreateAccountCommandValidator();
    }

    [Fact]
    public void Validate_ValidCommand_PassesValidation()
    {
        // Arrange
        var command = new CreateAccountCommand
        {
            Code = "1001",
            NameAr = "حساب نقدي",
            NameEn = "Cash Account",
            Type = AccountType.Asset,
            Nature = AccountNature.Debit
        };

        // Act
        var result = _validator.Validate(command);

        // Assert
        result.IsValid.Should().BeTrue();
    }

    [Theory]
    [InlineData("", "Account code is required")]
    [InlineData("123456789012345678901", "Account code cannot exceed 20 characters")]
    [InlineData("AB@123", "Account code can only contain letters and numbers")]
    public void Validate_InvalidCode_FailsValidation(string code, string expectedError)
    {
        // Arrange
        var command = new CreateAccountCommand { Code = code };

        // Act
        var result = _validator.Validate(command);

        // Assert
        result.IsValid.Should().BeFalse();
        result.Errors.Should().Contain(x => x.ErrorMessage == expectedError);
    }
}
```

## Integration Testing

### Database Integration Tests
```csharp
public class AccountRepositoryIntegrationTests : IClassFixture<DatabaseFixture>
{
    private readonly DatabaseFixture _fixture;
    private readonly AccountRepository _repository;

    public AccountRepositoryIntegrationTests(DatabaseFixture fixture)
    {
        _fixture = fixture;
        _repository = new AccountRepository(_fixture.Connection);
    }

    [Fact]
    public async Task AddAsync_ValidAccount_PersistsToDatabase()
    {
        // Arrange
        var account = new Account
        {
            Code = $"TEST_{Guid.NewGuid():N}",
            NameAr = "حساب اختبار",
            NameEn = "Test Account",
            Type = AccountType.Asset,
            Nature = AccountNature.Debit,
            CreatedBy = 1,
            CreatedDate = DateTime.UtcNow
        };

        // Act
        using var transaction = _fixture.Connection.BeginTransaction();
        var id = await _repository.AddAsync(account, transaction);
        await transaction.CommitAsync();

        // Assert
        id.Should().BeGreaterThan(0);
        
        var savedAccount = await _repository.GetByIdAsync(id);
        savedAccount.Should().NotBeNull();
        savedAccount.Code.Should().Be(account.Code);
        savedAccount.NameAr.Should().Be(account.NameAr);
        savedAccount.NameEn.Should().Be(account.NameEn);
    }

    [Fact]
    public async Task GetByCodeAsync_ExistingCode_ReturnsAccount()
    {
        // Arrange
        var code = "CASH_001";
        await _fixture.SeedAccountAsync(code);

        // Act
        var account = await _repository.GetByCodeAsync(code);

        // Assert
        account.Should().NotBeNull();
        account.Code.Should().Be(code);
    }
}

public class DatabaseFixture : IAsyncLifetime
{
    public IDbConnection Connection { get; private set; }
    private string _databaseName;

    public async Task InitializeAsync()
    {
        _databaseName = $"TestDb_{Guid.NewGuid():N}";
        var masterConnection = new SqlConnection("Server=localhost;Database=master;Trusted_Connection=true;");
        
        await masterConnection.ExecuteAsync($"CREATE DATABASE [{_databaseName}]");
        
        Connection = new SqlConnection($"Server=localhost;Database={_databaseName};Trusted_Connection=true;");
        
        // Run migrations or setup scripts
        await SetupDatabaseSchema();
    }

    public async Task DisposeAsync()
    {
        Connection?.Dispose();
        
        var masterConnection = new SqlConnection("Server=localhost;Database=master;Trusted_Connection=true;");
        await masterConnection.ExecuteAsync($"DROP DATABASE [{_databaseName}]");
    }

    private async Task SetupDatabaseSchema()
    {
        // Create tables and seed reference data
        await Connection.ExecuteAsync(@"
            CREATE TABLE AccountChart (
                AccountChartId INT PRIMARY KEY IDENTITY(1,1),
                Code NVARCHAR(20) NOT NULL UNIQUE,
                NameAr NVARCHAR(255) NOT NULL,
                NameEn NVARCHAR(255) NOT NULL,
                Type INT NOT NULL,
                Nature INT NOT NULL,
                IsActive BIT NOT NULL DEFAULT 1,
                CreatedBy INT NOT NULL,
                CreatedDate DATETIME2 NOT NULL,
                ModifiedBy INT NULL,
                ModifiedDate DATETIME2 NULL
            )");
    }
}
```

### API Integration Tests
```csharp
public class AccountsApiIntegrationTests : IClassFixture<CustomWebApplicationFactory<Program>>
{
    private readonly CustomWebApplicationFactory<Program> _factory;
    private readonly HttpClient _client;

    public AccountsApiIntegrationTests(CustomWebApplicationFactory<Program> factory)
    {
        _factory = factory;
        _client = _factory.WithWebHostBuilder(builder =>
        {
            builder.ConfigureTestServices(services =>
            {
                // Override services for testing
                services.AddSingleton<ICurrentUserProvider, TestUserProvider>();
            });
        }).CreateClient();
    }

    [Fact]
    public async Task GetAccounts_AuthorizedUser_ReturnsAccounts()
    {
        // Arrange
        _client.DefaultRequestHeaders.Authorization = 
            new AuthenticationHeaderValue("Bearer", GenerateTestToken());

        // Act
        var response = await _client.GetAsync("/api/v1/accounting/accounts");

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.OK);
        
        var content = await response.Content.ReadAsStringAsync();
        var result = JsonSerializer.Deserialize<ApiResponse<List<AccountDto>>>(content);
        
        result.Should().NotBeNull();
        result.Success.Should().BeTrue();
        result.Data.Should().NotBeNull();
    }

    [Fact]
    public async Task CreateAccount_ValidData_ReturnsCreatedAccount()
    {
        // Arrange
        _client.DefaultRequestHeaders.Authorization = 
            new AuthenticationHeaderValue("Bearer", GenerateTestToken(permissions: "accounts.write"));

        var request = new CreateAccountRequest
        {
            Code = $"TEST_{Guid.NewGuid():N}".Substring(0, 20),
            NameAr = "حساب اختبار",
            NameEn = "Test Account",
            Type = AccountType.Asset,
            Nature = AccountNature.Debit
        };

        // Act
        var response = await _client.PostAsJsonAsync("/api/v1/accounting/accounts", request);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Created);
        response.Headers.Location.Should().NotBeNull();
        
        var content = await response.Content.ReadAsStringAsync();
        var result = JsonSerializer.Deserialize<ApiResponse<AccountDto>>(content);
        
        result.Should().NotBeNull();
        result.Success.Should().BeTrue();
        result.Data.Code.Should().Be(request.Code);
    }

    [Fact]
    public async Task CreateAccount_Unauthorized_Returns401()
    {
        // Arrange
        var request = new CreateAccountRequest { Code = "TEST" };

        // Act
        var response = await _client.PostAsJsonAsync("/api/v1/accounting/accounts", request);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.Unauthorized);
    }

    [Fact]
    public async Task CreateAccount_InvalidData_Returns400WithErrors()
    {
        // Arrange
        _client.DefaultRequestHeaders.Authorization = 
            new AuthenticationHeaderValue("Bearer", GenerateTestToken(permissions: "accounts.write"));

        var request = new CreateAccountRequest
        {
            Code = "", // Invalid: empty code
            NameAr = "حساب",
            NameEn = "Account"
        };

        // Act
        var response = await _client.PostAsJsonAsync("/api/v1/accounting/accounts", request);

        // Assert
        response.StatusCode.Should().Be(HttpStatusCode.BadRequest);
        
        var content = await response.Content.ReadAsStringAsync();
        var result = JsonSerializer.Deserialize<ApiErrorResponse>(content);
        
        result.Should().NotBeNull();
        result.Success.Should().BeFalse();
        result.Errors.Should().ContainSingle(e => e.Field == "Code");
    }
}
```

## End-to-End Testing

### Critical User Journeys
```csharp
public class SalesOrderE2ETests : IClassFixture<E2ETestFixture>
{
    private readonly E2ETestFixture _fixture;
    private readonly HttpClient _client;

    public SalesOrderE2ETests(E2ETestFixture fixture)
    {
        _fixture = fixture;
        _client = _fixture.CreateAuthenticatedClient();
    }

    [Fact]
    public async Task CompleteOrderToInvoiceFlow_Success()
    {
        // Step 1: Create customer
        var customer = await CreateTestCustomer();
        
        // Step 2: Create products
        var product1 = await CreateTestProduct("PROD1", 100);
        var product2 = await CreateTestProduct("PROD2", 200);
        
        // Step 3: Create sales order
        var order = await CreateSalesOrder(customer.CustomerId, new[]
        {
            (product1.ProductId, 5),
            (product2.ProductId, 3)
        });
        
        // Step 4: Confirm order
        await ConfirmOrder(order.OrderId);
        
        // Step 5: Generate invoice
        var invoice = await GenerateInvoice(order.OrderId);
        
        // Step 6: Submit to ZATCA
        await SubmitToZatca(invoice.InvoiceId);
        
        // Assertions
        invoice.Should().NotBeNull();
        invoice.TotalAmount.Should().Be(1100); // (100*5 + 200*3) * 1.15 (VAT)
        invoice.ZatcaStatus.Should().Be("Cleared");
    }

    private async Task<CustomerDto> CreateTestCustomer()
    {
        var request = new CreateCustomerRequest
        {
            CustomerNameAr = "عميل اختبار",
            CustomerNameEn = "Test Customer",
            VATNumber = "300000000000003",
            CustomerType = CustomerType.Company
        };

        var response = await _client.PostAsJsonAsync("/api/v1/customers", request);
        response.EnsureSuccessStatusCode();
        
        var content = await response.Content.ReadAsStringAsync();
        var result = JsonSerializer.Deserialize<ApiResponse<CustomerDto>>(content);
        return result.Data;
    }
}
```

## Test Data Management

### Test Data Builders
```csharp
public class AccountBuilder
{
    private string _code = "TEST_001";
    private string _nameAr = "حساب اختبار";
    private string _nameEn = "Test Account";
    private AccountType _type = AccountType.Asset;
    private AccountNature _nature = AccountNature.Debit;
    private decimal _balance = 0;
    private bool _isActive = true;

    public AccountBuilder WithCode(string code)
    {
        _code = code;
        return this;
    }

    public AccountBuilder WithNature(AccountNature nature)
    {
        _nature = nature;
        return this;
    }

    public AccountBuilder WithBalance(decimal balance)
    {
        _balance = balance;
        return this;
    }

    public Account Build()
    {
        return new Account
        {
            Code = _code,
            NameAr = _nameAr,
            NameEn = _nameEn,
            Type = _type,
            Nature = _nature,
            Balance = _balance,
            IsActive = _isActive,
            CreatedBy = 1,
            CreatedDate = DateTime.UtcNow
        };
    }
}

// Object Mother Pattern
public class ObjectMother
{
    public static Account SimpleDebitAccount() =>
        new AccountBuilder()
            .WithCode("CASH_001")
            .WithNature(AccountNature.Debit)
            .Build();

    public static Account SimpleCreditAccount() =>
        new AccountBuilder()
            .WithCode("REVENUE_001")
            .WithNature(AccountNature.Credit)
            .Build();

    public static JournalEntry SimpleJournalEntry() =>
        new JournalEntryBuilder()
            .WithDebitLine(SimpleDebitAccount(), 1000)
            .WithCreditLine(SimpleCreditAccount(), 1000)
            .Build();
}
```

## Performance Testing

### Benchmark Tests
```csharp
[MemoryDiagnoser]
[SimpleJob(RuntimeMoniker.Net80)]
public class AccountServiceBenchmarks
{
    private AccountService _accountService;
    private List<Account> _accounts;

    [GlobalSetup]
    public void Setup()
    {
        _accountService = new AccountService();
        _accounts = GenerateAccounts(1000);
    }

    [Benchmark]
    public async Task GetAccountByCode()
    {
        await _accountService.GetByCodeAsync("ACC_500");
    }

    [Benchmark]
    public async Task GetAccountsByType()
    {
        await _accountService.GetByTypeAsync(AccountType.Asset);
    }

    [Benchmark]
    public async Task CalculateTrialBalance()
    {
        await _accountService.CalculateTrialBalanceAsync(_accounts);
    }
}
```

## Test Automation

### CI/CD Pipeline Tests
```yaml
# .github/workflows/test.yml
name: Test Pipeline

on:
  push:
    branches: [ main, develop ]
  pull_request:
    branches: [ main, develop ]

jobs:
  test:
    runs-on: ubuntu-latest
    
    services:
      sqlserver:
        image: mcr.microsoft.com/mssql/server:2022-latest
        env:
          SA_PASSWORD: YourStrong@Password
          ACCEPT_EULA: Y
        ports:
          - 1433:1433
      
      redis:
        image: redis:7-alpine
        ports:
          - 6379:6379

    steps:
    - uses: actions/checkout@v3
    
    - name: Setup .NET
      uses: actions/setup-dotnet@v3
      with:
        dotnet-version: 8.0.x
    
    - name: Restore dependencies
      run: dotnet restore
    
    - name: Build
      run: dotnet build --no-restore
    
    - name: Run Unit Tests
      run: dotnet test tests/ErpBackEnd.UnitTests --no-build --verbosity normal --collect:"XPlat Code Coverage"
    
    - name: Run Integration Tests
      run: dotnet test tests/ErpBackEnd.IntegrationTests --no-build --verbosity normal --collect:"XPlat Code Coverage"
      env:
        ConnectionStrings__DefaultConnection: Server=localhost;Database=TestDb;User Id=sa;Password=YourStrong@Password;
        ConnectionStrings__Redis: localhost:6379
    
    - name: Generate Coverage Report
      run: |
        dotnet tool install --global dotnet-reportgenerator-globaltool
        reportgenerator -reports:**/coverage.cobertura.xml -targetdir:coverage -reporttypes:Html,Cobertura
    
    - name: Upload Coverage to Codecov
      uses: codecov/codecov-action@v3
      with:
        files: ./coverage/Cobertura.xml
        flags: unittests
        name: codecov-umbrella
    
    - name: Check Coverage Threshold
      run: |
        coverage=$(grep -oP 'line-rate="\K[^"]+' ./coverage/Cobertura.xml | head -1)
        threshold=0.80
        if (( $(echo "$coverage < $threshold" | bc -l) )); then
          echo "Coverage $coverage is below threshold $threshold"
          exit 1
        fi
```

## Testing Best Practices

### 1. Test Structure (AAA Pattern)
```csharp
[Fact]
public void TestMethod()
{
    // Arrange - Set up test data and dependencies
    var input = CreateTestInput();
    var expected = CreateExpectedOutput();
    
    // Act - Execute the method under test
    var actual = SystemUnderTest.Method(input);
    
    // Assert - Verify the outcome
    actual.Should().BeEquivalentTo(expected);
}
```

### 2. Test Isolation
- Each test must be independent
- No shared state between tests
- Use fresh test data for each test
- Clean up resources after tests

### 3. Test Data
- Use builders for complex objects
- Avoid magic numbers/strings
- Use meaningful test data
- Keep test data minimal

### 4. Assertions
- One logical assertion per test
- Use FluentAssertions for readability
- Test behavior, not implementation
- Include edge cases

### 5. Mocking Guidelines
- Mock external dependencies only
- Don't mock value objects
- Verify interactions when necessary
- Keep mocks simple

## Test Documentation

### Test Plan Template
```markdown
## Feature: [Feature Name]
### Test Scenarios:
1. **Happy Path**: [Description]
2. **Edge Cases**: [List of edge cases]
3. **Error Cases**: [List of error cases]
4. **Performance**: [Performance requirements]

### Test Data Requirements:
- [List of required test data]

### Dependencies:
- [List of external dependencies]

### Risks:
- [Potential risks and mitigation]
```

## Testing Metrics

### Coverage Reports
```xml
<!-- coverlet.runsettings -->
<?xml version="1.0" encoding="utf-8"?>
<RunSettings>
  <DataCollectionRunSettings>
    <DataCollectors>
      <DataCollector friendlyName="XPlat code coverage">
        <Configuration>
          <Format>cobertura,opencover</Format>
          <Exclude>[*.Tests]*,[xunit.*]*</Exclude>
          <ExcludeByAttribute>Obsolete,GeneratedCode,CompilerGenerated</ExcludeByAttribute>
          <SingleHit>false</SingleHit>
          <UseSourceLink>true</UseSourceLink>
          <IncludeTestAssembly>false</IncludeTestAssembly>
        </Configuration>
      </DataCollector>
    </DataCollectors>
  </DataCollectionRunSettings>
</RunSettings>
```

### Test Execution Report
| Module | Unit Tests | Integration Tests | E2E Tests | Coverage |
|--------|------------|-------------------|-----------|----------|
| Domain | 150 ✅ | - | - | 92% |
| Application | 120 ✅ | 45 ✅ | - | 87% |
| Infrastructure | 80 ✅ | 60 ✅ | - | 75% |
| API | 100 ✅ | 40 ✅ | 15 ✅ | 78% |
| **Total** | **450** | **145** | **15** | **83%** |