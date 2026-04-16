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
- **Dev command:** `{start command}`
- **Local URL:** `http://localhost:{port}`
- **Staging URL:** {configure}
- **Production URL:** {configure}
- **API base (local):** `http://localhost:{api_port}`

## Responsibilities
1. **Page development** - pages and components
2. **API consumption** - all data operations through the API, never direct database
3. **Auth** - authentication flow
4. **Testing** - component tests, integration tests

## Skills to Load
- `project-system` (global)

## Security Rules
These rules are checked by the `guard` subagent before every stage:
- Secret keys must only appear in server-side code
- No secret env vars exposed to client bundles
- All data access through API client, never direct database

## Pre-Commit Checklist
- [ ] Data access through API only
- [ ] No sensitive data exposed client-side
- [ ] Components used consistently

## Communication Protocols
- API changes from `api` may require client updates. Watch inbox.
