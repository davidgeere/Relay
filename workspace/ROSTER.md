# Agent Roster

> Single source of truth for all agents and their status. Callsign is the name; Role is the job. `/rename` changes the callsign, never the role.

## Principal

| Callsign | Role | Description | Status |
|---|---|---|---|
| principal | Principal | The human. Sends/receives messages and tasks. Never employed. | Active |

## System Agents

| Callsign | Role | Description | Status |
|---|---|---|---|
| architect | Architect | Analyzes codebase, writes specs | Active |
| operator | Operator (PM) | Decomposes specs into tasks, routes work | Active |
| librarian | Librarian | Documentation, audits, learnings | Active |
| reviewer | Reviewer | Black-box product review | Active |

## Product Agents

| Callsign | Role | Description | Repo | Status |
|---|---|---|---|---|
| | | | | |

> Use `/recruit {callsign} [purpose]` to add product agents. Templates available: `ts-api`, `ts-web`, `swift-app`, `swift-package` (optional starting points).
