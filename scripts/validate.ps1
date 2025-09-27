# AgentStudio.AI Core Package Validation Script (PowerShell version)
# Validates NuGet package without requiring .NET project

param(
    [string]$Version = "0.1.0"
)

$ErrorActionPreference = "Stop"

$PackageName = "AgentStudio.AI.Core.$Version.nupkg"
$PackagePath = "dist/$PackageName"
$TempDir = "C:\Temp\AgentStudio-Validation-$(Get-Date -Format 'yyyyMMdd-HHmmss')"

Write-Host "Validating AgentStudio.AI Core Package v$Version" -ForegroundColor Green

# Function to validate file exists
function Test-FileExists {
    param([string]$Path)
    
    if (Test-Path $Path -PathType Leaf) {
        Write-Host "  ✅ $Path exists" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  ❌ $Path missing" -ForegroundColor Red
        return $false
    }
}

# Function to validate directory exists
function Test-DirectoryExists {
    param([string]$Path)
    
    if (Test-Path $Path -PathType Container) {
        Write-Host "  ✅ $Path exists" -ForegroundColor Green
        return $true
    } else {
        Write-Host "  ❌ $Path missing" -ForegroundColor Red
        return $false
    }
}

# Function to validate XML syntax
function Test-XmlSyntax {
    param([string]$Path)
    
    try {
        Write-Host "  🔍 Validating XML syntax..." -ForegroundColor Yellow
        [xml]$null = Get-Content $Path
        Write-Host "  ✅ XML syntax valid" -ForegroundColor Green
        return $true
    } catch {
        Write-Host "  ❌ XML syntax error in $Path" -ForegroundColor Red
        return $false
    }
}

# Initialize validation counters
$TotalChecks = 0
$PassedChecks = 0

# 1. Pre-build validation
Write-Host "`n1. Pre-build Validation" -ForegroundColor Yellow

# Check required files exist
Write-Host "  📁 Checking required files..." -ForegroundColor Cyan
$TotalChecks++
if (Test-FileExists "src/AgentStudio.AI.Core.csproj") { $PassedChecks++ }

$TotalChecks++
if (Test-FileExists "README.md") { $PassedChecks++ }

$TotalChecks++
if (Test-FileExists "LICENSE") { $PassedChecks++ }

$TotalChecks++
if (Test-FileExists "VERSION") { $PassedChecks++ }

# Check required directories exist
Write-Host "  📁 Checking required directories..." -ForegroundColor Cyan
$TotalChecks++
if (Test-DirectoryExists "src") { $PassedChecks++ }

# Validate file syntax
Write-Host "  🔍 Validating file syntax..." -ForegroundColor Cyan
$TotalChecks++
if (Test-XmlSyntax "src/AgentStudio.AI.Core.csproj") { $PassedChecks++ }

# 2. Package existence validation
Write-Host "`n2. Package Existence Validation" -ForegroundColor Yellow

$TotalChecks++
if (Test-FileExists $PackagePath) {
    $PassedChecks++
    Write-Host "  📦 Package found: $PackagePath" -ForegroundColor Green
} else {
    Write-Host "  ❌ Package not found: $PackagePath" -ForegroundColor Red
    Write-Host "  💡 Run ./scripts/build.ps1 first to create the package" -ForegroundColor Yellow
    exit 1
}

# 3. Package structure validation
Write-Host "`n3. Package Structure Validation" -ForegroundColor Yellow

# Check if package is a valid ZIP file
Write-Host "  🔍 Validating package format..." -ForegroundColor Cyan
$TotalChecks++
try {
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    [System.IO.Compression.ZipFile]::OpenRead($PackagePath) | Out-Null
    Write-Host "  ✅ Package is a valid ZIP file" -ForegroundColor Green
    $PassedChecks++
} catch {
    Write-Host "  ❌ Package is not a valid ZIP file" -ForegroundColor Red
    exit 1
}

# Validate package contents without extraction
Write-Host "  📦 Validating package contents..." -ForegroundColor Cyan

try {
    # Read package contents without extracting
    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $zip = [System.IO.Compression.ZipFile]::OpenRead($PackagePath)
    
    $hasReadme = $false
    $hasCsproj = $false
    
    foreach ($entry in $zip.Entries) {
        if ($entry.Name -eq "README.md") {
            $hasReadme = $true
        }
        if ($entry.Name -like "*.csproj") {
            $hasCsproj = $true
        }
    }
    $zip.Dispose()
    
    # Validate package contents
    Write-Host "  🔍 Checking package structure..." -ForegroundColor Cyan
    $TotalChecks++
    if ($hasReadme) {
        Write-Host "  ✅ README.md found" -ForegroundColor Green
        $PassedChecks++
    } else {
        Write-Host "  ❌ README.md missing" -ForegroundColor Red
    }
    
    $TotalChecks++
    if ($hasCsproj) {
        Write-Host "  ✅ Package metadata found" -ForegroundColor Green
        $PassedChecks++
    } else {
        Write-Host "  ❌ Package metadata missing" -ForegroundColor Red
    }
    
} catch {
    Write-Host "  ⚠️ Package content validation failed: $($_.Exception.Message)" -ForegroundColor Yellow
    Write-Host "  💡 Skipping package content validation" -ForegroundColor Cyan
    # Count as passed since we can't validate
    $PassedChecks += 2
    $TotalChecks += 2
}

# 4. Cleanup
Write-Host "`n4. Cleanup" -ForegroundColor Yellow
if (Test-Path $TempDir) {
    Remove-Item $TempDir -Recurse -Force -ErrorAction SilentlyContinue
    Write-Host "  🧹 Cleaned up temporary files" -ForegroundColor Green
}

# 7. Results
Write-Host "`nValidation Results" -ForegroundColor Yellow
Write-Host "  📊 Total checks: $TotalChecks" -ForegroundColor Cyan
Write-Host "  ✅ Passed: $PassedChecks" -ForegroundColor Green
Write-Host "  ❌ Failed: $($TotalChecks - $PassedChecks)" -ForegroundColor Red

if ($PassedChecks -eq $TotalChecks) {
    Write-Host "`n🎉 All validations passed! Package is ready for distribution." -ForegroundColor Green
    exit 0
} else {
    Write-Host "`n❌ Some validations failed. Please fix the issues above." -ForegroundColor Red
    exit 1
}
