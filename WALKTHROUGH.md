# Walkthrough: A Day in Relay

This is a narrative walkthrough of how Relay works in practice. We'll ship a small feature — "favorites" on a bookmark app — from empty repo to deployed staging. You'll see what agents do, what files they touch, and how the baton passes between sessions.

The scenario is fake. The file contents are real — this is what the system actually produces.

---

## The Setup

You've cloned Relay into a project that already has `api/` and `app/` repos. You ran `setup.sh`. Symlinks are in place. Four system agents exist in `workspace/agents/`:

- **architect** — reads code, writes specs
- **operator** — PM, decomposes specs into tasks
- **librarian** — owns `documentation/`
- **reviewer** — black-box tester

No product agents yet. We need to recruit them.

---

## Day 1: Recruit the team

You open Cursor (or Claude Code) and type:

```
employ operator
```

Operator boots. Reads `agents/operator/AGENT.md`. Reads `RELAY.md` (empty — "Fresh agent. No prior sessions."). Reports:

```
[OPERATOR] reporting for duty.
Relay: fresh agent, no prior context
Doing: 0
Todo: 0
Inbox: 0
Ready to plan.
```

You tell operator: *"We need api and app agents. API is a TypeScript Fastify service, app is a Next.js frontend."*

Operator runs `recruit api "central bookmark API, TypeScript Fastify"`. The system recognizes the purpose matches the `ts-api` template and offers it as a starting point. Operator accepts. It asks one clarifying question: *"What does api depend on? (e.g. Database)"* Operator answers. The agent folder is created, ROSTER updated, welcome message sent to operator's inbox, and **api is immediately employed** so you could start working as api right now if you wanted.

Operator does the same for `recruit app "Next.js frontend for bookmarks"` — matches `ts-web` template. api is listed as its dependency. Auto-employed.

You switch back to operator and retire it:

```
retire
```

Operator captures what it just did — the roster now has 6 agents, templates applied, repos declared — rewrites its RELAY.md, commits the workspace.

---

## Day 2: The spec

You want to add "favorites" to the bookmark app. Users click a star, it gets saved, they see their favorites list.

```
employ architect
```

Architect reads the api repo, the app repo, and the existing documentation. Doesn't write any code. Produces a spec at `documentation/specs/favorites.md`:

```markdown
# Feature: Bookmark Favorites

## Summary
Users can mark bookmarks as favorites. Favorites appear first in their list
and are also browsable as a separate view.

## API Changes
- New table: `favorites(user_id, bookmark_id, created_at)`
- POST `/bookmarks/:id/favorite` — toggles
- GET `/bookmarks/favorites` — list

## App Changes
- Star icon on BookmarkCard, toggles via API
- New /favorites route showing the list
- BookmarkList sorts favorites first

## Dependency Graph
api → app

## Open Questions
- Do favorites sync across devices? (Assumed yes, since they're server-side.)
- Max favorites limit? (No, initial version.)
```

Architect retires. The spec is in `documentation/`.

---

## Day 3: Decompose

```
employ operator
```

Operator reads the new spec. Breaks it into tasks:

**For api** (`agents/api/Tasks/Todo/add-favorites-endpoints--operator--20260416-1030.md`):

```markdown
# Add favorites endpoints

- **From:** operator
- **Assigned to:** api
- **Created:** 2026-04-16T10:30:00Z
- **Priority:** normal

## Description
Implement favorites feature per documentation/specs/favorites.md.
Migration + two endpoints (toggle, list).

## Acceptance Criteria
- Migration applied to staging
- POST /bookmarks/:id/favorite returns 200, toggles state
- GET /bookmarks/favorites returns user's favorites
- Integration tests against staging pass
- Blocks: app (needs these endpoints)

## Notes

## Outcome
```

**For app:** same shape, blocked until api deploys.

Operator sends messages to api and app via the messenger subagent, then retires.

---

## Day 4: Build the API

```
employ api
```

API agent boots. Briefer compiles the dossier:
- Relay: fresh
- Doing: 0
- Todo: 1 — "Add favorites endpoints"
- Inbox: 1 new from operator

Tester runs baseline. Green.

API picks up the task, moves it to Doing. Writes the migration file. Runs the tester subagent — new migration compiles but tests fail (no test for the new endpoint yet). API writes the endpoint, writes tests, runs tester again. Green.

API calls `deployer stage`:

1. Guard scans. Checks AGENT.md security rules. Looks for exposed keys. Pass.
2. Creates feature branch, commits, pushes.
3. Opens PR to `staging`.
4. Verifies staging deployed healthy.
5. Returns:

```
STAGED: api -> staging
  Branch: feature/favorites-endpoints
  Guard: PASS
  PR: #42 (https://github.com/you/api/pull/42)
  Status: READY
```

API calls `handoff`:
- Moves task to Done with Outcome: "Deployed to staging. Endpoints at /bookmarks/:id/favorite and /bookmarks/favorites."
- Notifies app agent: *"Your blocker is resolved. Endpoints live on staging."*
- Notifies operator: "Phase complete."

API retires. Workspace committed.

---

## Day 5: Build the app

```
employ app
```

App boots. Inbox has a high-priority message from api: *"Your blocker is resolved."* The Todo task is now actionable.

App reads the spec, reads the api's Outcome (knows the exact endpoints), builds the star component, the /favorites route, the sort logic. Stages. Hands off.

Operator gets notified: "Phase complete — app side of favorites shipped to staging."

---

## Day 6: Review

```
employ reviewer
```

Reviewer cannot read source. It reads `documentation/specs/favorites.md` and tests the product on staging like a user would:

- Opens the app
- Clicks a star — does it persist?
- Navigates to /favorites — is the bookmark there?
- Refreshes — does it stick?
- Opens on another browser — does it sync?

Reviewer files one bug as a task assigned to app: *"Unstar animation stutters on slow connections."* Messages app. Retires.

---

## Day 7: Ship it

Operator runs `status`:

```
PIPELINE STATUS

api      ✓ Done: Add favorites endpoints (deployed)
app      ◐ Doing: Fix unstar animation stutter
reviewer ✓ Done: Favorites review (1 bug filed)
```

App fixes the bug, stages, deploys. Calls `deployer deploy` to promote staging → main. Feature shipped.

---

## What just happened

Seven sessions across four different agents. No one had to be re-briefed. The spec was written once, the API built against it, the app built against the API's Outcome, the reviewer tested against the spec. Every session started with a dossier of exactly what was relevant and ended with a clean handover.

If any session had died mid-work — context window blown, laptop closed, whatever — the next session would have picked up from the RELAY.md and the tasks in Doing. No lost state.

This is the whole point. Agents are identities, not chat sessions. The filesystem is the memory. Git is the backup.

---

## Next Steps

- Read [workspace/CLAUDE.md](workspace/CLAUDE.md) for the full protocol
- Run `guide` (Claude Code) or `/guide` (Cursor) inside the system for a reference card
- Recruit your own product agents with `recruit {callsign} {template}`
