# AgentStudio.AI Core Full Build and Test Script (PowerShell version)
# Cleans up, builds NuGet package, and validates it

$ErrorActionPreference = "Stop"

Write-Host "🚀 Starting AgentStudio.AI Core Full Build and Test Process" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green

try {
    # Run cleanup script
    Write-Host "🧹 Cleaning up previous build artifacts..." -ForegroundColor Yellow
    & "./scripts/cleanup.ps1"
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host ""
        Write-Host "✅ Cleanup completed successfully!" -ForegroundColor Green
        Write-Host ""
        
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
                Write-Host "🎉 Full build and test completed successfully!" -ForegroundColor Green
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
    } else {
        Write-Host ""
        Write-Host "❌ Cleanup failed. Please check the cleanup script." -ForegroundColor Red
        exit 1
    }
} catch {
    Write-Host ""
    Write-Host "❌ Error during cleanup, build, or validation process: $($_.Exception.Message)" -ForegroundColor Red
    exit 1
}
