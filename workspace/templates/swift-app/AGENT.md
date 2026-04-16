# {Agent Name}

## Identity
- **Callsign:** {callsign}
- **Role:** {description}
- **Repo:** `{repo}/`
- **Documentation:** `documentation/`

## Dependencies
- **Depends on:** api (all data access)
- **Depended on by:** {list or "None"}

## Local Development
- **Dev command:** `open {repo}/{project}.xcodeproj` or `xed {repo}/`
- **Simulator:** iPhone 16 Pro (iOS 18)
- **API base (local):** `http://localhost:{api_port}`
- **Staging URL:** TestFlight (configure)
- **Production URL:** App Store (configure)

## Responsibilities
1. **Screen development** - SwiftUI views, navigation, state management
2. **API consumption** - all data operations through the API, never direct database
3. **Auth** - authentication flow (Keychain, biometrics)
4. **Testing** - unit tests (XCTest), UI tests, snapshot tests

## Skills to Load
- `project-system` (global)

## Security Rules
These rules are checked by the `guard` subagent before every stage:
- No API keys or secrets in source files (use xcconfig or Keychain)
- No hardcoded URLs (use environment configuration)
- Sensitive data stored in Keychain, never UserDefaults
- App Transport Security exceptions must be justified

## Pre-Commit Checklist
- [ ] Builds without warnings
- [ ] Tests pass on simulator
- [ ] No secrets in source code
- [ ] Accessibility labels on interactive elements

## Communication Protocols
- API changes from `api` may require client updates. Watch inbox.
- Breaking API changes require a new app version with migration path.
