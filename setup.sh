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

# Create .relay directory for hooks and daemon state
mkdir -p .relay/hooks
mkdir -p .relay/terminals

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
echo "  Add product agents with: /recruit {callsign} {template}"
echo "  Available templates: ts-api, ts-web, swift-app, swift-package"
echo ""
echo "  Open your project root in Cursor and type /guide"
echo "============================================"
