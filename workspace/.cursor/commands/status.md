Pipeline overview. Active, blocked, ready, who to employ next.

## Usage

`/status`

## Procedure

1. Scan all agents in `ROSTER.md`.
2. Per product agent, check:
   - `Tasks/Doing/` — actively being worked on
   - `Tasks/Todo/` — queued (check for blocking notes)
   - `Tasks/Done/` — recently completed (last 7 days)
3. Check operator's `RELAY.md` for pipeline state.

## Report

```
PIPELINE STATUS

ACTIVE:
  [{callsign}] {task title} (priority)

BLOCKED:
  [{callsign}] {task title} — blocked by {dependency}

READY (employ next):
  [{callsign}] {task title} (priority)

RECENTLY COMPLETED (last 7 days):
  [{callsign}] {task title} — completed {date}

RECOMMENDATION:
  Employ {callsign} next — {reason}
```
