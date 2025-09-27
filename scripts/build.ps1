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

# Update version in nuspec
$nuspecContent = Get-Content "src/AgentStudio.AI.Core.nuspec" -Raw
$nuspecContent = $nuspecContent -replace '<version>0\.1\.0</version>', "<version>$Version</version>"
Set-Content -Path "src/AgentStudio.AI.Core.nuspec" -Value $nuspecContent

# Build NuGet package
Write-Host "Building NuGet package..." -ForegroundColor Yellow

# Check for NuGet CLI and install if needed
$NuGetCmd = ""
if (Get-Command nuget -ErrorAction SilentlyContinue) {
    $NuGetCmd = "nuget"
} else {
    Write-Host "NuGet CLI not found. Installing NuGet.CommandLine package..." -ForegroundColor Yellow
    
    # Create tools directory if it doesn't exist
    if (-not (Test-Path "tools")) {
        New-Item -ItemType Directory -Path "tools" | Out-Null
    }
    
    # Install NuGet.CommandLine package
    if (-not (Test-Path "tools/NuGet.CommandLine")) {
        Write-Host "Installing NuGet.CommandLine package..." -ForegroundColor Cyan
        
        # Try different package managers
        if (Get-Command dotnet -ErrorAction SilentlyContinue) {
            # Use dotnet to install the package
            dotnet tool install --tool-path tools NuGet.CommandLine
        } elseif (Get-Command nuget -ErrorAction SilentlyContinue) {
            # Use existing nuget to install the package
            nuget install NuGet.CommandLine -OutputDirectory tools
        } else {
            # Download and install manually
            Write-Host "Downloading NuGet.CommandLine package..." -ForegroundColor Cyan
            Invoke-WebRequest -Uri "https://api.nuget.org/v3-flatcontainer/nuget.commandline/6.8.0/nuget.commandline.6.8.0.nupkg" -OutFile "tools/nuget-commandline.zip"
            Expand-Archive -Path "tools/nuget-commandline.zip" -DestinationPath "tools" -Force
            Remove-Item "tools/nuget-commandline.zip"
        }
    }
    
    # Set the NuGet command path
    if (Test-Path "tools/NuGet.CommandLine/tools/nuget.exe") {
        $NuGetCmd = "tools/NuGet.CommandLine/tools/nuget.exe"
    } elseif (Test-Path "tools/nuget.exe") {
        $NuGetCmd = "tools/nuget.exe"
    } else {
        Write-Host "Error: Failed to install NuGet.CommandLine package" -ForegroundColor Red
        exit 1
    }
}

# Build NuGet package
Write-Host "Using NuGet command: $NuGetCmd" -ForegroundColor Cyan
& $NuGetCmd pack "src/AgentStudio.AI.Core.nuspec" -OutputDirectory $OutputDir -Version $Version

Write-Host "Build complete! Package created in $OutputDir" -ForegroundColor Green
Write-Host "Package: AgentStudio.AI.Core.$Version.nupkg" -ForegroundColor Cyan
