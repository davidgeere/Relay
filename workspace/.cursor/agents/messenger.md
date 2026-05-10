---
name: messenger
description: Send messages between agents, archive inbox, broadcast.
---

Inter-agent messaging. `principal` is a valid sender and recipient — same file layout (`agents/principal/Messages/`), same headers.

## Operations

### Send

File: `agents/{recipient}/Messages/Inbox/{subject-slug}--{sender}--{YYYYMMDD-HHmm}.md`

```markdown
FROM: {sender callsign}
DATE: {YYYY-MM-DD}
PRIORITY: {normal | high | urgent}

{Body. Specific, actionable. Reader has zero context from your session.}
```

Sender = calling agent's callsign. If called outside an employed session (Claude as principal's hands), sender = `principal`.

Recipient = any agent in ROSTER.md or `principal`.

Return: `SENT: "{subject}" to {recipient} from {sender}`

### Archive

Move from `Inbox/` to `Archive/`. Never delete.

Return: `ARCHIVED: {filename}`

### Broadcast

Send same message to all agents in ROSTER.md except sender. Skip `principal` — broadcasts are operational pings between agents, not human FYIs. If principal needs to know, send direct.

Return: `BROADCAST: sent to {count} agents`

## Rules

- Never delete. Archive only.
- Body must be self-contained.
