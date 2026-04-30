# Project

> Project-specific context for every agent in this workspace. Generic Relay protocol lives in `CLAUDE.md`. Anything that is true here but would not be true in another Relay project belongs in this file. Every agent reads it at `employ` right after `PRINCIPAL.md`. Apply it as a global filter alongside PRINCIPAL.

## Identity
- **Name:** {project name}
- **Description:** {one or two sentences describing what this project is and who it serves}
- **Status:** {planning / active development / production / maintenance}

## Surfaces

The user-facing or developer-facing surfaces this project ships, and where each one's code lives. Typical shape: `api`, `app`, `sdk`, `manager`, `website`, `documentation`. List the folder under the project root and a brief description.

- `{path}` — {what it is}

## Repos

Each git repo this project owns, including the workspace repo itself. List the remote URL and which agent owns code changes.

| Folder | Remote | Owner agent |
|---|---|---|
| `workspace/` | {url} | (shared, framework only) |
| `{folder}/` | {url} | `{callsign}` |

## Build Order

If surfaces depend on each other, capture the order so agents know what to build, test, and deploy first. Example: `sdk → app`, `api` standalone, `website` independent.

- {dependency or "no inter-surface dependencies"}

## MCPs

MCPs this project's agents rely on. The actual MCP config lives in `.mcp.json`; this section is the human-readable context: what each MCP is for and which agents use it.

- `{name}`: {purpose, used by which agents}

## Conventions

Anything specific to how this project does things that an agent dropped fresh into the workspace would not otherwise know. Examples: callsign aliases, deploy paths that diverge from the framework default, tooling choices, naming rules.

- {convention}
