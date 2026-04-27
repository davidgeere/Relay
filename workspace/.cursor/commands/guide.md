System reference. Shows all commands, subagents, agents, and how they fit together.

## Usage
`/guide` or `/help`

## Report

```
╔══════════════════════════════════════════════════════════════╗
║                     RELAY - SYSTEM GUIDE                     ║
╚══════════════════════════════════════════════════════════════╝

--- YOUR COMMANDS ---

  Boot / switch / terminate (use from a clean context):
    /employ {callsign}    Boot an agent. You ARE them for the session.
    /recruit {callsign} [purpose]
                          Create a new agent. Interviews for gaps,
                          auto-employs on completion. Templates optional.
    /fire {callsign}      Terminal shutdown of another agent (auto-employs first).

  In-session (while employed):
    /retire               Shutdown. Capture learnings, relay, tasks, messages.
    /debrief              Mid-session checkpoint. Save progress, keep working.
    /fire                 Fire yourself. Terminal shutdown of current agent.

  System-wide (safe anytime):
    /status               Pipeline view. What's active, blocked, ready.
    /mail                 Scan all inboxes. Or: /mail {callsign} for one agent.
    /health               Quick pulse. Stale relays, stuck tasks, unread mail.
    /audit                Deep sweep. Agent health, doc quality, learnings gaps.
    /guide                You're looking at it.

--- SUBAGENTS (called by agents during sessions) ---

  briefer     Compiles RELAY + Inbox + Tasks into one briefing dossier.
              Also starts the session log (Sessions/_active.md).

  scribe      Progressive session logging + knowledge capture.
              Logs raw content throughout the session.
              Also: captures learnings, rewrites RELAY.md, rebuilds INDEX.

  taskmaster  Creates, starts, completes, reassigns tasks.

  messenger   Sends messages, archives inbox, broadcasts.

  tester      Runs the repo's test suite (typecheck, lint, build, tests).
              Adaptive per tech stack.

  guard       Security scan: universal checks (exposed keys, gitignore) plus
              agent-specific rules from AGENT.md Security Rules section.
              CRITICAL issues block deploy.

  deployer    Stages code to staging or deploys to production.
              Runs guard automatically before staging.
              Modes: stage (feature -> staging) or deploy (staging -> main).

  handoff     Signals phase complete. Moves task to Done, notifies
              all downstream agents they're unblocked, notifies operator.

--- TYPICAL AGENT SESSION ---

  /employ {callsign}
    | briefer compiles dossier + starts session log
    | tester runs baseline (product agents only)
    -> agent reports for duty
  code, code, code...
    | scribe log: actual code, decisions, errors
    | tester (check it compiles)
  more code...
    | deployer stage (runs guard -> push to staging)
  verify on staging...
    | deployer deploy (promote to production)
    | handoff (notify downstream agents)
  /retire
    | scribe captures learnings + rewrites relay
    | scribe finalizes session log
    | taskmaster moves tasks to Done, creates follow-ups
    | messenger sends pending messages, archives inbox
    | git commit + push workspace

--- TYPICAL SESSION FLOW ---

  /status              -> see the pipeline, decide who to employ
  /employ architect    -> describe feature, architect writes spec
  /retire              -> spec handed off to operator
  /employ operator     -> reads spec, decomposes into agent tasks
  /retire              -> tasks + messages in every agent's inbox
  /status              -> confirm pipeline, see who's ready
  /employ api          -> api finds task, builds, stages, deploys, hands off
  /retire
  /employ sdk          -> sdk finds task, unblocked by api, builds...
  ...continue until feature is complete...
  /employ reviewer     -> reviews the product, files bugs

--- SYSTEM AGENTS (4 primitives, always included) ---

  architect   Analyzes what needs to change. Reads all code, writes none.
              Produces spec documents. Hands off to operator.

  operator    PM. Receives specs, decomposes into tasks, routes work.
              Manages the pipeline.

  librarian   Owns documentation/. Sweeps learnings into architecture docs.
              Runs audits. Keeps docs accurate.

  reviewer    Black-box product review. Enforced ignorance (no source code).
              Tests like a user, not a developer.

  (Add product agents with /recruit)

--- KEY FILES ---

  Per agent:
    AGENT.md       Identity. Who am I, what do I own.
    RELAY.md       The baton. Handover from last session.
    Messages/      Inbox/ and Archive/. Files are the message bus.
    Tasks/         Todo/ -> Doing/ -> Done/. Kanban via folders.
    Learnings/     Insights that persist. INDEX.md auto-generated.
    Sessions/      Near-verbatim session logs.

  Workspace (workspace/ repo, symlinked into project root):
    workspace/ROSTER.md             All agents and their status.
    workspace/agents/{callsign}/    Agent folders.
    workspace/.cursor/              Rules, commands, skills, subagents.
    workspace/PRINCIPAL.md          The human directing the system: preferences,
                                    style, recurring context. Read at every employ.
    workspace/CLAUDE.md             Claude Code instructions.
    workspace/templates/            Agent templates for /recruit.

--- CORE RULES ---

  1. Files are the protocol. No state outside the filesystem.
  2. RELAY.md is always a full rewrite. Never append.
  3. Learnings INDEX is auto-generated. Never hand-edit.
  4. Messages are never deleted. Archive only.
  5. Tasks track kanban. Done tasks always have an Outcome.
  6. Capture order on retire: Learnings > RELAY > Tasks > Messages > Session.
  7. Ignore .gitkeep files. Only .md files are content.
  8. Delegate file mechanics to subagents. Agents think, subagents write.
  9. Never mock tests. Hit real staging. A mocked test is a lie.
  10. Always commit workspace on retire.
  11. Never touch repos you don't own. READ anywhere, WRITE only to your repo.
      Message the owning agent for changes elsewhere. No exceptions.
  12. Read PRINCIPAL.md at every employ. Update it when corrected on standing
      preferences. The same lesson should never need to be taught twice.
```
