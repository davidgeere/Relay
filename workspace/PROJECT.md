# Project

> Project-specific context. Generic Relay protocol lives in `CLAUDE.md`. Anything true here that wouldn't be true in another Relay project belongs here. Every agent reads at `employ` after `PRINCIPAL.md`. Global filter alongside PRINCIPAL.

## Identity

- **Name:** {project name}
- **Description:** {one or two sentences — what this project is, who it serves}
- **Status:** {planning / active development / production / maintenance}

## Surfaces

User-facing or developer-facing surfaces and where each one's code lives. Typical: `api`, `app`, `sdk`, `manager`, `website`, `documentation`.

- `{path}` — {what it is}

## Repos

Each git repo this project owns, including workspace itself.

| Folder | Remote | Owner agent |
|---|---|---|
| `workspace/` | {url} | (shared, framework only) |
| `{folder}/` | {url} | `{callsign}` |

## Build Order

Inter-surface dependencies so agents know what to build, test, deploy first. Example: `sdk → app`, `api` standalone, `website` independent.

- {dependency or "no inter-surface dependencies"}

## MCPs

MCPs agents rely on. Config lives in `.mcp.json`; this section is human-readable: purpose + which agents.

- `{name}`: {purpose, used by which agents}

## Conventions

Anything specific to how this project works that a fresh agent wouldn't otherwise know. Examples: callsign aliases, deploy paths diverging from framework default, tooling choices, naming rules.

- {convention}
