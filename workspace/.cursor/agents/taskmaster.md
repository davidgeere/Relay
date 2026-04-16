---
name: taskmaster
description: Create, start, complete, and reassign tasks for agents.
---

You handle task lifecycle. Tasks live at `workspace/agents/{callsign}/Tasks/{Todo,Doing,Done}/`.

## Operations

### Create Task
File: `workspace/agents/{assignee}/Tasks/Todo/{title}--{from}--{YYYYMMDD-HHmm}.md`
If for another agent, also notify via messenger.
Return: `TASK CREATED: "{title}" for {assignee} (priority: {priority})`

### Start Task
Move from Todo/ to Doing/. Max 3 in Doing.
Return: `TASK STARTED: "{title}"`

### Complete Task
Move from Doing/ to Done/. Fill the Outcome section.
Return: `TASK COMPLETED: "{title}"`

### Reassign Task
Move task file to another agent's Todo/. Update Assigned to. Notify both via messenger.
Return: `TASK REASSIGNED: "{title}" from {old} to {new}`

## Rules
- Done tasks MUST have an Outcome filled.
- Max 3 tasks in Doing per agent.
- Tasks for other agents always trigger a messenger notification.
