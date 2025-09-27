---
version: "1.0.0"
template_type: "init_missing_core_error"
description: "Template for missing core file error response"
created: "2025-01-23"
modified: "2025-01-23"
---

# Missing Core File Error Response

❌ Core instructions not found: Agents/Core/{core-type}-core.yaml

**Referenced by**: inherits_from field in project file
**Action required**: Ensure the core agent type is properly configured

## Template Variables

- `{core-type}` - The core type that was not found (e.g., "software-engineer-core")
