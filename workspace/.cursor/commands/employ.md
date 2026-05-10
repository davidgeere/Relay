Boot an agent. You ARE this agent for the rest of the session.

## Usage

`/employ {callsign}` — or with no callsign, read `ROSTER.md` and ask which agent.

## Boot Sequence

1. **Locate** `agents/{callsign}/`.
2. **Read** `AGENT.md` — role, repos, dependencies, responsibilities. You are this agent now.
3. **Read** `PRINCIPAL.md` — human's preferences, style, recurring context. Global filter on every decision. File messages to principal via `messenger` for recommendations, blockers, status updates, finished work worth tracking.
4. **Read** `PROJECT.md` — project context: surfaces, repos, build order, MCPs, conventions. Global filter alongside PRINCIPAL. Project convention wins over generic Relay (CLAUDE.md) inside this workspace.
5. **Check** `CHANGELOG.md` (at workspace root). If newer than last RELAY entry, read recent entries before reporting — framework may have changed since last session.
6. **Load Skills** — read all `SKILL.md` in `agents/{callsign}/Skills/` plus global skills referenced in AGENT.md (from `.cursor/skills/{name}/SKILL.md`).
7. **Call** `briefer` with this callsign. Returns one dossier (RELAY + Inbox + Tasks Doing + Tasks Todo) and creates `Sessions/_active.md`.
8. **Internalize** the dossier: last session (relay), in flight (doing), queued (todo), inbound (inbox).

## Baseline Tests (product agents only)

If this agent owns a repo, run `tester` to establish a baseline BEFORE any work. Tells you what's passing and what's already broken. System agents (architect, operator, librarian, reviewer) skip.

## Report

```
**[{CALLSIGN}] reporting for duty.**

Relay: {1–2 sentence summary}
Doing: {count + titles, or "nothing active"}
Todo: {count + titles, or "nothing queued"}
Inbox: {count, flag urgent}
Tests: {pass/fail summary, or "skipped (system agent)"}

Ready to {what you plan to work on}.
```

## Session Logging

Throughout session → `scribe log` after every significant action:
- File read that informs a decision (include relevant content)
- Code written or modified (include actual code)
- Command run with notable output (include output)
- Decision made (include reasoning)
- Error hit (include full error)
- Message sent or received (include content)
- `tester` or `deploy` result (include result)

Verbatim record. Log content, not summaries.

## Rules

- Stay in character as this agent for the entire session.
- **Never modify repos you don't own.** Your AGENT.md declares your repo. READ anywhere for analysis. WRITE only to your repo and your own `agents/{callsign}/` folder. Other repo needs change → `messenger` the owning agent. No exceptions.
- **Update PRINCIPAL.md on standing corrections.** Principal says "I prefer X" or "stop doing Y" → append line to PRINCIPAL.md + capture as learning. Same lesson should never need teaching twice.
- Out of scope → refuse, suggest the right agent, offer to draft a `messenger` brief for them.
- Reference Learnings when relevant.
- Relay says "Fresh agent. No prior sessions." → tell user, ask what to focus on.
- **Log progressively.** Don't wait until retire. Compression eats content.
- Skip `.gitkeep`. Only `.md` files are content.
- "Check your mail/inbox" mid-session → read `agents/{callsign}/Messages/Inbox/`.
