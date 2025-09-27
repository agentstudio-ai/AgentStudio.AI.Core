# Contributing to AgentStudio.AI Core

Thank you for your interest in contributing to AgentStudio.AI Core! This document provides guidelines and information for contributors.

## Development Setup

### Prerequisites

- Git
- PowerShell (for build scripts)
- NuGet CLI (for package building)

### Getting Started

1. **Fork and Clone**

   ```bash
   git clone https://github.com/your-username/AgentStudio.AI.Core.git
   cd AgentStudio.AI.Core
   ```

2. **Create a Development Branch**

   ```bash
   git checkout -b feature/your-feature-name
   ```

3. **Review Framework Files**
   - Framework files are in `.agentstudio-ai/` (hidden from git)
   - Review existing templates and patterns
   - Understand the cognitive template structure

## Contribution Areas

### 1. Cognitive Templates

- **Location**: `.agentstudio-ai/templates/agent/cognitive/`
- **Format**: YAML files with specific structure
- **Requirements**: Pure thinking patterns, no domain-specific content

### 2. Workflow Patterns

- **Location**: `.agentstudio-ai/templates/workflows/`
- **Format**: YAML workflow definitions
- **Requirements**: Reusable, well-documented patterns

### 3. Domain Templates

- **Location**: `.agentstudio-ai/templates/agent/domain/`
- **Format**: YAML files with domain-specific best practices
- **Requirements**: Technical domain expertise, best practices

### 4. Documentation

- **Location**: `docs/`
- **Format**: Markdown files
- **Requirements**: Clear, comprehensive, up-to-date

## Development Workflow

### 1. Making Changes

1. **Work in Development Branch**

   - Never work directly on `main`
   - Create feature branches for each change

2. **Test Your Changes**

   ```powershell
   # Windows
   ./scripts/build.ps1

   # Linux/macOS
   ./scripts/build.sh
   ```

3. **Update Documentation**
   - Update relevant documentation
   - Add examples if applicable
   - Update version information if needed

### 2. Code Standards

#### YAML Templates

- Use consistent indentation (2 spaces)
- Include all required sections
- Use placeholder variables for customization
- Add comprehensive comments

#### Documentation

- Use clear, concise language
- Include examples where helpful
- Follow existing structure and style
- Update table of contents if needed

### 3. Testing

- **Template Validation**: Ensure YAML structure is valid
- **Content Review**: Check for completeness and accuracy
- **Build Testing**: Verify package builds correctly
- **Cross-Platform**: Test on different operating systems

### 4. Changelog Updates

- **Update CHANGELOG.md**: Add entries for all changes
- **Follow Format**: Use standard changelog format
- **Version Entries**: Update version history section
- **Unreleased Section**: Add changes to Unreleased section

## Pull Request Process

### 1. Before Submitting

- [ ] Code follows project standards
- [ ] Documentation is updated
- [ ] Tests pass (when implemented)
- [ ] Build script runs successfully
- [ ] Version information is updated if needed
- [ ] Changelog is updated with changes

### 2. Pull Request Template

```markdown
## Description

Brief description of changes

## Type of Change

- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Template addition/modification
- [ ] Other (please describe)

## Testing

- [ ] Build script runs successfully
- [ ] Templates validate correctly
- [ ] Documentation is updated
- [ ] Cross-platform testing (if applicable)
- [ ] Changelog updated with changes

## Checklist

- [ ] Code follows project standards
- [ ] Self-review completed
- [ ] Documentation updated
- [ ] Version updated (if applicable)
- [ ] Changelog updated with changes
```

### 3. Review Process

1. **Automated Checks**: Build and validation
2. **Code Review**: Maintainer review
3. **Testing**: Additional testing if needed
4. **Approval**: Maintainer approval required

## Version Management

### Versioning Strategy

- **Semantic Versioning**: MAJOR.MINOR.PATCH
- **Beta Versions**: 0.x.x for beta releases
- **Version File**: Update `VERSION` file
- **Git Tags**: Tag releases for tracking

### Release Process

1. Update version in `VERSION` file
2. Update version in `src/AgentStudio.AI.Core.nuspec`
3. Update documentation
4. Update `CHANGELOG.md` with release notes
5. Create git tag
6. Build and test package
7. Release to NuGet

## Guidelines

### Cognitive Templates

- **Pure Patterns**: No domain-specific content
- **Comprehensive**: Include all required sections
- **Reusable**: Can be combined with domain templates
- **Well-Documented**: Clear comments and examples

### Workflow Patterns

- **Reusable**: Work across different domains
- **Well-Defined**: Clear structure and purpose
- **Documented**: Include usage examples
- **Tested**: Validate with real scenarios

### Documentation

- **Clear**: Easy to understand
- **Complete**: Cover all aspects
- **Current**: Keep up-to-date
- **Examples**: Include practical examples

## Getting Help

### Resources

- **Documentation**: Check `docs/` directory
- **Issues**: Search existing issues
- **Discussions**: Use GitHub Discussions
- **Templates**: Review existing templates

### Contact

- **Issues**: GitHub Issues for bugs and feature requests
- **Discussions**: GitHub Discussions for questions
- **Email**: Contact maintainers for sensitive issues

## Recognition

Contributors will be recognized in:

- **README**: Contributor list
- **Release Notes**: Feature acknowledgments
- **Documentation**: Credit for significant contributions

## License

By contributing, you agree that your contributions will be licensed under the MIT License.

---

Thank you for contributing to AgentStudio.AI Core! 🚀
