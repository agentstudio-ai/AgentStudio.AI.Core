# AgentStudio.AI Core Build and Validate Script (PowerShell version)
# Builds NuGet package and then validates it

$ErrorActionPreference = "Stop"

Write-Host "🚀 Starting AgentStudio.AI Core Build and Validate Process" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green

try {
    # Run build script
    Write-Host "📦 Building package..." -ForegroundColor Yellow
    & "./scripts/build.ps1"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Build completed successfully!" -ForegroundColor Green
        Write-Host ""
        
        # Run validation script
        Write-Host "🔍 Validating package..." -ForegroundColor Yellow
        & "./scripts/validate.ps1"
        
        if ($LASTEXITCODE -eq 0) {
            Write-Host ""
            Write-Host "🎉 Build and validation completed successfully!" -ForegroundColor Green
            Write-Host "📦 Package is ready for distribution." -ForegroundColor Cyan
            exit 0
        } else {
            Write-Host ""
            Write-Host "❌ Validation failed. Please fix the issues above." -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host ""
        Write-Host "❌ Build failed. Please fix the build issues first." -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host ""
    Write-Host "❌ Error during build or validation process: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
