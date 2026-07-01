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

## [v2.3.0 — 2026-07-01] Role is first-class: callsign = name, role = job

**Changed:** `CLAUDE.md` (new "Callsign and Role" section; System Agents table reframed as roles with default callsigns), `ROSTER.md` (columns: `Callsign | Role | Description | …` — role title split out of the description), `templates/*/AGENT.md` (Role line is a short job title), `.cursor/commands/recruit.md` (asks for role title + one-line description; ROSTER row shape), `.cursor/commands/rename.md` (rename never touches role; confirm line says "still {role}"), `.cursor/commands/guide.md` (role notes).

Expressive callsigns (`moss`, `bramble`) stopped carrying the job the way functional ones (`architect`, `ios`) did. Role is now a crisp, canonical, rename-invariant job title distinct from the callsign; descriptions get their own column. Existing agents' AGENT.md identity blocks convert lazily on next employ; project ROSTERs converted by curator at propagation.

**Propagation:** all 11 installs — Samaritan, Hune, AppAttest, Haptix, Brixels, Okavango, HealthApp, Hauld, plus iCloud: Sam, Emery Calloway, Kaleb-Harrison (iCloud commits local; push best-effort).

**Notes:** same pass delivers `/rename` (v2.2.0) to the 7 installs that still lacked it, closing the pending propagation task. Installs without a workspace `CHANGELOG.md` get one seeded (CLAUDE.md rule 16 references it). Emery Calloway + Kaleb-Harrison were on pre-v2.1.0 `CLAUDE.md`; this pass brings them current.

---

## [v2.2.0 — 2026-06-20] Add /rename command

**Changed:** `.cursor/commands/rename.md` (new), `.cursor/commands/guide.md` (command list).

New lifecycle verb to rename an agent. Two forms: `rename to "{new}"` (self, while employed) and `rename "{old}" to "{new}"` (target, from clean context). The new name is slugified to a callsign; the agent's folder moves and live references (ROSTER, other agents' deps, open Todo/Doing/Inbox) are rewritten. Forward-only: history (Archive, Done, Sessions, Learnings, old RELAY) is left intact, and the old callsign is recorded as a non-reusable tombstone in a ROSTER `## Renames` ledger so stale references stay resolvable.

**Propagation:** Samaritan, Hune, AppAttest, Haptix. Remaining installs (Brixels, Okavango, HealthApp, Hauld, Sam) pending.

**Notes:** Command staging is explicit-paths-only by design (no `git add -A`), per Learning `git-add-all-in-active-workspaces-bundles-other-agents-work`. Zero-touch propagation via symlinking command dirs to canonical is still the standing recommendation; these installs received file copies.

---

## [v2.1.0 — 2026-06-17] Concise-with-principal rule

**Changed:** `CLAUDE.md` (Core Rule 17 + new "Talking to the principal" section).

David runs 40+ agents and cannot read an essay from each. Added a hard rule: lead with the answer/ask, default to a few lines, cut preamble/apologies/filler, and when a decision is needed state the ask + options + recommendation self-contained (don't assume he has context — his buy-in is the scarce resource). Applies to in-session replies AND principal messages.

**Propagation:** applied to all installs (AppAttest, Brixels, Haptix, HealthApp, Hune, Okavango, Samaritan, Sam, Hauld). Self-activating — every agent reads CLAUDE.md at employ; no broadcast (a broadcast would be the noise this rule fights).

**Notes:** David's standing preference, now framework-level.

---

## [v2.0.0 — 2026-05-10] Caveman pass: framework-wide terseness rewrite

**Changed:** every canonical framework file (29 files; 768 insertions, 1,185 deletions; net −417 lines, ~35% reduction).

- All `.cursor/commands/*.md` (10 files): rewritten in caveman style. Dense numbered procedures, imperative dispatch, no meta-explanation.
- All `.cursor/agents/*.md` (6 files): same. Identity + operations + return-line. No defensive scaffolding.
- `.cursor/rules/agent-system.mdc`: consolidated. Core rules + file formats only. Defers to CLAUDE.md for the rest.
- `.cursor/skills/project-system/SKILL.md`: terse template.
- `CLAUDE.md`, `PRINCIPAL.md`, `PROJECT.md`, `ROSTER.md`, `README.md`: caveman-styled, structure preserved.
- `templates/{swift-app,swift-package,ts-api,ts-web}/AGENT.md`: light pass for consistency.

**Behavioral changes (not just cosmetic)**:
- `/retire` confirmation collapsed from 6-line stats block to one bolded line. Verbose closing → run `/report` first.
- **New `/report` command**: standalone verbose state-of-session report. Read-only.
- `/employ` now checks `CHANGELOG.md` at boot and reads recent entries if newer than agent's last RELAY timestamp — so framework drift is surfaced automatically.
- Stronger imperative dispatch to subagents (`Tasks → taskmaster: ...`) replaces softer "tell taskmaster to..." phrasing.
- Confirmation lines for `/employ`, `/retire`, `/debrief`, `/recruit`, `/fire` all bolded for consistency.

**Deleted (orphans, zero references)**:
- `.cursor/agents/deployer.md` — never invoked. Product agents have their own deploy patterns (e.g. Haptix's `distributor`).
- `.cursor/agents/handoff.md` — never invoked. Direct `messenger` calls handle downstream notifications.

**Propagation:** Applied same day to all 6 product projects (AppAttest, Brixels, Haptix, HealthApp, Hune, Samaritan) plus Okavango (which got the v1 framework earlier today and is upgraded in the same pass). Marshal's symlinked slash commands at `~/Developer/Management/.claude/commands/` inherit automatically.

**Notes:**
- Tagged `v2.0.0` in Relay canonical.
- Broadcast messages sent to each project's operator inbox so agents are aware at next employ.
- Zero information loss verified: section descriptions, rules, file formats, and command logic preserved verbatim where they change behavior. Defensive prose, examples-that-repeat-the-rule, and throat-clearing dropped.

## [2026-05-10] Bold confirmation lines on employ/retire reports

**Changed:** `.cursor/commands/employ.md`, `.cursor/commands/retire.md`

Wraps `[{CALLSIGN}] reporting for duty.` and `[{CALLSIGN}] retired.` in markdown bold so the start and end of an agent session render visually distinct in chat. Cosmetic-only; no behavioral change. David flagged that the unbold line was easy to miss in dense agent output.

**Propagation:** Applied same day to all 6 product projects (AppAttest, Brixels, Haptix, HealthApp, Hune, Samaritan). Marshal's symlinked slash commands at `~/Developer/Management/.claude/commands/` inherit automatically.

**Notes:** Marshal commits in product projects use the `[curator]` prefix to distinguish framework propagation from product agents' own work.
