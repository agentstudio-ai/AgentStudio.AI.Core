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

# Copy framework files (when they're ready)
if (Test-Path ".agentstudio-ai") {
    Write-Host "Framework files found, copying..." -ForegroundColor Yellow
    # Copy templates
    if (Test-Path ".agentstudio-ai/templates") {
        Copy-Item ".agentstudio-ai/templates" -Destination "$contentDir/templates" -Recurse
    }
    # Copy workflows
    if (Test-Path ".agentstudio-ai/workflows") {
        Copy-Item ".agentstudio-ai/workflows" -Destination "$contentDir/workflows" -Recurse
    }
    # Copy shared knowledge
    if (Test-Path ".agentstudio-ai/shared_knowledge") {
        Copy-Item ".agentstudio-ai/shared_knowledge" -Destination "$contentDir/shared_knowledge" -Recurse
    }
    # Copy agents
    if (Test-Path ".agentstudio-ai/agents") {
        Copy-Item ".agentstudio-ai/agents" -Destination "$contentDir/agents" -Recurse
    }
} else {
    Write-Host "Framework files not found, creating placeholder structure..." -ForegroundColor Yellow
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

# Update version in nuspec
$nuspecContent = Get-Content "src/AgentStudio.AI.Core.nuspec" -Raw
$nuspecContent = $nuspecContent -replace '<version>0\.1\.0</version>', "<version>$Version</version>"
Set-Content -Path "src/AgentStudio.AI.Core.nuspec" -Value $nuspecContent

# Build NuGet package
Write-Host "Building NuGet package..." -ForegroundColor Yellow
dotnet nuget pack "src/AgentStudio.AI.Core.nuspec" -OutputDirectory $OutputDir -Version $Version

Write-Host "Build complete! Package created in $OutputDir" -ForegroundColor Green
Write-Host "Package: AgentStudio.AI.Core.$Version.nupkg" -ForegroundColor Cyan
