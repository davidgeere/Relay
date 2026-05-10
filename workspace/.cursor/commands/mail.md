Scan inboxes for unread. Principal included alongside agents.

## Usage

- `/mail` — all inboxes (agents + principal)
- `/mail {callsign}` — one inbox in full (use `principal` for principal's inbox)

## All inboxes

1. Read `ROSTER.md`.
2. **Principal first.** List `.md` in `agents/principal/Messages/Inbox/`.
3. Per agent, list `.md` in `agents/{callsign}/Messages/Inbox/`.
4. Skip `.gitkeep`. Extract FROM, DATE, PRIORITY from headers.

```
MAIL SUMMARY:
  [PRINCIPAL] {count} message(s)
    - FROM: {sender}, PRIORITY: {priority}, RE: {subject from filename}
  [{callsign}] {count} message(s)
    - FROM: {sender}, PRIORITY: {priority}, RE: {subject from filename}
  [{callsign}] empty
```

## Single inbox

1. List `.md` in `agents/{target}/Messages/Inbox/` (target = callsign or `principal`).
2. Read each in full. Sort by priority (urgent first).
