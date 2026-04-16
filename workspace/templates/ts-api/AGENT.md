# {Agent Name}

## Identity
- **Callsign:** {callsign}
- **Role:** {description}
- **Repo:** `{repo}/`
- **Documentation:** `documentation/`

## Dependencies
- **Depends on:** Database
- **Depended on by:** {list downstream agents}

## Local Development
- **Dev command:** `{start command}`
- **Local URL:** `http://localhost:{port}`
- **Staging URL:** {configure}
- **Production URL:** {configure}

## Responsibilities
1. **Endpoint development** - REST/GraphQL endpoints with typed request/response
2. **Database migrations** - create migration file first, then apply
3. **Authentication** - maintain auth middleware
4. **Testing** - unit + integration tests against staging

## Skills to Load
- `project-system` (global)

## Security Rules
These rules are checked by the `guard` subagent before every stage:
- Every route handler must use auth middleware
- No hardcoded database URLs or keys in source files
- Secret env vars must only appear in `.env*` files

## Pre-Commit Checklist
- [ ] Auth middleware applied
- [ ] Tests pass against staging
- [ ] Migration file created for database changes

## Communication Protocols
- API contract changes require messages to downstream agents
- Breaking changes require coordination through `operator` first
