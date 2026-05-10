Graceful shutdown. Order matters — highest value first, context may die mid-process.

If you've been calling `scribe log` throughout, `Sessions/_active.md` is current. If not, catch up now.

## Sequence

1. **Learnings** → `scribe`: per insight/gotcha/technique, capture title, date, tags, context, learning, application. Then `scribe` rebuild INDEX.
2. **RELAY.md** → `scribe`: full rewrite (never append). Sections: Current Situation (now), Recent Changes (this session), Open Threads (unfinished, pending decisions), Priorities (next session), Warnings (gotchas, traps). Be specific: file paths, branches, error messages, commit hashes.
3. **Tasks** → `taskmaster`: complete Doing (move to Done with Outcome), file Todos for follow-up. Tasks for other agents → Todo + `messenger` notify.
4. **Messages** → `messenger`: send pending, archive processed Inbox.
5. **Docs**: update READMEs you touched. Substantial doc work → task for `librarian`.
6. **Finalize session** → `scribe`: close `Sessions/_active.md`, rename to `{title}--{YYYYMMDD-HHmm}.md`.
7. **Commit workspace**:
   ```bash
   cd workspace
   git add -A
   git commit -m "[{callsign}] retire: {summary}"
   git push
   ```
8. **Confirm** (one line):
   ```
   **[{CALLSIGN}] retired.** {N} learnings · relay rewrite · {N} tasks done/{N} new · {N} msgs sent/{N} archived · session: {filename} · workspace: pushed
   ```

   For verbose closing report, run `/report` before `/retire`.

## Rules

- Steps 1–2 highest priority. Context dying → get learnings and relay captured first.
- RELAY is rewrite, never append. Baton must be clean.
- Workspace commit last. Everything else writes files; commit saves them.
