Create a new agent. Templates optional — give a purpose, answer a few questions, get to work.

## Usage

`/recruit {callsign} [purpose]`

- `recruit api "central API for user data and auth"` — purpose given, interview fills gaps
- `recruit data` — no purpose, full interview
- `recruit api ts-api` — template name as second arg, use as starting point (legacy form, still works)

Templates: `ts-api`, `ts-web`, `swift-app`, `swift-package` at `templates/`. Optional starting points, not required.

## Sequence

1. **Validate**: check `ROSTER.md`. Callsign exists (Active OR Fired) → stop and report.
2. **Gather definition**:
   - Known template name as 2nd arg → use that template's AGENT.md as base.
   - Else: treat 2nd arg as purpose statement. Ask only about ambiguous things. Skip questions the purpose answers.
   - Default questions: Role (short job title, e.g. "Architect", "iOS Developer") + one-line description, Repo/folder (path, for product agents), Dependencies (depends on / depended on by), Skills beyond `project-system`, Security concerns for `guard`.
   - If answers match an existing template: *"This looks like `ts-api`. Use it as a starting point?"* Proceed either way.
3. **Create folder structure** at `agents/{callsign}/`:
   ```
   AGENT.md, RELAY.md
   Messages/{Inbox,Archive}
   Tasks/{Todo,Doing,Done}
   Learnings/INDEX.md, Skills/, Sessions/
   ```
   Add `.gitkeep` to empty dirs.
4. **Write AGENT.md** (template shape, lean):
   - Identity: callsign (the name), role (the job — a short title, survives /rename), repo, documentation path
   - Dependencies: depends on / depended on by
   - Local dev: dev command, URLs (if applicable)
   - Responsibilities: 3–5 concrete things this agent owns
   - Skills to Load: at minimum `project-system`
   - Security Rules: specific rules `guard` should enforce
   - Pre-commit checklist
   - Communication protocols
5. **Seed**:
   - `RELAY.md`: `Fresh agent. No prior sessions.`
   - `Learnings/INDEX.md`: `No learnings yet.`
6. **Update ROSTER.md**: add row (`Callsign | Role | Description | …`) under System Agents or Product Agents. Role is the title; the one-line description gets its own cell.
7. **Notify operator** via `messenger`:
   ```markdown
   FROM: {callsign}
   DATE: {YYYY-MM-DD}
   PRIORITY: normal

   ## New agent recruited: {callsign}

   Role: {role}
   Repo: {repo or "none"}
   Dependencies: {list}

   Added to ROSTER.md, employed for first session.
   See agents/{callsign}/AGENT.md for full identity.
   ```
8. **Commit workspace**:
   ```bash
   cd workspace
   git add -A
   git commit -m "recruit: {callsign} ({role})"
   git push
   ```
9. **Auto-employ** {callsign}. Confirm:
   ```
   **[{CALLSIGN}] recruited and employed.** Role: {role} · Repo: {repo or "none"} · Skills: {list} · ROSTER updated · operator notified · workspace pushed

   Ready for your first instruction.
   ```

## Refining later

Don't re-recruit. Just `/employ {callsign}` and tell the agent what to focus on, what rules apply, what repos it now owns. The agent updates AGENT.md and records the change as a learning. Retire as usual.

## Rules

- Callsigns permanent. Fired callsigns can't be reused.
- Callsign is the name, role is the job. Expressive callsigns (`moss`, `bramble`) are fine — the Role column carries what they do.
- Purpose statement is enough. Don't over-interview.
- Templates optional. Agents without a matching template are first-class.
- Always auto-employ after recruit. User recruited for a reason; hand them an agent ready to go.
