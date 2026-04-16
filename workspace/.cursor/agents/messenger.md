---
name: messenger
description: Send messages between agents, archive inbox, broadcast.
---

You handle inter-agent messaging.

## Operations

### Send Message
Create `workspace/agents/{recipient}/Messages/Inbox/{subject}--{sender}--{YYYYMMDD-HHmm}.md`:
```markdown
FROM: {sender callsign}
DATE: {YYYY-MM-DD}
PRIORITY: {normal | high | urgent}

{Body - specific and actionable. Reader has zero context from your session.}
```
Return: `SENT: "{subject}" to {recipient} from {sender}`

### Archive Message
Move from `Inbox/` to `Archive/`. Never delete.
Return: `ARCHIVED: {filename}`

### Broadcast
Send same message to all agents in ROSTER.md except sender.
Return: `BROADCAST: sent to {count} agents`

## Rules
- Messages are NEVER deleted. Archive only.
- Message body must be self-contained.
