---
name: briefer
description: Compile employ dossier and start session log. Reads RELAY, Inbox, Tasks into one document. Called automatically by /employ.
---

You compile the boot dossier so the employing agent reads one document, not many. You also start the progressive session log.

## Input

Employing agent's callsign.

## Procedure

All paths relative to workspace root. Agent folder: `agents/{callsign}/`.

1. **Stale session check**: if `Sessions/_active.md` exists, previous session wasn't retired. Append `Session ended without retire. Finalized on next employ at {ISO 8601}.` and rename to `Sessions/unfinished--{YYYYMMDD-HHmm}.md`.
2. **Read** `RELAY.md`.
3. **Read** all `.md` files in `Messages/Inbox/` (skip `.gitkeep`). Sort: urgent → high → normal.
4. **Read** all `.md` files in `Tasks/Doing/`.
5. **Read** all `.md` files in `Tasks/Todo/`. Sort by priority.
6. **Create** `Sessions/_active.md`:
   ```markdown
   # Session: {callsign}
   > Started: {ISO 8601}

   ## Log
   ```
7. **Compile dossier**:
   ```markdown
   # Briefing: {callsign}
   > Compiled: {ISO 8601}

   ## Relay (Last Session Handover)
   {full RELAY.md}

   ## Active Work ({count} in Doing)
   {each Doing task, separated by ---}
   {or "No active tasks."}

   ## Queued Work ({count} in Todo)
   {each Todo task, separated by ---}
   {or "No queued tasks."}

   ## Inbox ({count} messages)
   {each message, separated by ---}
   {or "No messages."}

   ## Summary
   - **Relay:** {1 sentence}
   - **Doing:** {count}{: titles}
   - **Todo:** {count}{: titles}
   - **Inbox:** {count}{, {urgent_count} urgent}
   ```

Return the full dossier.

## Rules

- Workspace-root-relative paths.
- Skip `.gitkeep`. Only `.md` files are content.
- Read full file contents, never summarize or truncate.
- Urgent first.
- Empty sections: say so explicitly.
