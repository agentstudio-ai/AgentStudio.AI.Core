# AgentStudio.AI Core Build Script
# Builds NuGet package from source files

param(
    [string]$Version = "0.1.0",
    [string]$OutputDir = "dist"
)

Write-Host "Building AgentStudio.AI Core v$Version" -ForegroundColor Green

# Create output directory
if (Test-Path $OutputDir) {
    Remove-Item $OutputDir -Recurse -Force
}
New-Item -ItemType Directory -Path $OutputDir

# Copy source files to package structure
$packageDir = Join-Path $OutputDir "AgentStudio.AI.Core.$Version"
New-Item -ItemType Directory -Path $packageDir

# Copy templates, workflows, etc. from .agentstudio-ai to src
Write-Host "Copying framework files..." -ForegroundColor Yellow

# Create content directories
$contentDir = Join-Path $packageDir "content"
New-Item -ItemType Directory -Path $contentDir

# Copy framework files from src/ (when they're ready)
if (Test-Path "src/templates") {
    Write-Host "Framework files found in src/, copying..." -ForegroundColor Yellow
    # Copy templates
    Copy-Item "src/templates" -Destination "$contentDir/templates" -Recurse
}
if (Test-Path "src/workflows") {
    # Copy workflows
    Copy-Item "src/workflows" -Destination "$contentDir/workflows" -Recurse
}
if (Test-Path "src/shared_knowledge") {
    # Copy shared knowledge
    Copy-Item "src/shared_knowledge" -Destination "$contentDir/shared_knowledge" -Recurse
}
if (Test-Path "src/agents") {
    # Copy agents
    Copy-Item "src/agents" -Destination "$contentDir/agents" -Recurse
}

# Create placeholder structure if src/ doesn't have framework files yet
if (-not (Test-Path "src/templates") -and -not (Test-Path "src/workflows") -and -not (Test-Path "src/shared_knowledge") -and -not (Test-Path "src/agents")) {
    Write-Host "Framework files not found in src/, creating placeholder structure..." -ForegroundColor Yellow
    # Create placeholder directories
    New-Item -ItemType Directory -Path "$contentDir/templates"
    New-Item -ItemType Directory -Path "$contentDir/workflows"
    New-Item -ItemType Directory -Path "$contentDir/shared_knowledge"
    New-Item -ItemType Directory -Path "$contentDir/agents"

    # Create placeholder files
    Set-Content -Path "$contentDir/templates/README.md" -Value "# Templates`n`nTemplates will be added here.`n"
    Set-Content -Path "$contentDir/workflows/README.md" -Value "# Workflows`n`nWorkflows will be added here.`n"
    Set-Content -Path "$contentDir/shared_knowledge/README.md" -Value "# Shared Knowledge`n`nShared knowledge will be added here.`n"
    Set-Content -Path "$contentDir/agents/README.md" -Value "# Agents`n`nAgent definitions will be added here.`n"
}

# Copy package files
Copy-Item "README.md" -Destination "$contentDir/README.md"
Copy-Item "LICENSE" -Destination "$contentDir/LICENSE"

# Update version in csproj
$csprojContent = Get-Content "src/AgentStudio.AI.Core.csproj" -Raw
$csprojContent = $csprojContent -replace '<Version>0\.2\.0-beta</Version>', "<Version>$Version</Version>"
Set-Content -Path "src/AgentStudio.AI.Core.csproj" -Value $csprojContent

# Build NuGet package
Write-Host "Building NuGet package..." -ForegroundColor Yellow

# Check for .NET SDK (required for dotnet pack)
if (-not (Get-Command dotnet -ErrorAction SilentlyContinue)) {
    Write-Host "❌ .NET SDK not found. Please install .NET 8.0 SDK or later." -ForegroundColor Red
    exit 1
}

$dotnetVersion = dotnet --version
Write-Host "✅ .NET SDK found: $dotnetVersion" -ForegroundColor Green

# Build NuGet package using dotnet pack
Write-Host "Using dotnet pack to build package from 'AgentStudio.AI.Core.csproj'." -ForegroundColor Cyan
dotnet pack "src/AgentStudio.AI.Core.csproj" -c Release -o $OutputDir --no-build

Write-Host "Build complete! Package created in $OutputDir" -ForegroundColor Green
Write-Host "Package: AgentStudio.AI.Core.$Version.nupkg" -ForegroundColor Cyan
