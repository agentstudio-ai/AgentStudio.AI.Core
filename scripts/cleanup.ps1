# AgentStudio.AI Core Cleanup Script (PowerShell version)
# Removes build output and temporary validation files

Write-Host "🧹 Cleaning up AgentStudio.AI Core build artifacts" -ForegroundColor Green
Write-Host "==================================================" -ForegroundColor Green

# Clean up dist/ folder
if (Test-Path "dist") {
    Write-Host "📦 Removing dist/ folder..." -ForegroundColor Yellow
    Remove-Item "dist" -Recurse -Force
    Write-Host "  ✅ dist/ folder removed" -ForegroundColor Green
} else {
    Write-Host "  ℹ️  dist/ folder not found" -ForegroundColor Cyan
}

# Clean up temp-validation/ folder
if (Test-Path "temp-validation") {
    Write-Host "🔍 Removing temp-validation/ folder..." -ForegroundColor Yellow
    Remove-Item "temp-validation" -Recurse -Force
    Write-Host "  ✅ temp-validation/ folder removed" -ForegroundColor Green
} else {
    Write-Host "  ℹ️  temp-validation/ folder not found" -ForegroundColor Cyan
}

Write-Host ""
Write-Host "🎉 Cleanup completed successfully!" -ForegroundColor Green
Write-Host "All build artifacts and temporary files have been removed." -ForegroundColor Cyan

exit 0
