# Relay

A file-based multi-agent orchestration framework for AI-assisted development. The filesystem is the memory. Agents are persistent identities that survive context window death. Zero dependencies - just markdown, folders, and git.

## The Problem

AI coding assistants forget everything when the context window resets. Every new chat starts from zero. You re-explain your architecture, rediscover debugging insights, and lose coordination across work streams. Relay fixes this.

## How It Works

Agents are folders. Each agent has a persistent identity (AGENT.md), a handover document (RELAY.md - the baton), an inbox, a task board, learnings, and session logs. When you employ an agent, it reads all of this and picks up where the last session left off. When you retire it, everything is captured to files. The files live in git. Git never forgets.

```
employ api           → agent boots, reads relay + inbox + tasks, reports for duty
...work happens...   → progressive session logging, test runs, deploys
retire               → learnings captured, relay rewritten, tasks updated, workspace committed
```

## 👉 See It In Action

**[Read the Walkthrough →](WALKTHROUGH.md)**

A day-by-day story of shipping a real feature through the full agent pipeline — from spec to deploy. Shows what every agent does, what files get written, and how the baton passes between sessions. **Read this first.** It's the fastest way to understand what Relay feels like in practice.

## Quick Start

```bash
# Clone into your project
git clone https://github.com/davidgeere/Relay.git workspace

# Run setup (creates agent folders, symlinks)
cd workspace && ./setup.sh

# Open your project root in Cursor or Claude Code
# Type: employ operator (Claude Code) or /employ operator (Cursor)
# Type: guide (Claude Code) or /guide (Cursor) for the full reference
```

## What's Included

### 4 System Agents (project-agnostic)

| Agent | Role |
|-------|------|
| **architect** | Analyzes codebases, writes specs. Reads everything, writes no code. |
| **operator** | PM. Decomposes specs into tasks, routes work, tracks the pipeline. |
| **librarian** | Owns documentation. Sweeps learnings, runs audits, keeps docs accurate. |
| **reviewer** | Black-box product review. Enforced ignorance - no source code access. Tests like a user. |

### 10 Commands

Commands fall into three categories based on when you use them.

**Boot / switch / terminate** (use from a clean context, not while employed as another agent):

| Command | Purpose |
|---------|---------|
| `employ {callsign}` | Boot an agent. You ARE them for the session. |
| `recruit {callsign} [purpose]` | Create a new agent. Interviews for gaps, auto-employs on completion. Templates optional. |
| `fire {callsign}` | Terminal shutdown of another agent. Auto-employs them first, then runs the fire sequence. |

**In-session** (while employed as an agent — operates on the current agent):

| Command | Purpose |
|---------|---------|
| `retire` | Shutdown. Capture learnings, relay, tasks, messages. Commit workspace. |
| `debrief` | Mid-session checkpoint. Save progress, keep working. |
| `fire` | Fire yourself. Terminal shutdown of the currently employed agent. |

**System-wide** (safe anytime, inside or outside an employment):

| Command | Purpose |
|---------|---------|
| `status` | Pipeline view. What's active, blocked, ready. |
| `mail` | Scan all inboxes. Or `mail {callsign}` for one agent. |
| `health` | Quick pulse. Stale relays, stuck tasks, unread mail. |
| `audit` | Deep sweep. Agent health, doc quality, learnings gaps. |
| `guide` | Full system reference. |

> In Cursor, prefix with `/` (e.g. `/employ api`). In Claude Code, just type the command (e.g. `employ api`).
>
> If you're employed as one agent and want to switch to another, `retire` first, then `employ` the next one. Otherwise the current session won't be captured properly.
>
> **No `message` command — messaging is organic.** Inside a session you just say *"message api about X"* and your agent sends it via the `messenger` subagent. Messages are always agent-to-agent; the `FROM` header is a callsign. To send as the human, employ an agent first (usually `operator`). Use `mail` to read inboxes without being employed.

### 8 Subagents

Stateless workers that handle file mechanics so agents can focus on thinking:

**briefer** (compiles session dossier), **scribe** (progressive logging + learnings), **taskmaster** (task lifecycle), **messenger** (inter-agent messaging), **tester** (test suite runner), **guard** (security scanner), **deployer** (stage/deploy with guard gate), **handoff** (notify downstream agents)

### Templates (optional starting points)

Use `recruit {callsign} [purpose]` and the system will interview you for gaps. If your agent looks like one of these, it'll offer the template as a starting point — but templates aren't required. Agents without a matching template are first-class.

- `ts-api` - TypeScript API agent
- `ts-web` - TypeScript web app agent (Next.js, SvelteKit, etc.)
- `swift-app` - Swift/SwiftUI iOS app agent
- `swift-package` - Swift package/SDK agent

**Refining an agent later:** Don't re-recruit. Just `employ {callsign}` and tell the agent what else it owns or what rules to follow. It updates its own AGENT.md.

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
│   ├── PRINCIPAL.md                  (your preferences, style, recurring context)
│   ├── CLAUDE.md                     (Claude Code instructions)
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
- **Any future tool** - the protocol is files, not tool features

## How Agents Learn You

Two files quietly do most of the work of "the system gets smarter over time":

- **`workspace/PRINCIPAL.md`** — your preferences, code style, project context, pet peeves. Every agent reads this at `employ` right after their own `AGENT.md`. When you correct an agent on a *standing* preference, it updates `PRINCIPAL.md` so the next agent starts already knowing. You don't repeat yourself.

- **Skill promotion** — learnings start agent-specific. When the same insight shows up across 3+ agents (or gets referenced repeatedly across sessions), `librarian` flags it during `audit` as a candidate for promotion to a shared skill at `workspace/.cursor/skills/{name}/SKILL.md`. You approve. The skill gets distilled, source learnings get pointers, affected agents start loading the new skill. The system organically grows new shared knowledge from lived experience.

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
11. Read PRINCIPAL.md at every employ. Update it when corrected on standing preferences.

## Real-World Results

Relay has been deployed on two production projects:

- **Project A** (iOS + API + Admin + Website, 5 weeks): 9 agents, 28+ sessions, 63+ learnings, 3 features through the full pipeline
- **Project B** (Web app + API + Admin + Website, 2.5 weeks): 9 agents, 111+ sessions, 162+ learnings, 100+ completed tasks, 2 full product phases delivered

## License

MIT
