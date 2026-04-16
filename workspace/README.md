# Workspace

> **Scaffolding file.** Delete this README once your agents are running.

This is the orchestration repo. It holds all agent state, commands, rules, and configuration. Everything an agent needs to pick up where the last session left off lives here.

## What's in here

```
workspace/
├── .cursor/              Cursor integration (rules, commands, subagents, skills)
├── agents/               Agent folders (identity, relay, tasks, messages, learnings, sessions)
│   ├── architect/        System agent: reads code, writes specs
│   ├── operator/         System agent: PM, decomposes specs into tasks
│   ├── librarian/        System agent: owns documentation
│   └── reviewer/         System agent: black-box product testing
├── templates/            Agent templates for recruiting new product agents
├── CLAUDE.md             Claude Code instructions (symlinked from project root)
├── ROSTER.md             Single source of truth for all agents and their status
├── .mcp.json             MCP server configuration (symlinked from project root)
└── .gitignore
```

## Why a separate repo?

The workspace repo is separate from your product repos. Agents commit their state here (relay, learnings, session logs) independently of product code. This keeps orchestration history clean and avoids polluting product git logs with agent bookkeeping.

## Setup

Run `setup.sh` from the project root to create symlinks and agent folder structures. Then `employ operator` to start your first session.
