Verbose state-of-session report. No side effects. Use mid-session or as the verbose preamble before `/retire`.

## Output

Read `Sessions/_active.md` plus current in-context work, then emit:

```
**[{CALLSIGN}] session report.**

Started: {timestamp from _active header}
Now: {current timestamp}

### Done this session
- {bullet per significant action; reference commit hash, file path, decision}

### Files touched
- {repo:path — what changed and why, per file}

### Commits
- {hash · subject · repo, per commit}

### Decisions
- {one-line per material decision and rationale}

### Open at this moment
- {in-flight work not yet committed or finalized}
- {messages drafted but not sent}
- {tasks moved but not committed}

### Next, if continuing
- {what you'd do next}

### Next, if retiring
- {what /retire will pick up: learnings count, RELAY rewrite scope, tasks to move, messages to send/archive, doc updates}
```

## Rules

- Read-only. Never writes, commits, or moves files.
- Pull from `Sessions/_active.md` first, then in-context work the log hasn't captured yet.
- If `_active.md` missing or stale, note that at the top and reconstruct from in-context memory.
- Skip empty sections.
