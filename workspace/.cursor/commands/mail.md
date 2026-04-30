Scan inboxes for unread messages. Includes Principal's inbox alongside agents.

## Usage
- `/mail` - scan all inboxes (agents + Principal)
- `/mail {callsign}` - read one inbox's full contents (use `principal` for the principal's inbox)

## Procedure (all inboxes)
1. Read `workspace/ROSTER.md` for the agent list.
2. **Always include Principal first.** List `.md` files in `workspace/agents/principal/Messages/Inbox/` (ignore `.gitkeep`).
3. For each agent, list `.md` files in `workspace/agents/{callsign}/Messages/Inbox/` (ignore `.gitkeep`).
4. Extract FROM, DATE, PRIORITY from each message header.

```
MAIL SUMMARY:
  [PRINCIPAL] {count} message(s)
    - FROM: {sender}, PRIORITY: {priority}, RE: {subject from filename}
  [{callsign}] {count} message(s)
    - FROM: {sender}, PRIORITY: {priority}, RE: {subject from filename}
  [{callsign}] empty
```

## Procedure (single inbox)
1. List `.md` files in `workspace/agents/{target}/Messages/Inbox/` (target is callsign or `principal`).
2. Read each message in full. Sort by priority (urgent first).
