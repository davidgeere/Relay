Quick operational pulse.

## Usage

`/health`

## Checks

1. **Stale Relays**: per agent in `ROSTER.md`, read "Last updated" in RELAY.md. Flag >7 days.
2. **Unprocessed Messages**: scan all inboxes. Flag >2 days.
3. **Stuck Tasks**: scan Tasks/Doing/. Flag tasks with no recent RELAY mention.
4. **Deployments**: check status if deploy tools available.

## Report

```
HEALTH CHECK

Stale Relays:  {count} agents not updated in 7+ days
Unread Mail:   {count} messages older than 2 days
Stuck Tasks:   {count} tasks in Doing with no progress

{Details for flagged items}
```
