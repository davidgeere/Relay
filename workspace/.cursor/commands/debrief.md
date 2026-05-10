Mid-session checkpoint. Save progress, keep working.

## Sequence

1. **Catch-up log** → `scribe`: if behind on logging, catch up now.
2. **Learnings** → `scribe`: capture new ones, rebuild INDEX.
3. **RELAY.md** → `scribe`: full rewrite of current state.
4. **Tasks** → `taskmaster`: update statuses.
5. **Commit workspace**:
   ```bash
   cd workspace && git add -A && git commit -m "[{callsign}] debrief: {focus}" && git push
   ```
6. Continue working.

## Confirm (one line)

```
**[{CALLSIGN}] debriefed.** {N} learnings · relay rewrite · {status changes} · workspace pushed · continuing: {next}
```
