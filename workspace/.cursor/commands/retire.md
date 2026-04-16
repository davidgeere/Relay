Graceful shutdown. Capture everything, hand off cleanly. ORDER MATTERS - highest value first in case context dies mid-process.

**Important:** Throughout the session, you should have been calling `scribe log` after every significant action. The session log at `Sessions/_active.md` should already contain the raw record. If you haven't been logging, do a final catch-up log now.

## Sequence

### Step 1: Capture Learnings (via scribe)
For each new insight, gotcha, or technique:
- Tell `scribe` to capture each learning with: title, date, tags, context, learning, application.
- After all learnings, tell `scribe` to rebuild the INDEX.

### Step 2: Rewrite RELAY.md (via scribe)
Tell `scribe` to rewrite RELAY.md with:
- **Current Situation** - what's happening right now
- **Recent Changes** - what happened this session
- **Open Threads** - unfinished work, pending decisions
- **Priorities** - what matters most next session
- **Warnings** - gotchas, traps, things that will bite you

Be specific: file paths, branch names, error messages, commit hashes. **Full rewrite, not append.**

### Step 3: Update Tasks (via taskmaster)
- Complete any Doing tasks (move to Done with Outcome).
- Create new Todo tasks for follow-up work.
- Tasks for OTHER agents: create in their Todo AND notify via messenger.

### Step 4: Process Messages (via messenger)
- Send any pending messages to other agents.
- Archive all processed Inbox messages.

### Step 5: Update Documentation
Update READMEs where changes were made. Substantial doc work? Create a task for librarian.

### Step 6: Finalize Session (via scribe)
Close out `Sessions/_active.md` with a summary, files changed, and unfinished work. Rename to permanent filename.

### Step 7: Commit Workspace
```bash
cd workspace
git add -A
git commit -m "[{callsign}] retire: {brief session summary}"
git push
```

### Step 8: Confirm
```
[{CALLSIGN}] retired.

Learnings: {count} captured
Relay: updated
Tasks: {completed} done, {new} created
Messages: {sent} sent, {archived} archived
Session: {filename}
Workspace: committed and pushed
```

## Rules
- Steps 1-2 are highest priority. If context is dying, get learnings and relay captured first.
- RELAY is a rewrite. The baton must be clean.
- **Always commit workspace last.** Everything else writes files, the commit saves them all.
