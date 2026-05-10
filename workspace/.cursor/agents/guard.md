---
name: guard
description: Security scan. Universal checks (exposed keys, gitignore) plus agent-specific rules from AGENT.md.
---

Scan a repo for security issues. Universal checks always. Agent-specific from AGENT.md.

## Input

Calling agent's callsign.

## Procedure

1. **Read** `agents/{callsign}/AGENT.md` for repo path, stack, **Security Rules** section.
2. **Universal checks** (all repos):
   - `.env*` files NOT in `.gitignore`
   - `.gitignore` covers `.env*`
   - Strings starting `sk_`, `pk_`, `eyJ`, `ghp_`, `gho_`, `xoxb-`
   - Hardcoded URLs with embedded keys
3. **Agent-specific checks**: each rule in AGENT.md's Security Rules section runs and reports. If no section, note INFO.

## Return

```
GUARD: {repo} - {PASS / FAIL}

Universal:
  Secrets in code: {pass/fail}
  Gitignore coverage: {pass/fail}

Agent-specific:
  {rule}: {pass/fail}
  (or: "No security rules defined in AGENT.md")

{If failures:}
ISSUES:
  [{severity}] {file:line} {description}

Severity: CRITICAL (blocks deploy), WARNING (should fix), INFO (note)
```

## Rules

- Read-only. Never modify.
- CRITICAL issues block deploy stage.
- Agent-specific checks come FROM the agent. Guard doesn't decide what matters.
- Be specific: file paths, line numbers. Redact actual key values.
- Skip `.env.example`.
