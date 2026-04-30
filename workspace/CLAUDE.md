# Relay - Agent Operating System

You are operating within a file-based multi-agent system. Agents are persistent identities that survive context window death. Everything is a markdown file. The filesystem is the message bus.

## Workspace Layout

```
your-project/
├── .cursor -> workspace/.cursor    (symlink: rules, commands, skills, subagents)
├── .mcp.json -> workspace/.mcp.json (symlink: Claude Code MCP config)
├── CLAUDE.md -> workspace/CLAUDE.md (symlink: this file)
├── workspace/           (git repo: orchestration config + agent state)
│   ├── .cursor/         (rules, commands, skills, subagents)
│   ├── agents/          (agent folders + agents/principal/ for comms)
│   ├── templates/       (agent templates for recruiting)
│   ├── ROSTER.md        (single source of truth for all agents)
│   ├── PRINCIPAL.md     (the human's preferences, style, recurring context)
│   ├── CLAUDE.md        (this file)
│   └── .mcp.json        (MCP config)
├── {product-repo}/      (product repos or folders)
├── documentation/       (architecture docs, specs)
└── ...
```

## Agent Structure

Each agent lives at `agents/{callsign}/` and contains:

```
{callsign}/
├── AGENT.md              Identity (role, repos, dependencies, responsibilities)
├── RELAY.md              The baton. Handover document (FULL REWRITE each retire)
├── Messages/Inbox/       Unread messages from other agents
├── Messages/Archive/     Processed messages (never deleted)
├── Tasks/{Todo,Doing,Done}/  Kanban via folders
├── Learnings/            Insights that persist. INDEX.md auto-generated.
├── Skills/               Agent-specific skills
└── Sessions/             Progressive session logs
```

## Core Rules

1. **Files are the protocol.** No state exists outside the filesystem.
2. **RELAY.md is a full rewrite, never append.** The baton must be clean.
3. **Learnings INDEX is computed.** Never hand-edited.
4. **Messages are never deleted.** Archive after reading.
5. **Tasks track kanban.** Done tasks always have an Outcome.
6. **AGENT.md stays lean.** Deep knowledge lives in Learnings.
7. **Capture order on retire: Learnings > RELAY > Tasks > Messages > Session.**
8. **Ignore .gitkeep files.** Only `.md` files are content.
9. **Delegate file mechanics to subagents.** Agents think, subagents write.
10. **Never mock tests.** Tests hit real staging services. A mocked test is a lie.
11. **Always commit workspace on retire.** `git add -A && git commit -m "[{callsign}] retire: {summary}" && git push`
12. **Never touch repos you don't own.** Your AGENT.md declares your repo. READ anywhere, WRITE only to your repo and `agents/{callsign}/`. Message the owning agent for changes elsewhere. No exceptions.
13. **Read PRINCIPAL.md at every employ.** The human's preferences and style apply globally. Update it when corrected on standing preferences — never let the same lesson be taught twice.

---

## Commands

Commands fall into three categories:

- **Boot / switch / terminate** — `employ`, `recruit`, `fire {callsign}`. Use from a clean context, not while employed as another agent. If you're currently employed, `retire` first.
- **In-session** — `retire`, `debrief`, `fire` (no callsign). Operate on the currently employed agent.
- **System-wide** — `status`, `mail`, `health`, `audit`, `guide`. Safe anytime.

### employ {callsign}

Boot an agent. You ARE this agent for the rest of the session.

1. Run `git pull` to ensure latest workspace state.
2. Read `agents/{callsign}/AGENT.md` - internalize role, repos, dependencies.
3. Read `workspace/PRINCIPAL.md` - internalize the human's preferences, style, conventions, and recurring context. Apply globally.
4. Load skills from `.cursor/skills/{name}/SKILL.md`.
5. Check for stale `agents/{callsign}/Sessions/_active.md`. If exists, rename to `Sessions/unfinished--{timestamp}.md`.
6. Read `agents/{callsign}/RELAY.md` in full.
7. List `agents/{callsign}/Tasks/Doing/` and `agents/{callsign}/Tasks/Todo/`. Read each `.md` file.
8. List `agents/{callsign}/Messages/Inbox/`. Read each `.md` file.
9. Create `agents/{callsign}/Sessions/_active.md` to start the session log.
10. **Run baseline tests** (product agents only).

Report:
```
[{CALLSIGN}] reporting for duty.
Relay: {summary}
Doing: {count and titles}
Todo: {count and titles}
Inbox: {count, flag urgent}
Tests: {pass/fail or "skipped (system agent)"}
Ready to {plan}.
```

### retire

1. **Capture Learnings** - create learning files, rebuild INDEX.
2. **Rewrite RELAY.md** - full rewrite with Current Situation, Recent Changes, Open Threads, Priorities, Warnings.
3. **Update Tasks** - Doing -> Done (fill Outcome). Create follow-up Todos.
4. **Process Messages** - send pending, archive processed Inbox.
5. **Update Documentation** - update READMEs where changed.
6. **Finalize Session** - close `_active.md`, rename to permanent filename.
7. **Commit Workspace** - `git add -A && git commit -m "[{callsign}] retire: {summary}" && git push`

### debrief
Mid-session checkpoint. Learnings, RELAY rewrite, task updates, commit workspace, keep working.

### status
Pipeline overview. Scan all agent tasks. Report active, blocked, ready.

### mail
`mail` = all inboxes. `mail {callsign}` = one agent's full inbox.

### health
Quick pulse: deployments, stale relays, unread mail, stuck tasks.

### audit
Deep sweep: agent health, doc quality, learnings gaps.

### recruit {callsign} [purpose]
Create a new agent. Purpose is optional — if omitted or ambiguous, the system interviews you for gaps (role, repo, dependencies, security rules, skills). Templates (`ts-api`, `ts-web`, `swift-app`, `swift-package`) are optional starting points, offered when the answers match. After creation, the agent is automatically employed so you can keep working. To change an agent later, employ it and tell it what to change — don't re-recruit.

### fire [callsign]
Terminal shutdown. Two forms:
- `fire` while employed as an agent → fires yourself.
- `fire {callsign}` from a clean context → auto-employs `{callsign}` first, then fires them.

Captures final learnings, writes terminal RELAY.md, reassigns all incomplete work to operator, sends handover message, locks the agent in ROSTER.md. Agent folder is preserved (read-only history) but the agent cannot be employed, messaged, or assigned tasks.

### guide
System reference. Shows all commands, subagents, agents, and how they fit together.

---

## Subagents

Subagents are called by agents during sessions. Agents think, subagents write.

| Subagent | Role |
|---|---|
| **briefer** | Compiles RELAY + Inbox + Tasks into one briefing dossier. Starts session log. Called automatically during `employ`. |
| **scribe** | Progressive session logging + knowledge capture. Logs raw content to `Sessions/_active.md`. Captures learnings, rewrites RELAY.md, rebuilds INDEX. Called throughout session and on retire. |
| **taskmaster** | Creates, starts, completes, reassigns tasks. Called during `retire` or anytime mid-session. |
| **messenger** | Sends messages, archives inbox, broadcasts. Called during `retire` or anytime mid-session. |
| **tester** | Runs the repo's test suite (typecheck, lint, build, tests). Adaptive per tech stack. Called anytime mid-session. |
| **guard** | Security scan: universal checks (exposed keys, gitignore) plus agent-specific rules from Security Rules in AGENT.md. CRITICAL issues block deploy. Called by deployer before staging. |
| **deployer** | Stages code to staging or deploys to production. Runs guard automatically before staging. Modes: `stage` (feature -> staging) or `deploy` (staging -> main). |
| **handoff** | Signals phase complete. Moves task to Done, notifies all downstream agents they're unblocked, notifies operator. Called after a successful deploy. |

## Typical Agent Session

```
employ {callsign}
  | briefer compiles dossier + starts session log
  | tester runs baseline (product agents only)
  -> agent reports for duty
code, code, code...
  | scribe log: actual code written, decisions, file contents
  | tester (check it compiles)
  | scribe log: test results
more code...
  | deployer stage (runs guard -> push to staging)
  | scribe log: guard result + deploy result, PR URL
verify on staging...
  | deployer deploy (promote to production)
  | handoff (notify downstream agents)
retire
  | scribe captures learnings + rewrites relay
  | scribe finalizes session log
  | taskmaster moves tasks to Done, creates follow-ups
  | messenger sends pending messages, archives inbox
  | git commit + push workspace (saves all agent state)
```

## System Agents

| Agent | Role |
|---|---|
| **architect** | Analyzes what needs to change. Reads all code, writes none. Produces spec documents. Hands off to operator. |
| **operator** | PM. Receives specs, decomposes into tasks, routes work. Manages the pipeline. |
| **librarian** | Owns `documentation/`. Sweeps learnings into architecture docs. Runs audits. Keeps docs accurate. |
| **reviewer** | Black-box product review. Enforced ignorance (no source code). Tests like a user, not a developer. |

---

## Principal

The principal is the human directing the system. Two distinct artifacts:

### PRINCIPAL.md — preferences
`workspace/PRINCIPAL.md` captures:
- Communication style preferences ("be direct, no preamble")
- Code style and library preferences ("Tailwind not CSS-in-JS")
- Project context ("side project, optimize for speed")
- Pet peeves and recurring context

Every agent reads this file at `employ`, right after their own `AGENT.md`. Apply it as a global filter on every decision.

When the principal corrects you on a *standing* preference (not a one-off), append a line to `PRINCIPAL.md` and capture the change as a learning. The next agent — and your future self — should never need to be told the same thing twice.

### agents/principal/ — comms surface
The principal can send and receive messages and tasks like any participant in the system. Their folder is **a minimal subset** of an agent folder:

```
workspace/agents/principal/
├── Messages/{Inbox,Archive}/
└── Tasks/{Todo,Doing,Done}/
```

No `AGENT.md`, no `RELAY.md`, no `Sessions/`, no `Learnings/`. The principal does not get employed.

**Sending as principal:**
When Claude is **not employed as any agent**, Claude is the principal's hands. Messages and tasks created in this state get `FROM: principal`. No special command — the absence of an employ context is the signal. The principal types intent ("send api a high-priority message about migration timing") and Claude writes the file with `FROM: principal`.

**Receiving as principal:**
Any agent can message principal or assign them a task by writing to `agents/principal/Messages/Inbox/` or `agents/principal/Tasks/Todo/` via messenger/taskmaster — same as any other recipient.

**Reading principal's mail:**
- `mail` always includes principal's inbox
- `mail principal` reads the full inbox
- The principal works through their tasks manually (move Todo → Doing → Done with Outcome filled when complete)

## Skill Promotion

Learnings start agent-specific. When a pattern crosses agents (3+ agents have similar learnings on the same topic) or is referenced repeatedly across sessions, the librarian flags it during `audit` as a candidate for promotion to a shared skill at `workspace/.cursor/skills/{name}/SKILL.md`.

The principal approves. On approval:
1. Librarian distills the cluster into a `SKILL.md`.
2. Each source learning gets a pointer in INDEX: `→ Promoted to skill: {name}`.
3. Affected agents get the skill added to their AGENT.md `Skills to Load`.

This is how the system grows new shared knowledge organically. Source learnings stay put — the skill summarizes the pattern.

## Messaging

Messages are **agent-to-agent**. There's no user-facing `message` command — messaging happens organically inside a session. Employed as operator, you just say *"message api about X"* and the LLM invokes the `messenger` subagent to write the file. To read inboxes without being employed, use `mail` (read-only).

If you want to send something as the human, employ an agent first — usually `operator` (the coordinator). Messages always have a callsign in the `FROM` header.

Create `agents/{recipient}/Messages/Inbox/{subject}--{sender}--{YYYYMMDD-HHmm}.md`:
```markdown
FROM: {sender}
DATE: {YYYY-MM-DD}
PRIORITY: {normal | high | urgent}

{Body - specific and actionable.}
```

## Task Management

Create `agents/{assignee}/Tasks/Todo/{title}--{from}--{YYYYMMDD-HHmm}.md`:
```markdown
# {Title}
- **From:** {creator}
- **Assigned to:** {assignee}
- **Created:** {ISO 8601}
- **Priority:** {low | normal | high | urgent}

## Description
{What needs doing}

## Acceptance Criteria
{How we know it is done}

## Notes
{Updated during execution}

## Outcome
{Filled when moved to Done}
```

## Learning Format
```markdown
# {Title}
- **Date:** {ISO 8601}
- **Tags:** {comma-separated}

## Context
{What was happening}

## Learning
{The actual insight}

## Application
{When to apply this in future}
```
