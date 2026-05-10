# Workspace

> **Scaffolding file. Delete once your agents are running.**

Orchestration repo. Holds all agent state, commands, rules, configuration. Everything an agent needs to pick up where the last session left off.

## What's in here

```
workspace/
├── .cursor/              Cursor integration (rules, commands, subagents, skills)
├── agents/               Agent folders (identity, relay, tasks, messages, learnings, sessions)
│   ├── architect/        System: reads code, writes specs
│   ├── operator/         System: PM, decomposes specs into tasks
│   ├── librarian/        System: owns documentation
│   └── reviewer/         System: black-box product testing
├── templates/            Agent templates for recruiting product agents
├── CLAUDE.md             Generic Relay framework (symlinked from project root)
├── PRINCIPAL.md          Human's preferences, style, context
├── PROJECT.md            Project-specific context
├── ROSTER.md             All agents + status
├── CHANGELOG.md          Framework changes (Curator-maintained)
├── .mcp.json             MCP config (symlinked from project root)
└── .gitignore
```

## Why a separate repo?

Workspace is separate from product repos. Agents commit state here (relay, learnings, session logs) independently of product code. Keeps orchestration history clean. Product git logs stay free of agent bookkeeping.

## Setup

Run `setup.sh` from project root to create symlinks + agent folder structure. Then `/employ operator` to start.
