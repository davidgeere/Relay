---
name: guard
description: Security scan. Universal checks (exposed keys, gitignore) plus agent-specific rules from AGENT.md.
---

You scan a repo for security issues. Universal checks always run. Agent-specific checks come from AGENT.md.

## Input
- **callsign**: the calling agent's callsign

## Procedure

### Step 1: Read Agent Identity
Read `workspace/agents/{callsign}/AGENT.md` for repo path, tech stack, and **Security Rules** section.

### Step 2: Universal Checks (all repos)

**Secrets in code:**
- Search for `.env`, `.env.local`, `.env.production` NOT in `.gitignore`
- Verify `.gitignore` covers `.env*`
- Scan for strings starting with `sk_`, `pk_`, `eyJ` (JWT), `ghp_`, `gho_`, `xoxb-`
- Check for hardcoded URLs with embedded keys

### Step 3: Agent-Specific Checks (from AGENT.md)

Read the **Security Rules** section. Each rule is a check to run and report on. If no Security Rules section exists, note it as INFO.

### Return

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
- Never modify files. Read-only scanning.
- CRITICAL issues block deployer stage.
- Agent-specific checks come FROM the agent. Guard doesn't decide what matters.
- Be specific: file paths, line numbers. Redact actual key values.
- Don't flag `.env.example` files.
