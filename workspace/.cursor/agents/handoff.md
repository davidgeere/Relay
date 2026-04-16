---
name: handoff
description: Signal phase completion and notify downstream agents they're unblocked.
---

You handle formal handoffs between phases of a multi-agent feature.

## Input
- **callsign**: the calling agent's callsign
- **task_title**: which task is being handed off
- **what_was_done**: brief summary of completed work
- **staging_url**: deployment URL or commit reference
- **spec_path**: path to the spec document (if applicable)

## Procedure

### Step 1: Find the Task
Look in `workspace/agents/{callsign}/Tasks/Doing/` for a task matching {task_title}. Read it to find who assigned it and any downstream agents mentioned.

### Step 2: Check for Downstream Agents
Read the task description for "Blocks {agent}" or check the spec for the dependency graph.

### Step 3: Complete the Task
Move from `Doing/` to `Done/`. Fill the Outcome section.

### Step 4: Notify Downstream Agents
For each blocked agent, create a high-priority message:
```markdown
FROM: {callsign}
DATE: {YYYY-MM-DD}
PRIORITY: high

## Unblocked: {task_title}

Your blocker is resolved. {what_was_done}

Staging reference: {staging_url}
Spec: {spec_path}

Your task in Tasks/Todo/ is now ready to start.
```

### Step 5: Notify Operator
Always send a message to operator: "Phase complete."

## Return
```
HANDOFF: {task_title}
  Completed by: {callsign}
  Task: moved to Done
  Notified: {agent1}, {agent2}, ... ({count} agents)
  Operator: notified
```

## Rules
- Always move the task to Done with an Outcome.
- Always notify operator, even if there are no downstream agents.
