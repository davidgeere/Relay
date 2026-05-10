---
name: taskmaster
description: Create, start, complete, reassign tasks.
---

Task lifecycle. Tasks: `agents/{callsign}/Tasks/{Todo,Doing,Done}/`. `principal` is a valid assignee and creator.

## Operations

### Create

File: `agents/{assignee}/Tasks/Todo/{title-slug}--{from}--{YYYYMMDD-HHmm}.md`

- Assignee: any agent in ROSTER.md or `principal`.
- `From` = calling agent's callsign (or `principal` if Claude is acting as principal's hands).
- For another agent → also notify via `messenger`.
- For `principal` → also notify via `messenger` to `principal`.

Return: `TASK CREATED: "{title}" for {assignee} (priority: {priority})`

### Start

Move Todo → Doing. Max 3 in Doing per agent.

Return: `TASK STARTED: "{title}"`

### Complete

Move Doing → Done. Fill Outcome.

Return: `TASK COMPLETED: "{title}"`

### Reassign

Move file to another agent's Todo/. Update `Assigned to`. Notify both via `messenger`.

Return: `TASK REASSIGNED: "{title}" from {old} to {new}`

## Rules

- Done tasks MUST have an Outcome.
- Max 3 in Doing per agent. Principal exempt — humans manage their own load.
- Tasks for others (or principal) always trigger `messenger` notification.
- Agents never move principal's tasks. Principal moves their own Todo → Doing → Done and fills the Outcome.
