# AgentStudio.AI Core

![AgentStudio.AI Logo](images/logo-all-small.png)

## Human-Centric AI Agent Orchestration Framework

[![Version](https://img.shields.io/badge/version-0.1.0--beta-blue.svg)](https://github.com/agentstudio-ai)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)
[![NuGet](https://img.shields.io/badge/nuget-AgentStudio.AI.Core-blue.svg)](https://github.com/agentstudio-ai)

## Overview

AgentStudio.AI Core is the foundational framework for building human-centric AI agent orchestration systems. It provides cognitive templates, workflow patterns, and agent definitions that enable developers to create AI agents that work collaboratively with humans rather than replacing them.

## Key Features

- **Cognitive Templates**: 19+ thinking patterns for different agent behaviors
- **Workflow Orchestration**: Pre-defined patterns for multi-agent collaboration
- **Human-Centric Design**: Built-in human checkpoints and collaboration patterns
- **Template-Based**: YAML-based configuration for easy customization
- **Platform Agnostic**: Works across different AI platforms and frameworks

## Quick Start

### Installation

```bash
dotnet add package AgentStudio.AI.Core
```

### Basic Usage

```yaml
# Example agent configuration
version: "1.0.0"
agent_name: "MyAgent"
cognitive_template: "analytical-thinking"
domain: "software-development"
```

## Project Structure

```text
AgentStudio.AI.Core/
├── src/                    # Source files and package configuration
├── docs/                   # Documentation
├── scripts/                # Build and utility scripts
├── images/                 # Logo and assets
├── .github/               # GitHub workflows and configuration
├── VERSION                # Version tracking
└── README.md              # This file
```

## Cognitive Templates

The framework includes 19 cognitive thinking patterns:

- **Analytical Thinking** - Systematic problem decomposition
- **Creative Problem Solving** - Innovative solution generation
- **Design Thinking** - Human-centered problem solving
- **Systems Thinking** - Holistic, interconnected analysis
- **Agile Thinking** - Iterative, collaborative development
- **And 14 more...**

## Workflow Patterns

Pre-defined workflow patterns for common scenarios:

- **Linear Workflows** - Sequential task execution
- **Iterative Workflows** - Loop-based collaboration
- **Human Checkpoint Workflows** - Human approval gates
- **Hybrid Workflows** - Complex multi-pattern orchestration

## Development Status

**Current Version**: 0.1.0 (Beta)

This is an early beta release. The framework is under active development and the API may change between versions.

### Roadmap

- [ ] Complete cognitive template library (19 templates)
- [ ] Basic domain-specific templates (.NET, Python, Java, React, etc.)
- [ ] Base workflow pattern templates
- [ ] Template validation and testing framework
- [ ] Documentation and examples for all templates
- [ ] Templates for agent-messages, shared-knowledge, and events
- [ ] Refinement and inclusion of JARVIS (AI/Prompt Expert)

## Contributing

We welcome contributions! Please see our [Contributing Guidelines](CONTRIBUTING.md) for details.

### Development Setup

1. Clone the repository
2. Review the framework files in `src/`
3. Test changes using the build script: `./scripts/build.ps1`
4. Submit a pull request

## Changelog

See [CHANGELOG.md](CHANGELOG.md) for a detailed list of changes, new features, and bug fixes in each version.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## Related Projects

- [AgentStudio.AI.CLI](https://github.com/agentstudio-ai) - Command-line interface
- [AgentStudio.AI.Agents](https://github.com/agentstudio-ai) - Pre-built agent templates
- [AgentStudio.AI.Workflows](https://github.com/agentstudio-ai) - Workflow patterns

## Development

### Recommended VS Code Extensions

For contributors working with this codebase, we recommend installing these VS Code extensions:

- **XML** (Red Hat) - For `.nuspec` file validation and IntelliSense
- **YAML** (Red Hat) - For template file validation and formatting
- **Prettier** - For consistent code formatting across all file types
- **markdownlint** - For README and documentation validation

These extensions ensure consistent formatting and catch syntax errors early in the development process.

## Support

- 📖 [Documentation](docs/)
- 🐛 [Issue Tracker](https://github.com/agentstudio-ai/AgentStudio.AI.Core/issues)
- 💬 [Discussions](https://github.com/agentstudio-ai/AgentStudio.AI.Core/discussions)

---

## Built with ❤️ by the AgentStudio.AI team
