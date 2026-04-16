Mid-session checkpoint. Save progress without ending the session.

## Sequence
1. **Catch-up log** - if behind on `scribe log`, do a catch-up now.
2. **Learnings** - tell `scribe` to capture any new learnings. Rebuild INDEX.
3. **RELAY.md** - compose current state, tell `scribe` to do a full rewrite.
4. **Tasks** - tell `taskmaster` to update statuses.
5. **Commit workspace** - `cd workspace && git add -A && git commit -m "[{callsign}] debrief: {focus}" && git push`
6. **Continue working.**

## Report
```
[{CALLSIGN}] debriefed.

Learnings: {count} captured
Relay: updated
Tasks: {status changes}
Workspace: committed

Continuing with: {what you're working on next}
```
