# Changelog

All notable changes to AgentStudio.AI Core will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.2-beta] - 2025-01-27

### Added

- Agents folder content inclusion in NuGet package
- All cognitive and domain agent templates now properly packaged

### Changed

- Updated package configuration to include `agents/**/*` content in NuGet package
- Improved YAML formatting across template files for better readability

### Fixed

- Resolved missing agents folder in NuGet package distribution
- Enhanced template consistency and maintainability

## [0.4.1-beta] - 2025-01-27

### Changed

- Improved YAML formatting across all cognitive thinking templates
- Converted long lines to use YAML literal block scalar (`|`) syntax for better readability
- Enhanced template consistency and maintainability

### Fixed

- Removed obsolete duplicate cognitive template files from `src/templates/agent/cognitive/`
- Cleaned up template directory structure
- Improved YAML linting compliance across all cognitive templates

## [0.4.0-beta] - 2025-09-28

### Added

- New `src/agents/` directory structure with improved organization
- 19 cognitive thinking templates in `src/agents/cognitive/`
- 12 domain-specific agent templates in `src/agents/domain/`
- Docker CLI shared-knowledge file with comprehensive command reference
- Enhanced template organization separating cognitive and domain patterns

### Changed

- Moved cognitive templates from `src/templates/agent/cognitive/` to `src/agents/cognitive/`
- Moved domain templates from `src/templates/agent/domain/` to `src/agents/domain/`
- Improved directory structure for better agent template organization
- Enhanced shared-knowledge system with Docker CLI integration

### Fixed

- Resolved YAML linting issues in shared-knowledge files
- Fixed line ending and document start marker issues
- Improved cross-platform compatibility for shared-knowledge files

## [0.3.1-beta] - 2025-09-27

### Added

- Shared-knowledge system for tool-specific AI agent guidance
- GitHub CLI shared-knowledge file with comprehensive command reference
- YAML linter shared-knowledge file with cross-platform validation
- Markdown linter shared-knowledge file with best practices
- Context management system for agent session state preservation

### Changed

- Enhanced package configuration to include shared-knowledge files
- Improved build process with better error handling
- Updated validation scripts for comprehensive file checking

### Fixed

- Resolved build validation errors in CI/CD pipeline
- Fixed YAML linting errors across template files
- Improved line length and formatting consistency

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

## [0.3.0-beta] - 2025-09-27

### Added

- **Shared-Knowledge System**: New framework for tool-specific AI agent knowledge
- **GitHub CLI Knowledge**: Comprehensive shared-knowledge file for GitHub CLI usage
- **Interactive Command Warnings**: Special handling for commands requiring user input
- **Cross-Platform Package Structure**: Enhanced NuGet package with shared-knowledge content

### Changed

- **Build System**: Major CI/CD pipeline improvements and stability fixes
- **Package Structure**: Added shared-knowledge directory to NuGet package content
- **Validation System**: Enhanced package validation for template-only structure

### Fixed

- **CI/CD Pipeline**: Resolved GitHub Actions build failures and validation issues
- **NuGet Package**: Fixed DLL inclusion issue - now properly excludes compiled assemblies
- **Cross-Platform Compatibility**: Fixed PackagePath separators for Linux/Windows compatibility
- **Validation Scripts**: Removed outdated checks for template-only package structure
- **Build Process**: Streamlined dotnet pack workflow for better reliability

## [0.3.1-beta] - 2025-09-27

### Added

- **Shared-Knowledge System**: New framework for tool-specific AI agent knowledge
- **GitHub CLI Knowledge**: Comprehensive shared-knowledge file for GitHub CLI usage
- **Interactive Command Warnings**: Special handling for commands requiring user input
- **Enhanced Package Structure**: Updated NuGet package to include shared-knowledge content

### Changed

- **README.md**: Comprehensive documentation overhaul with installation clarification, detailed project structure, shared-knowledge system section, updated roadmap, enhanced development setup, and improved VS Code extensions recommendations
- **Package Configuration**: Enhanced .csproj to include shared-knowledge files in NuGet package

### Fixed

- **Version Management**: Improved version update process with comprehensive file inclusion
- **Documentation**: Updated all version references consistently across project files
- **Repository Structure**: Removed empty tools/ directory and ensured project structure accuracy

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

- **0.3.1-beta** (2025-09-27): Shared-knowledge system implementation and documentation updates
- **0.3.0-beta** (2025-09-27): Shared-knowledge system, CI/CD improvements, and stability fixes
- **0.2.0-beta** (2025-09-27): .NET SDK integration, enhanced validation, and build improvements
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
