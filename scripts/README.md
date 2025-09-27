# Scripts

This directory contains build and utility scripts for AgentStudio.AI Core.

## Available Scripts

### Build Scripts

- **`build.ps1`** - PowerShell build script for Windows
- **`build.sh`** - Bash build script for Linux/macOS

Both scripts perform the same function:
- Copy framework files from `.agentstudio-ai/` to package structure
- Create NuGet package using the `.nuspec` file
- Output package to `dist/` directory

### Usage

**Windows (PowerShell):**
```powershell
./scripts/build.ps1
```

**Linux/macOS (Bash):**
```bash
./scripts/build.sh
```

### Parameters

Both scripts support the same parameters:
- `-Version` / `--version`: Specify version (default: 0.1.0)
- `-OutputDir` / `--output-dir`: Specify output directory (default: dist)

### Requirements

- **NuGet CLI**: Required for package creation
- **Framework Files**: `.agentstudio-ai/` directory with templates and workflows
- **Package Spec**: `src/AgentStudio.AI.Core.nuspec` file

## Future Scripts

Additional utility scripts may be added:
- Validation scripts for templates and workflows
- Testing scripts for package verification
- Deployment scripts for publishing to NuGet
- Development setup scripts for contributors
