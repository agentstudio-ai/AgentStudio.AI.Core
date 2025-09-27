# Changelog

All notable changes to AgentStudio.AI Core will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.2.0-beta] - 2025-09-27

### Added

- .csproj file for reliable NuGet package building on Linux
- Comprehensive YAML linting and validation system
- Enhanced build scripts with .NET SDK integration
- Cursor command template for version and changelog management

### Changed

- Updated build process to use `dotnet pack` instead of `nuget pack`
- Improved validation scripts to handle missing linters gracefully
- Enhanced GitHub Actions workflow for better CI/CD reliability

### Fixed

- YAML line length issues across all cognitive templates
- YAML comment indentation warnings in agent-message templates
- Build script compatibility issues on Linux environments
- Validation script accuracy for package content verification

## [Unreleased]

### Added

- Initial project structure and documentation
- NuGet package specification and build system
- GitHub Actions CI/CD pipeline
- Contributing guidelines and development setup

### Changed

- N/A

### Deprecated

- N/A

### Removed

- N/A

### Fixed

- N/A

### Security

- N/A

## [0.1.0] - 2025-01-25

### Added

- Initial project setup for AgentStudio.AI Core
- Standard project structure (src/, tests/, docs/)
- NuGet package specification (`AgentStudio.AI.Core.nuspec`)
- PowerShell build script (`build.ps1`) for package creation
- Comprehensive README with project overview and features
- GitHub Actions CI/CD pipeline with validation, build, and release stages
- Contributing guidelines (`CONTRIBUTING.md`)
- Documentation structure and templates
- Version tracking system (`VERSION` file)
- Git tag for v0.1.0
- Logo and branding assets
- Platform-agnostic approach (no .csproj files)
- Semantic versioning strategy

### Changed

- N/A

### Deprecated

- N/A

### Removed

- N/A

### Fixed

- N/A

### Security

- N/A

---

## Version History

- **0.1.0** (2025-01-25): Initial beta release with project foundation
- **Unreleased**: Future features and improvements

## Contributing

When adding entries to this changelog, please follow these guidelines:

1. **Use the correct section** for your change type (Added, Changed, Deprecated, Removed, Fixed, Security)
2. **Use present tense** ("Add feature" not "Added feature")
3. **Use past tense** for version entries ("Added feature" not "Add feature")
4. **Group related changes** together
5. **Reference issues and pull requests** when applicable
6. **Keep entries concise** but descriptive
7. **Update the version history** section when creating new releases

## Links

- [Keep a Changelog](https://keepachangelog.com/en/1.0.0/)
- [Semantic Versioning](https://semver.org/spec/v2.0.0.html)
- [AgentStudio.AI Core Repository](https://github.com/agentstudio-ai/AgentStudio.AI.Core)
