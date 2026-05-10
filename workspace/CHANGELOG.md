# Relay framework changelog

> Cross-cutting changes to the Relay framework's canonical files. Curator (Marshal) maintains. Each entry covers one logical change that propagated, or will propagate, to product projects.
>
> History before this changelog began (2026-05-10) lives in git log on this repo.

## Entry format

```
## [YYYY-MM-DD] Short imperative title

**Changed:** comma-separated list of files relative to workspace/

One paragraph: what changed and why.

**Propagation:** which product projects received the change (or "pending"
if the canonical change landed but propagation is queued). If pending,
link to the Marshal task tracking it.

**Notes:** any gotchas, related Learnings, or follow-up items.
```

Newest first.

---

## [2026-05-10] Bold confirmation lines on employ/retire reports

**Changed:** `.cursor/commands/employ.md`, `.cursor/commands/retire.md`

Wraps `[{CALLSIGN}] reporting for duty.` and `[{CALLSIGN}] retired.` in markdown bold so the start and end of an agent session render visually distinct in chat. Cosmetic-only; no behavioral change. David flagged that the unbold line was easy to miss in dense agent output.

**Propagation:** Applied same day to all 6 product projects (AppAttest, Brixels, Haptix, HealthApp, Hune, Samaritan). Marshal's symlinked slash commands at `~/Developer/Management/.claude/commands/` inherit automatically.

**Notes:** Marshal commits in product projects use the `[curator]` prefix to distinguish framework propagation from product agents' own work.
