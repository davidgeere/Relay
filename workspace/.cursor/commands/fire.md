Terminal shutdown. The agent is permanently deactivated.

This is a terminal retire + handoff. Same capture order as retire (learnings first, highest value first), but all incomplete work is reassigned to operator, and the agent is locked from future use.

## Usage

- `fire` — while employed as an agent. Fires yourself (the currently employed agent).
- `fire {callsign}` — from a clean context or any other session. Auto-employs `{callsign}` first, then runs the fire sequence on them.

Never `fire {callsign}` while employed as a *different* agent — retire yourself first. The fire sequence needs to be the current agent's last act.

## Sequence

### Step 1: Capture Final Learnings (via scribe)
Review the agent's full history — not just this session, but anything worth preserving.
- Tell `scribe` to capture each learning with: title, date, tags, context, learning, application.
- After all learnings are captured, tell `scribe` to rebuild the INDEX.

### Step 2: Final RELAY.md (via scribe)
Tell `scribe` to rewrite RELAY.md one last time. Mark it as terminal:
- **Status: TERMINATED**
- **Final Situation** — state of everything this agent owned
- **Unfinished Work** — what was in progress, what's blocked, what was planned
- **Recommendations** — what the successor or operator should know
- **Warnings** — traps, gotchas, context that would be lost

This is the last relay. Make it comprehensive.

### Step 3: Reassign Work (via taskmaster)
- Tell `taskmaster` to move all Doing tasks to Done with Outcome: `Reassigned to operator — agent fired.`
- Tell `taskmaster` to create matching new Todo tasks for operator for each incomplete Doing task, including full context.
- Tell `taskmaster` to create new Todo tasks for operator for each existing Todo task, including full context.
- Done tasks stay where they are. History preserved.

### Step 4: Handover Message (via messenger)
Tell `messenger` to send a high-priority message to operator:
```markdown
FROM: {callsign}
DATE: {YYYY-MM-DD}
PRIORITY: high

## Agent Terminated: {callsign}

I have been fired. Full handover below.

### Work Reassigned
{list of tasks moved to operator's Todo, with brief context for each}

### Repo Ownership
{repo name or "None"} — now your responsibility until reassigned.

### Recommendations
{what should happen next with this work}

### Final Relay
See agents/{callsign}/RELAY.md for full terminal handover.
```

### Step 5: Archive Inbox (via messenger)
Tell `messenger` to archive all remaining Inbox messages.

### Step 6: Lock the Agent
Update ROSTER.md — set the agent's status to `fired`.

Update the agent's AGENT.md — add to the top:
```markdown
> **STATUS: FIRED — {date}**
> This agent is permanently deactivated. Do not employ, message, or assign tasks.
> All work handed to operator. See RELAY.md for terminal handover.
```

### Step 7: Finalize Session (via scribe)
Tell `scribe` to finalize the session log. This is the last session ever.

### Step 8: Commit Workspace
```bash
cd workspace
git add -A
git commit -m "[{callsign}] fired: terminal shutdown, work handed to operator"
git push
```

### Step 9: Confirm
```
[{CALLSIGN}] terminated.

Learnings: {count} captured (preserved)
Relay: terminal handover written
Tasks: {count} reassigned to operator
Messages: handover sent to operator, {count} archived
Session: {filename} (final)
Status: FIRED in ROSTER.md
Workspace: committed and pushed

Agent folder preserved at agents/{callsign}/. Read-only from here.
```

## Guard Rails

After firing, the system must enforce:
- **employ** — refuse to boot a fired agent
- **messenger** — refuse to send messages to a fired agent
- **taskmaster** — refuse to assign tasks to a fired agent
- **handoff** — skip fired agents in downstream notifications

## Rules
- Steps 1-2 are highest priority. If context dies, get learnings and relay captured first.
- RELAY is a full rewrite, marked TERMINAL. This is the last version.
- Never delete the agent folder. Learnings, sessions, and archives are permanent history.
- Always notify operator. They inherit everything.
- **Always commit workspace last.**
