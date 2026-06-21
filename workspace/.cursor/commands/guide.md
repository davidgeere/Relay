System reference. All commands, subagents, agents, how they fit.

## Usage

`/guide` or `/help`

## Report

```
╔════════════════════════════════════════════════════════════╗
║                  RELAY - SYSTEM GUIDE                      ║
╚════════════════════════════════════════════════════════════╝

--- COMMANDS ---

  Boot / switch / terminate (clean context):
    /employ {callsign}    Boot an agent. You ARE them for the session.
    /recruit {callsign} [purpose]
                          New agent. Interviews for gaps, auto-employs.
    /rename "{old}" to "{new}"
                          Rename an agent. Folder + live refs move,
                          old name tombstoned. History preserved.
    /fire {callsign}      Terminal shutdown of another agent.

  In-session (while employed):
    /retire               Shutdown. Capture learnings, relay, tasks, msgs.
    /report               Verbose state-of-session report. Read-only.
    /debrief              Mid-session checkpoint. Save, keep working.
    /rename to "{new}"    Rename yourself. Continue as the new agent.
    /fire                 Fire yourself. Terminal shutdown of current agent.

  System-wide (safe anytime):
    /status               Pipeline view. Active, blocked, ready.
    /mail                 Scan all inboxes. /mail {callsign} for one.
    /health               Quick pulse. Stale relays, stuck tasks, unread.
    /audit                Deep sweep. Agent health, doc quality, gaps.
    /guide                You're looking at it.

--- SUBAGENTS (called by agents during sessions) ---

  briefer     RELAY + Inbox + Tasks → one dossier. Starts session log.
  scribe      Progressive log + knowledge capture. Learnings, RELAY,
              INDEX, session finalization.
  taskmaster  Create, start, complete, reassign tasks.
  messenger   Send messages, archive inbox, broadcast.
  tester      Run the repo's test suite (typecheck, lint, build, tests).
  guard       Security scan. Universal + agent-specific.
              CRITICAL issues block deploy.

--- TYPICAL AGENT SESSION ---

  /employ {callsign}
    | briefer compiles dossier + starts session log
    | tester runs baseline (product agents only)
    → agent reports for duty
  work...
    | scribe log: actual code, decisions, errors
    | tester (check it compiles)
  more work...
    | guard (pre-deploy security check)
  verify on staging...
    | hand off to downstream via messenger
  /retire
    | scribe captures learnings + rewrites relay
    | scribe finalizes session log
    | taskmaster moves tasks to Done, creates follow-ups
    | messenger sends pending, archives inbox
    | git commit + push workspace

--- TYPICAL SESSION FLOW ---

  /status              → see pipeline, decide who to employ
  /employ architect    → describe feature, architect writes spec
  /retire              → spec handed off to operator
  /employ operator     → reads spec, decomposes into agent tasks
  /retire              → tasks + messages in every agent's inbox
  /status              → confirm pipeline, see who's ready
  /employ api          → api finds task, builds, stages, deploys, hands off
  /retire
  /employ sdk          → sdk finds task, unblocked by api, builds...
  ...continue until feature complete...
  /employ reviewer     → reviews product, files bugs

--- SYSTEM AGENTS (4 primitives, always included) ---

  architect   Analyzes what needs to change. Reads all code, writes none.
              Produces spec documents. Hands to operator.
  operator    PM. Receives specs, decomposes, routes work. Owns pipeline.
  librarian   Owns documentation/. Sweeps learnings into architecture docs.
              Audits. Keeps docs accurate.
  reviewer    Black-box product review. Enforced ignorance (no source).
              Tests like a user.

  (Add product agents with /recruit)

--- KEY FILES ---

  Per agent:
    AGENT.md       Identity. Who am I, what do I own.
    RELAY.md       The baton. Handover from last session.
    Messages/      Inbox/ + Archive/. Files are the bus.
    Tasks/         Todo/ → Doing/ → Done/. Kanban via folders.
    Learnings/     Insights that persist. INDEX.md auto-generated.
    Sessions/      Near-verbatim session logs.

  Workspace (symlinked into project root):
    workspace/ROSTER.md             All agents + status.
    workspace/agents/{callsign}/    Agent folders.
    workspace/.cursor/              Rules, commands, skills, subagents.
    workspace/PRINCIPAL.md          Human's preferences, style, context.
                                    Read at every employ.
    workspace/PROJECT.md            Project-specific context. Read at employ.
    workspace/CLAUDE.md             Generic Relay protocol.
    workspace/CHANGELOG.md          Framework changes. Check on employ.
    workspace/templates/            Agent templates for /recruit.

--- CORE RULES ---

  1.  Files are the protocol. No state outside the filesystem.
  2.  RELAY.md always full rewrite. Never append.
  3.  Learnings INDEX auto-generated. Never hand-edited.
  4.  Messages never deleted. Archive only.
  5.  Tasks track kanban. Done tasks always have Outcome.
  6.  Retire order: Learnings → RELAY → Tasks → Messages → Session.
  7.  Skip .gitkeep. Only .md files are content.
  8.  Delegate file mechanics to subagents. Agents think, subagents write.
  9.  Never mock tests. Hit real staging. A mocked test is a lie.
  10. Always commit workspace on retire.
  11. Never touch repos you don't own. READ anywhere. WRITE only to your
      repo. Message the owning agent for changes elsewhere.
  12. Read PRINCIPAL.md every employ. Update on standing corrections.
      Same lesson never taught twice.
```
