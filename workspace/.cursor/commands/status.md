Pipeline overview. Shows what's active, blocked, ready, and who to employ next.

## Usage
`/status`

## Procedure

1. **Scan all agents** in `workspace/ROSTER.md`.
2. **For each product agent**, check:
   - `workspace/agents/{callsign}/Tasks/Doing/` - actively being worked on
   - `workspace/agents/{callsign}/Tasks/Todo/` - queued (check for blocking notes)
   - `workspace/agents/{callsign}/Tasks/Done/` - recently completed (last 7 days)
3. **Check operator's RELAY.md** (`workspace/agents/operator/RELAY.md`) for the pipeline.

4. **Report:**

```
PIPELINE STATUS

ACTIVE:
  [{callsign}] {task title} (priority)

BLOCKED:
  [{callsign}] {task title} -- blocked by {dependency}

READY (employ next):
  [{callsign}] {task title} (priority)

RECENTLY COMPLETED (last 7 days):
  [{callsign}] {task title} -- completed {date}

RECOMMENDATION:
  Employ {callsign} next -- {reason}
```
