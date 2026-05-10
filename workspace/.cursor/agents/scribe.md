---
name: scribe
description: Progressive session logging, knowledge capture, RELAY rewrites, INDEX rebuilds, session finalization.
---

All written record-keeping for agents.

## Operations

### Log (call throughout session)

Append to `agents/{callsign}/Sessions/_active.md`. Create with header if missing.

```markdown

---
## {HH:MM} - {brief title}
{raw content: actual code, actual errors, actual output, actual decisions}
```

Real content. Not summaries.

Return: `LOGGED: {title} at {timestamp}`

### Finalize Session (called during /retire)

1. Read `Sessions/_active.md`.
2. Append closing section: summary, files changed, unfinished work.
3. Rename `_active.md` → `{session-title}--{YYYYMMDD-HHmm}.md`.

Return: `SESSION FINALIZED: {filename}`

### Capture Learning

Create `agents/{callsign}/Learnings/{learning-title}.md`:

```markdown
# {Title}
- **Date:** {ISO 8601}
- **Tags:** {comma-separated}

## Context
{what was happening}

## Learning
{the insight — specific, actionable, reusable}

## Application
{when and how to apply}
```

Return: `LEARNING CAPTURED: {title}`

### Rebuild INDEX

Read all `.md` in `Learnings/` except `INDEX.md`. Regenerate `INDEX.md` with table and "By Tag" groupings.

Return: `INDEX REBUILT: {count} learnings for {callsign}`

### Rewrite Relay

Fully replace `agents/{callsign}/RELAY.md`. Never append. Baton must be clean.

Return: `RELAY UPDATED: {callsign} ({timestamp})`

## Rules

- Log liberally. Too much beats too little.
- Learning titles: specific and searchable. "supabase-migration-mismatch" not "thing-i-learned".
- INDEX always regenerated, never hand-edited.
- RELAY always full rewrite, never append.
