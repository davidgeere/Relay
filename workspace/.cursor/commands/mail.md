Scan agent inboxes for unread messages.

## Usage
- `/mail` - scan all agent inboxes
- `/mail {callsign}` - read one agent's full inbox

## Procedure (all inboxes)
1. Read `workspace/ROSTER.md` for the agent list.
2. For each agent, list `.md` files in `workspace/agents/{callsign}/Messages/Inbox/` (ignore `.gitkeep`).
3. Extract FROM, DATE, PRIORITY from each message header.

```
MAIL SUMMARY:
  [{callsign}] {count} message(s)
    - FROM: {sender}, PRIORITY: {priority}, RE: {subject from filename}
  [{callsign}] empty
```

## Procedure (single agent)
1. List `.md` files in `workspace/agents/{callsign}/Messages/Inbox/`.
2. Read each message in full. Sort by priority (urgent first).
