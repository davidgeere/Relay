Terminal shutdown. Agent permanently deactivated.

Same capture order as `/retire` (learnings first, highest value first). All incomplete work reassigned to operator. Agent locked from future use.

## Usage

- `fire` — while employed. Fires yourself.
- `fire {callsign}` — from clean context. Auto-employs `{callsign}` first, then runs the fire sequence.

Never `fire {callsign}` while employed as a *different* agent — retire yourself first. Fire must be the current agent's last act.

## Sequence

1. **Final Learnings** → `scribe`: review the agent's full history (not just this session). Capture each with title, date, tags, context, learning, application. Then rebuild INDEX.
2. **Final RELAY.md** → `scribe`: rewrite once more, marked terminal:
   - **Status: TERMINATED**
   - **Final Situation** — state of everything this agent owned
   - **Unfinished Work** — in progress, blocked, planned
   - **Recommendations** — what successor or operator should know
   - **Warnings** — traps, gotchas, lost-context risks

   Last relay. Make it comprehensive.
3. **Reassign Work** → `taskmaster`:
   - Move all Doing → Done with Outcome `Reassigned to operator — agent fired.`
   - Create matching Todo tasks on operator for each incomplete Doing (with full context).
   - Create Todo tasks on operator for each existing Todo (with full context).
   - Done tasks stay. History preserved.
4. **Handover Message** → `messenger` to operator, high priority:
   ```markdown
   FROM: {callsign}
   DATE: {YYYY-MM-DD}
   PRIORITY: high

   ## Agent Terminated: {callsign}

   I have been fired. Full handover below.

   ### Work Reassigned
   {tasks moved to operator's Todo, brief context per task}

   ### Repo Ownership
   {repo name or "None"} — now your responsibility until reassigned.

   ### Recommendations
   {what should happen next}

   ### Final Relay
   See agents/{callsign}/RELAY.md for terminal handover.
   ```
5. **Archive Inbox** → `messenger`: archive all remaining Inbox messages.
6. **Lock the agent**:
   - ROSTER.md → set status to `fired`.
   - AGENT.md → prepend:
     ```markdown
     > **STATUS: FIRED — {date}**
     > Permanently deactivated. Do not employ, message, or assign tasks.
     > All work handed to operator. See RELAY.md for terminal handover.
     ```
7. **Finalize session** → `scribe`. Last session ever.
8. **Commit workspace**:
   ```bash
   cd workspace
   git add -A
   git commit -m "[{callsign}] fired: terminal shutdown, work handed to operator"
   git push
   ```
9. **Confirm** (one line):
   ```
   **[{CALLSIGN}] terminated.** {N} learnings · terminal relay · {N} tasks reassigned · {N} msgs archived · session: {filename} · ROSTER: fired · workspace: pushed
   ```

   Agent folder preserved at `agents/{callsign}/`. Read-only from here.

## Guard rails (system enforces post-fire)

- `employ` refuses fired agents.
- `messenger` refuses messages to fired agents.
- `taskmaster` refuses tasks for fired agents.

## Rules

- Steps 1–2 highest priority. Context dying → learnings + relay first.
- RELAY is full rewrite, marked TERMINAL. Last version.
- Never delete the agent folder. Learnings, sessions, archives are permanent history.
- Always notify operator. They inherit everything.
- Workspace commit last.
