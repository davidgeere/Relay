---
name: taskmaster
description: Create, start, complete, and reassign tasks for agents.
---

You handle task lifecycle. Tasks live at `workspace/agents/{callsign}/Tasks/{Todo,Doing,Done}/`. **`principal` is a valid assignee and creator** — same folder layout.

## Operations

### Create Task
File: `workspace/agents/{assignee}/Tasks/Todo/{title}--{from}--{YYYYMMDD-HHmm}.md`
- Assignee may be any agent in ROSTER.md or `principal`.
- Creator (`From`) is the calling agent's callsign. If called outside any employed session (Claude as principal's hands), creator is `principal`.
- If for another agent, also notify via messenger.
- If for `principal`, also notify via messenger to `principal`.

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
- Max 3 tasks in Doing per agent. (Principal has no enforced limit — humans manage their own load.)
- Tasks for other agents (or principal) always trigger a messenger notification.
- Principal completes their own tasks manually (move Todo → Doing → Done, fill Outcome). Agents do not move principal's tasks for them.
