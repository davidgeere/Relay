#!/bin/bash
# Relay Setup Script
# Creates the full workspace structure for a new Relay installation.
# Run this from inside the workspace/ directory.

set -e

echo "Setting up Relay workspace..."

# System agents (always included)
SYSTEM_AGENTS="architect operator librarian reviewer"

# Agent folder structure
create_agent() {
  local callsign=$1
  local agent_dir="agents/$callsign"
  
  mkdir -p "$agent_dir/Learnings"
  mkdir -p "$agent_dir/Messages/Inbox"
  mkdir -p "$agent_dir/Messages/Archive"
  mkdir -p "$agent_dir/Tasks/Todo"
  mkdir -p "$agent_dir/Tasks/Doing"
  mkdir -p "$agent_dir/Tasks/Done"
  mkdir -p "$agent_dir/Skills"
  mkdir -p "$agent_dir/Sessions"
  
  # Add .gitkeep to empty directories
  for dir in Messages/Inbox Messages/Archive Tasks/Todo Tasks/Doing Tasks/Done Skills Sessions; do
    touch "$agent_dir/$dir/.gitkeep"
  done
  
  # Create INDEX.md if it doesn't exist
  if [ ! -f "$agent_dir/Learnings/INDEX.md" ]; then
    cat > "$agent_dir/Learnings/INDEX.md" << 'EOF'
# Learnings Index

> Auto-generated from source files. Do not hand-edit.

No learnings yet.
EOF
  fi
  
  # Create RELAY.md if it doesn't exist
  if [ ! -f "$agent_dir/RELAY.md" ]; then
    cat > "$agent_dir/RELAY.md" << 'EOF'
# Relay
> Last updated: system bootstrap

## Current Situation
Fresh agent. No prior sessions.

## Recent Changes
- Agent system installed. First session pending.

## Open Threads
- None

## Priorities
1. Orient to project
2. Verify tooling works

## Warnings
- None yet.
EOF
  fi
  
  echo "  ✓ $callsign"
}

# Create system agent folders
echo ""
echo "Creating system agents..."
for agent in $SYSTEM_AGENTS; do
  create_agent "$agent"
done

# Create principal comms folder (minimal — no AGENT.md, no RELAY.md, no Sessions/Learnings)
echo ""
echo "Creating principal comms folder..."
mkdir -p agents/principal/Messages/Inbox
mkdir -p agents/principal/Messages/Archive
mkdir -p agents/principal/Tasks/Todo
mkdir -p agents/principal/Tasks/Doing
mkdir -p agents/principal/Tasks/Done
for dir in Messages/Inbox Messages/Archive Tasks/Todo Tasks/Doing Tasks/Done; do
  touch "agents/principal/$dir/.gitkeep"
done
echo "  ✓ principal (Messages + Tasks only — no employ)"

# Seed PRINCIPAL.md if it doesn't exist (template ships with the repo;
# this is a no-op for the canonical install but useful if PRINCIPAL.md
# was deleted or this is a fresh workspace folder)
if [ ! -f "PRINCIPAL.md" ]; then
  cat > "PRINCIPAL.md" << 'EOF'
# Principal

> The human directing this Relay system. Every agent reads this file at `employ` time, right after their own `AGENT.md`. Update organically — when the principal corrects an agent ("no, I don't want emojis in commits"), the agent adds a line here and captures the change as a learning.

## Identity
- **Name:** {your name}
- **Time zone:** {e.g. America/Vancouver}
- **Working hours:** {e.g. 9am–6pm weekdays}

## Communication Style
- {e.g. Direct, no preamble}

## Code Style Preferences
- {e.g. yarn over npm}

## Project Context
- {side project / production / client work}

## Pet Peeves
- {things you don't want agents doing}

## Recurring Context
- {anything that comes up often enough that re-explaining wastes time}
EOF
  echo "  ✓ PRINCIPAL.md seeded (edit it before your first session)"
fi

# Seed PROJECT.md if it doesn't exist (project-specific overlay; CLAUDE.md
# is the generic framework, PROJECT.md is what makes this project this
# project — surfaces, repos, build order, MCPs, conventions)
if [ ! -f "PROJECT.md" ]; then
  cat > "PROJECT.md" << 'EOF'
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
EOF
  echo "  ✓ PROJECT.md seeded (edit it before your first session)"
fi

# Create documentation directory (if at project root level)
if [ ! -d "../documentation" ]; then
  mkdir -p "../documentation/specs"
  touch "../documentation/specs/.gitkeep"
  
  if [ ! -f "../documentation/README.md" ]; then
    cat > "../documentation/README.md" << 'EOF'
# Documentation

Architecture docs and feature specs.

## Specs

Feature specifications live in `specs/`. Created by the architect agent, consumed by all agents during implementation.
EOF
  fi
  echo ""
  echo "  ✓ documentation/ created"
fi

# Create symlinks at project root
echo ""
echo "Creating symlinks..."
cd ..

if [ ! -L ".cursor" ]; then
  ln -s workspace/.cursor .cursor
  echo "  ✓ .cursor -> workspace/.cursor"
else
  echo "  · .cursor symlink already exists"
fi

if [ ! -L "CLAUDE.md" ]; then
  ln -s workspace/CLAUDE.md CLAUDE.md
  echo "  ✓ CLAUDE.md -> workspace/CLAUDE.md"
else
  echo "  · CLAUDE.md symlink already exists"
fi

if [ ! -L ".mcp.json" ]; then
  ln -s workspace/.mcp.json .mcp.json
  echo "  ✓ .mcp.json -> workspace/.mcp.json"
else
  echo "  · .mcp.json symlink already exists"
fi

cd workspace

echo ""
echo "============================================"
echo "  Relay is ready."
echo ""
echo "  System agents: architect, operator, librarian, reviewer"
echo "  Add agents with: /recruit {callsign} [purpose]    (Cursor)"
echo "                or  recruit {callsign} [purpose]    (Claude Code)"
echo "  Optional templates: ts-api, ts-web, swift-app, swift-package"
echo ""
echo "  Edit workspace/PRINCIPAL.md to set your preferences."
echo "  Then open your project root in Cursor or Claude Code and run guide."
echo "============================================"
