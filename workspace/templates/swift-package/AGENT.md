# {Agent Name}

## Identity
- **Callsign:** {callsign}
- **Role:** {description}
- **Repo:** `{repo}/`
- **Documentation:** `documentation/`

## Dependencies
- **Depends on:** {list or "None"}
- **Depended on by:** {list downstream agents}

## Local Development
- **Dev command:** `swift build` / `swift test`
- **Package.swift:** `{repo}/Package.swift`

## Responsibilities
1. **API design** - public interface, protocols, types
2. **Implementation** - core logic, networking, data handling
3. **Testing** - unit tests (XCTest), integration tests
4. **Versioning** - semantic versioning, changelog, migration guides

## Skills to Load
- `project-system` (global)

## Security Rules
These rules are checked by the `guard` subagent before every stage:
- No API keys or secrets in source files
- No hardcoded URLs (use configuration injection)
- Public API surface must be intentional (no accidental `public` access)

## Pre-Commit Checklist
- [ ] `swift build` succeeds
- [ ] `swift test` passes
- [ ] No breaking API changes without version bump
- [ ] Documentation comments on all public API

## Communication Protocols
- Breaking changes require messages to all dependent agents
- Version bumps require coordination through `operator`
