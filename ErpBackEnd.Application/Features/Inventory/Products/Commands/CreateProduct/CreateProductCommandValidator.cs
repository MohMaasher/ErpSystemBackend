using FluentValidation;

namespace ErpBackEnd.Application.Features.Inventory.Products.Commands.CreateProduct;

/// <summary>
/// Validator for CreateProductCommand
/// </summary>
public class CreateProductCommandValidator : AbstractValidator<CreateProductCommand>
{
    public CreateProductCommandValidator()
    {
        RuleFor(x => x.ItemNo)
            .NotEmpty().WithMessage("Item number is required")
            .MaximumLength(16).WithMessage("Item number cannot exceed 16 characters");

        RuleFor(x => x.NameEn)
            .NotEmpty().WithMessage("English name is required")
            .MaximumLength(45).WithMessage("English name cannot exceed 45 characters");

        RuleFor(x => x.NameAr)
            .NotEmpty().WithMessage("Arabic name is required")
            .MaximumLength(40).WithMessage("Arabic name cannot exceed 40 characters");

        RuleFor(x => x.MainGroup)
            .NotEmpty().WithMessage("Main group is required")
            .MaximumLength(2).WithMessage("Main group must be 2 characters");

        RuleFor(x => x.SubGroup)
            .NotEmpty().WithMessage("Sub group is required")
            .MaximumLength(2).WithMessage("Sub group must be 2 characters");

        RuleFor(x => x.Category)
            .NotEmpty().WithMessage("Category is required")
            .MaximumLength(2).WithMessage("Category must be 2 characters");

        RuleFor(x => x.ClassKey)
            .NotEmpty().WithMessage("Classification key is required")
            .MaximumLength(12).WithMessage("Classification key cannot exceed 12 characters");

        RuleFor(x => x.CompanyCode)
            .NotEmpty().WithMessage("Company code is required")
            .MaximumLength(2).WithMessage("Company code must be 2 characters");

        RuleFor(x => x.SupplierCode)
            .NotEmpty().WithMessage("Supplier code is required")
            .MaximumLength(19).WithMessage("Supplier code cannot exceed 19 characters");

        RuleFor(x => x.BrandId)
            .GreaterThan(0).WithMessage("Brand ID must be greater than 0");

        RuleFor(x => x.ItemType)
            .NotEmpty().WithMessage("Item type is required")
            .Must(x => new[] { "S", "N", "K", "V" }.Contains(x))
            .WithMessage("Item type must be one of: S (Stock), N (Non-Stock), K (Kit), V (Service)");

        When(x => !string.IsNullOrEmpty(x.ModelNo), () =>
        {
            RuleFor(x => x.ModelNo)
                .MaximumLength(16).WithMessage("Model number cannot exceed 16 characters");
        });
    }
}
