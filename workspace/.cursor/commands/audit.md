Documentation and agent health sweep.

## Checks

### 1. Agent health
For each agent in `workspace/ROSTER.md`:
- AGENT.md complete?
- RELAY.md recently updated?
- Learnings INDEX matches actual files?
- Unprocessed Inbox messages?
- Stale Doing tasks?
- Sessions properly finalized? (no lingering `_active.md`)

### 2. Documentation
Verify files exist, flag broken references in `documentation/`.

### 3. Learnings sweep
Scan all agent Learnings for insights not yet incorporated into `documentation/`.

### 4. Skill promotion candidates
Look for learnings that have outgrown their per-agent home and deserve to be promoted to a shared `Skill`. Two signals to flag:

- **Cross-agent clusters.** Three or more agents have learnings on the same topic (similar tags, similar problem). The pattern is no longer agent-specific — it's a project pattern.
- **Repeated reference.** A single learning is referenced (in session logs or other learnings) more than 3 times across the last several sessions. It's load-bearing knowledge.

For each candidate, propose:
```
PROMOTE: {topic}
  Source learnings:
    - agents/api/Learnings/{file}.md
    - agents/app/Learnings/{file}.md
    - agents/devops/Learnings/{file}.md
  Proposed skill: workspace/.cursor/skills/{name}/SKILL.md
  Rationale: {why this is shared knowledge, not agent-specific}
```

The principal approves or rejects. On approve, librarian:
1. Writes the new `SKILL.md` distilling the learnings into a reusable pattern.
2. Adds a pointer in each source learning's INDEX entry: `→ Promoted to skill: {name}`.
3. Updates AGENT.md `Skills to Load` for any agent that should now load the skill.

Promoted learnings stay in place — the skill summarizes the pattern, the learnings remain as origin history.

### 5. PRINCIPAL.md health
- Does `workspace/PRINCIPAL.md` exist and have non-placeholder content?
- Are there frequently-violated preferences that suggest a missing entry? (Look for the same correction appearing as a learning across multiple agents.)

### 6. Report with recommended actions
Group findings by severity:
- **Critical:** stale Doing > 14 days, agents without RELAY.md, broken doc references
- **Action:** skill promotion candidates, learnings sweep candidates, missing PRINCIPAL.md entries
- **Info:** unread inbox counts, INDEX rebuilds needed
