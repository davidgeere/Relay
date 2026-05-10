Documentation and agent health sweep.

## Checks

### 1. Agent health

Per agent in `ROSTER.md`:
- AGENT.md complete?
- RELAY.md recently updated?
- Learnings INDEX matches actual files?
- Unprocessed Inbox messages?
- Stale Doing tasks?
- Sessions properly finalized? (no lingering `_active.md`)

### 2. Documentation

Verify files exist. Flag broken references in `documentation/`.

### 3. Learnings sweep

Scan all agent Learnings for insights not yet in `documentation/`.

### 4. Skill promotion candidates

Two signals:
- **Cross-agent clusters**: 3+ agents with learnings on same topic. Pattern is project-wide, not agent-specific.
- **Repeated reference**: a single learning referenced >3 times across recent sessions. Load-bearing knowledge.

Per candidate, propose:
```
PROMOTE: {topic}
  Source learnings:
    - agents/{a}/Learnings/{file}.md
    - agents/{b}/Learnings/{file}.md
    - agents/{c}/Learnings/{file}.md
  Proposed skill: .cursor/skills/{name}/SKILL.md
  Rationale: {why this is shared knowledge}
```

Principal approves or rejects. On approve, librarian:
1. Writes new `SKILL.md` distilling the pattern.
2. Adds pointer in each source learning's INDEX entry: `→ Promoted to skill: {name}`.
3. Updates AGENT.md `Skills to Load` for agents that should load it.

Promoted learnings stay in place. Skill summarizes the pattern; learnings remain origin history.

### 5. PRINCIPAL.md health

- Exists and has non-placeholder content?
- Frequently-violated preferences suggesting a missing entry? (Same correction recurring as a learning across multiple agents.)

### 6. Report

Group by severity:
- **Critical**: stale Doing >14 days, agents without RELAY.md, broken doc references
- **Action**: skill promotion candidates, learnings sweep candidates, missing PRINCIPAL.md entries
- **Info**: unread inbox counts, INDEX rebuilds needed
