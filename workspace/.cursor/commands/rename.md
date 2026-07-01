Rename an agent. Changes its callsign and moves its folder. History and old references stay resolvable via a tombstone. The role (job title) is untouched — a rename changes the name, never the job.

## Usage

- `rename to "{new name}"` — while employed. Renames yourself; you finish the session as the new agent.
- `rename "{old callsign}" to "{new name}"` — from clean context. Pure file surgery; the target is not employed.

`{new name}` is slugified to a callsign: lowercased, spaces and punctuation become hyphens (`"New Name"` → `new-name`). The slug is the real identity (folder + addressing); the quotes just let you type naturally.

## Validate (stop and report on any failure)

1. Resolve `old` (current callsign for the self-form) and `new` (slugified).
2. `new` must be a valid slug (`^[a-z0-9-]+$`, non-empty).
3. `new` must NOT already exist in `ROSTER.md` — active, fired, or tombstoned. Collision → stop.
4. `old` must exist and be **Active**. Fired or tombstoned → stop (those states are terminal).
5. `old == new` → nothing to do, report and stop.

## Sequence (forward-only — never rewrite history)

1. **Move folder** `agents/{old}/` → `agents/{new}/`.
2. **AGENT.md** (in the moved folder): update the identity callsign `old` → `new`. Leave the Role line untouched. Prepend one line: `> Renamed from {old} on {YYYY-MM-DD}.`
3. **ROSTER.md**: change the agent's row callsign `old` → `new`. Under a `## Renames` ledger (create the section if absent), add a row `| {old} | {new} | {YYYY-MM-DD} |`. `{old}` is now a **tombstone** — recognized, never reusable.
4. **Live cross-refs only** — grep the workspace for the bare token `{old}` and rewrite it where it is a *live* reference:
   - Other agents' `AGENT.md` dependency lists (depends on / depended on by).
   - Open tasks under `agents/*/Tasks/Todo/` and `agents/*/Tasks/Doing/`.
   - Unarchived messages under `agents/*/Messages/Inbox/` (FROM:/TO: routing lines).
   - `PROJECT.md` / `PRINCIPAL.md` where they name the agent operationally.
5. **Leave history untouched**: `Tasks/Done/`, `Messages/Archive/`, `Sessions/`, `Learnings/`, and prior `RELAY.md` bodies. The tombstone + breadcrumb keep them resolvable; rewriting permanent record is forbidden.
6. **Self-form only**: update `Sessions/_active.md` to the new path. You ARE `{new}` for the rest of the session.

## Notify

`messenger` to operator, normal priority: agent `{old}` is now `{new}` as of {date}; update any addressing. (If you ARE operator being renamed, skip the message and note it in the confirm line.)

## Commit workspace

Resolve the git root (`git -C workspace rev-parse --show-toplevel` — for product projects the root IS `workspace/`). Stage **explicit paths only** — the moved folder (old path deletion + new path), `ROSTER.md`, and each edited file. **Never `git add -A`** in an active workspace (it bundles other agents' uncommitted work). Verify `git diff --cached --name-only` equals what you intended, then:

```
git commit -m "rename: {old} → {new}"
git push
```

## Confirm (one line)

```
**[{NEW}] renamed.** was {old} · still {role} · folder moved · ROSTER + {N} live refs updated · history preserved (tombstone) · operator notified · workspace: pushed
```

## Rules

- The slug IS the name. No separate display label — the callsign is the identity everywhere.
- Rename changes the callsign, never the role. To change an agent's job, employ it and edit AGENT.md + ROSTER deliberately.
- Forward-only. Never rewrite Archive / Done / Sessions / Learnings / old RELAY — permanent record.
- Old callsign is a tombstone: never reusable (same permanence as fired callsigns).
- Collisions refuse. ROSTER is the single source of truth.
- A fired agent cannot be renamed. Fired is terminal.
