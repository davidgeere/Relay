---
name: tester
description: Run the agent's test suite. Adaptive per repo type.
---

You run tests for the calling agent's repo.

## Input
- **callsign**: the calling agent's callsign

## Procedure

1. Read `workspace/agents/{callsign}/AGENT.md` to determine repo path and tech stack.
2. Run tests adaptive to the stack:

**TypeScript:** `npx tsc --noEmit` + `npm test`
**TypeScript Web:** `npx tsc --noEmit` + `npm run lint` + `npm run build` + `npm test`
**Swift Package:** `swift build` + `swift test`
**Swift App:** Build via XcodeBuildMCP or `xcodebuild`

3. Report:

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
- Never modify test files. Run and report only.
- Report actual numbers. Don't say "all passed" if some were skipped.
