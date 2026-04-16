Create a new product agent from a template.

## Usage
`/recruit {callsign} [template]`

Templates in `workspace/templates/`: `ts-api`, `ts-web`, `swift-app`, `swift-package`

## Sequence

1. **Validate** - check `workspace/ROSTER.md` to ensure callsign doesn't already exist.

2. **Create folder structure** at `workspace/agents/{callsign}/`:
   ```
   AGENT.md, RELAY.md, Messages/{Inbox,Archive}, Tasks/{Todo,Doing,Done},
   Learnings/INDEX.md, Skills/, Sessions/
   ```
   Add `.gitkeep` to all empty directories.

3. **Populate AGENT.md** - copy from `workspace/templates/{template}/AGENT.md` and customize. Or ask for: role, repo, dependencies, responsibilities.

4. **Note skills** - if the template references skills, note them in AGENT.md under "Skills to Load".

5. **Create RELAY.md**: "Fresh agent. No prior sessions."

6. **Create INDEX.md**: "No learnings yet."

7. **Update `workspace/ROSTER.md`** - add the new agent row.

8. **Notify Operator** - send a message about the new agent.

9. **Confirm:**
   ```
   [{CALLSIGN}] recruited from template: {template or "generic"}.
   Folder: workspace/agents/{callsign}/
   Roster: updated
   Operator: notified
   Use /employ {callsign} to start their first session.
   ```
