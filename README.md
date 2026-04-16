# Relay

A file-based multi-agent orchestration framework for AI-assisted development. The filesystem is the memory. Agents are persistent identities that survive context window death. Zero dependencies - just markdown, folders, and git.

## The Problem

AI coding assistants forget everything when the context window resets. Every new chat starts from zero. You re-explain your architecture, rediscover debugging insights, and lose coordination across work streams. Relay fixes this.

## How It Works

Agents are folders. Each agent has a persistent identity (AGENT.md), a handover document (RELAY.md - the baton), an inbox, a task board, learnings, and session logs. When you employ an agent, it reads all of this and picks up where the last session left off. When you retire it, everything is captured to files. The files live in git. Git never forgets.

```
/employ api          → agent boots, reads relay + inbox + tasks, reports for duty
...work happens...   → progressive session logging, test runs, deploys
/retire              → learnings captured, relay rewritten, tasks updated, workspace committed
```

## Quick Start

```bash
# Clone into your project
git clone https://github.com/davidgeere/relay.git workspace

# Run setup (creates agent folders, symlinks)
cd workspace && ./setup.sh

# Open your project root in Cursor
# Type /guide to see the full system reference
# Type /employ operator to start your first session
```

## What's Included

### 4 System Agents (project-agnostic)

| Agent | Role |
|-------|------|
| **architect** | Analyzes codebases, writes specs. Reads everything, writes no code. |
| **operator** | PM. Decomposes specs into tasks, routes work, tracks the pipeline. |
| **librarian** | Owns documentation. Sweeps learnings, runs audits, keeps docs accurate. |
| **reviewer** | Black-box product review. Enforced ignorance - no source code access. Tests like a user. |

### 9 Commands

| Command | Purpose |
|---------|---------|
| `/employ {callsign}` | Boot an agent. You ARE them for the session. |
| `/retire` | Shutdown. Capture learnings, relay, tasks, messages. Commit workspace. |
| `/debrief` | Mid-session checkpoint. Save progress, keep working. |
| `/status` | Pipeline view. What's active, blocked, ready. |
| `/mail` | Scan all inboxes. Or `/mail {callsign}` for one agent. |
| `/health` | Quick pulse. Stale relays, stuck tasks, unread mail. |
| `/audit` | Deep sweep. Agent health, doc quality, learnings gaps. |
| `/recruit {callsign}` | Create a new product agent from a template. |
| `/guide` | Full system reference. |

### 8 Subagents

Stateless workers that handle file mechanics so agents can focus on thinking:

**briefer** (compiles session dossier), **scribe** (progressive logging + learnings), **taskmaster** (task lifecycle), **messenger** (inter-agent messaging), **tester** (test suite runner), **guard** (security scanner), **deployer** (stage/deploy with guard gate), **handoff** (notify downstream agents)

### Templates

Add product agents with `/recruit`:
- `ts-api` - TypeScript API agent
- `ts-web` - TypeScript web app agent (Next.js, SvelteKit, etc.)
- `swift-app` - Swift/SwiftUI iOS app agent
- `swift-package` - Swift package/SDK agent

## Workspace Structure

```
your-project/
├── .cursor -> workspace/.cursor      (symlink)
├── CLAUDE.md -> workspace/CLAUDE.md  (symlink)
├── .mcp.json -> workspace/.mcp.json  (symlink)
├── workspace/                        (this repo)
│   ├── .cursor/                      (rules, commands, skills, subagents)
│   ├── agents/                       (agent folders)
│   ├── templates/                    (agent templates for /recruit)
│   ├── ROSTER.md                     (all agents and their status)
│   ├── CLAUDE.md                     (Claude Code / Cowork instructions)
│   └── .mcp.json                     (MCP server config)
├── your-api/                         (product repo or folder)
├── your-app/                         (product repo or folder)
├── documentation/                    (docs repo or folder)
└── ...
```

## Monorepo or Polyrepo

Relay doesn't care. What matters is ownership boundaries:

- **Polyrepo:** Each product agent owns a separate git repo. Workspace is its own repo. Documentation is its own repo.
- **Monorepo:** Everything in one repo. Each agent owns a folder. Same rules, same boundaries.

The enforcement is the same either way: each agent's AGENT.md declares what it owns. Core Rule 13: "Never touch repos/folders you don't own. READ anywhere, WRITE only to your declared area."

## Works With

- **Cursor** - commands, rules, subagents via `.cursor/`
- **Claude Code** - instructions via `CLAUDE.md`, same agent system
- **Cowork** - same as Claude Code, folder-based access
- **Any future tool** - the protocol is files, not tool features

## Core Rules

1. Files are the protocol. No state outside the filesystem.
2. RELAY.md is a full rewrite, never append. The baton must be clean.
3. Learnings INDEX is auto-generated. Never hand-edit.
4. Messages are never deleted. Archive only.
5. Tasks track kanban. Done tasks always have an Outcome.
6. Capture order on retire: Learnings > RELAY > Tasks > Messages > Session.
7. Delegate file mechanics to subagents. Agents think, subagents write.
8. Never mock tests. Hit real staging. A mocked test is a lie.
9. Always commit workspace on retire. Agent state dies if it's not pushed.
10. Never touch repos you don't own. READ anywhere, WRITE only to your declared area.

## Real-World Results

Relay has been deployed on two production projects:

- **Project A** (iOS + API + Admin + Website, 5 weeks): 9 agents, 28+ sessions, 63+ learnings, 3 features through the full pipeline
- **Project B** (Web app + API + Admin + Website, 2.5 weeks): 9 agents, 111+ sessions, 162+ learnings, 100+ completed tasks, 2 full product phases delivered

## License

MIT
