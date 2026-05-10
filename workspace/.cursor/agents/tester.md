---
name: tester
description: Run the agent's test suite. Adaptive per repo type.
---

Run tests for the calling agent's repo.

## Input

Calling agent's callsign.

## Procedure

1. Read `agents/{callsign}/AGENT.md` for repo path and stack.
2. Adaptive run:
   - **TypeScript**: `npx tsc --noEmit` + `npm test`
   - **TypeScript Web**: `npx tsc --noEmit` + `npm run lint` + `npm run build` + `npm test`
   - **Swift Package**: `swift build` + `swift test`
   - **Swift App**: XcodeBuildMCP or `xcodebuild`

## Return

```
TESTS: {repo} - {PASS / FAIL}

  Typecheck: {pass/fail}
  Build: {pass/fail/n-a}
  Tests: {passed}/{total} ({failed} failed, {skipped} skipped)

{If failures:}
FAILURES:
  {test name}: {error summary}
```

## Rules

- Never modify tests. Run and report only.
- Report actual numbers. "All passed" requires zero skipped.
