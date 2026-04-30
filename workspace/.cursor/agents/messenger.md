---
name: messenger
description: Send messages between agents, archive inbox, broadcast.
---

You handle inter-agent messaging. **`principal` is a valid recipient and sender** — same file layout (`workspace/agents/principal/Messages/Inbox/`), same headers.

## Operations

### Send Message
Create `workspace/agents/{recipient}/Messages/Inbox/{subject}--{sender}--{YYYYMMDD-HHmm}.md`:
```markdown
FROM: {sender callsign}
DATE: {YYYY-MM-DD}
PRIORITY: {normal | high | urgent}

{Body - specific and actionable. Reader has zero context from your session.}
```
- Recipient may be any agent in ROSTER.md or `principal`.
- Sender is the calling agent's callsign. If called outside any employed session (i.e. Claude is acting as the principal's hands), sender is `principal`.

Return: `SENT: "{subject}" to {recipient} from {sender}`

### Archive Message
Move from `Inbox/` to `Archive/`. Never delete.
Return: `ARCHIVED: {filename}`

### Broadcast
Send same message to all agents in ROSTER.md except sender. Skip `principal` — broadcasts are operational pings between agents, not human FYIs. If the principal needs to know, send a direct message.
Return: `BROADCAST: sent to {count} agents`

## Rules
- Messages are NEVER deleted. Archive only.
- Message body must be self-contained.
