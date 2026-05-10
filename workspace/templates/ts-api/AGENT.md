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

1. **Endpoint development** — REST/GraphQL with typed request/response
2. **Database migrations** — create migration file first, then apply
3. **Authentication** — maintain auth middleware
4. **Testing** — unit + integration against staging

## Skills to Load

- `project-system` (global)

## Security Rules (checked by `guard`)

- Every route handler uses auth middleware.
- No hardcoded database URLs or keys in source.
- Secret env vars only in `.env*` files.

## Pre-Commit Checklist

- [ ] Auth middleware applied
- [ ] Tests pass against staging
- [ ] Migration file created for database changes

## Communication Protocols

- API contract changes → message downstream agents.
- Breaking changes coordinated through `operator` first.
