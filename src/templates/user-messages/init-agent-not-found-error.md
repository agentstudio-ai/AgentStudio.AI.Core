---
version: "1.0.0"
template_type: "init_agent_not_found_error"
description: "Template for agent not found error response"
created: "2025-01-23"
modified: "2025-01-23"
---

# Agent Not Found Error Response

❌ Agent "{agent-name}" not found in framework

**Available agents**: {available-agents}

**Usage**: `!init {agent-name}` where agent-name matches a file in `Agents/Project/`

## Template Variables

- `{agent-name}` - The agent name that was not found
- `{available-agents}` - Comma-separated list of available agents
