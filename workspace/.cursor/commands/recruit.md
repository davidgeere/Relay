Create a new agent. Template is optional — give a purpose, answer a few questions, get to work.

## Usage
`/recruit {callsign} [purpose]`

- `recruit api "central API for user data and auth"` — purpose given, interview fills gaps
- `recruit data` — no purpose, full interview
- `recruit api ts-api` — template name given, use as starting point (legacy form, still works)

Templates in `workspace/templates/`: `ts-api`, `ts-web`, `swift-app`, `swift-package`. These are optional starting points, not required.

## Sequence

### Step 1: Validate
Check `workspace/ROSTER.md`. If callsign exists (Active OR Fired), stop and report.

### Step 2: Gather Agent Definition

If a **known template name** was given as the second argument, use that template's AGENT.md as the base.

Otherwise, treat the second argument (if any) as a **purpose statement**. Ask only about what's ambiguous. Skip questions the purpose already answers.

Default questions:
- **Role** — one-line description of what this agent does (skip if purpose is clear)
- **Repo/folder** — does this agent own a repo or folder? Path? (for product agents; skip for coordination-only agents)
- **Dependencies** — what other agents does this one depend on? What depends on it?
- **Skills** — beyond `project-system`, are there agent-specific skills to load?
- **Security concerns** — anything `guard` should check before stage? (e.g. no keys in client bundles, auth middleware required)

If the answers strongly match an existing template, offer: *"This looks like `ts-api`. Use it as a starting point?"* — but proceed either way.

### Step 3: Create Folder Structure
At `workspace/agents/{callsign}/`:
```
AGENT.md, RELAY.md,
Messages/{Inbox,Archive},
Tasks/{Todo,Doing,Done},
Learnings/INDEX.md, Skills/, Sessions/
```
Add `.gitkeep` to empty directories.

### Step 4: Write AGENT.md
Follow the template structure (see `workspace/templates/*/AGENT.md` for the shape) but keep it lean. Include:
- Identity: callsign, role, repo, documentation path
- Dependencies: depends on / depended on by
- Local development: dev command, URLs (if applicable)
- Responsibilities: 3–5 concrete things this agent owns
- Skills to Load: at minimum `project-system`
- Security Rules: specific rules `guard` should enforce
- Pre-commit checklist
- Communication protocols

### Step 5: Seed Relay and Index
- `RELAY.md`: `Fresh agent. No prior sessions.`
- `Learnings/INDEX.md`: `No learnings yet.`

### Step 6: Update Roster
Add a row to `workspace/ROSTER.md` under the appropriate section (System Agents or Product Agents).

### Step 7: Notify Operator
Send a message to operator's inbox:
```markdown
FROM: {callsign}
DATE: {YYYY-MM-DD}
PRIORITY: normal

## New agent recruited: {callsign}

Role: {role}
Repo: {repo or "none"}
Dependencies: {list}

I've been added to ROSTER.md and I'm employed for my first session.
See agents/{callsign}/AGENT.md for full identity.
```

### Step 8: Commit Workspace
```bash
cd workspace
git add -A
git commit -m "recruit: {callsign} ({role})"
git push
```

### Step 9: Auto-employ
Immediately run the employ sequence for `{callsign}` so the user can keep working. Report:

```
[{CALLSIGN}] recruited and employed.

Role: {role}
Repo: {repo or "none"}
Skills: {list}
Roster: updated
Operator: notified
Workspace: committed

Ready for your first instruction.
```

## Refining an Agent Later

You don't re-recruit to change an agent. Just `employ {callsign}` and tell the agent what else to focus on, what rules to follow, or what repos it now owns. The agent updates its own AGENT.md (lean) and records the change as a learning. Retire as usual — the change persists.

## Rules
- Callsigns are permanent. A fired agent's callsign can't be reused.
- A purpose statement is enough — don't over-interview. Ask only what's ambiguous.
- Templates are optional. Agents without a matching template are first-class citizens.
- Always auto-employ after recruit. The user recruited for a reason; hand them the agent ready to go.
