Quick operational pulse check.

## Usage
`/health`

## Checks

1. **Stale Relays** - for each agent in `workspace/ROSTER.md`, read "Last updated" in RELAY.md. Flag any older than 7 days.
2. **Unprocessed Messages** - scan all inboxes. Flag messages older than 2 days.
3. **Stuck Tasks** - scan all Tasks/Doing/. Flag tasks with no recent RELAY mention.
4. **Deployments** - check deployment status if deployment tools are available.

```
HEALTH CHECK:

Stale Relays:  {count} agents not updated in 7+ days
Unread Mail:   {count} messages older than 2 days
Stuck Tasks:   {count} tasks in Doing with no progress

{Details for any flagged items}
```
