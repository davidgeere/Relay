---
name: project-system
description: Cross-cutting project knowledge. Architecture, build order, staging workflow, repo map. Customize this for your project.
---

# Project System Reference

> **Customize this file for your project.** Replace the placeholders below with your actual architecture, repos, URLs, and build order.

## Architecture

**Describe your architecture here.** Example:

```
App ----------------------> API -> Database
Manager -----------------> API -> Database
Website -----------------> API -> Database
```

## Build Order

**Define your dependency chain.** Example:

```
Database -> API -> App
Database -> API -> Manager
Database -> API -> Website
```

Feature flow: architect -> operator -> api -> app + manager + website -> reviewer

## Repos

| Repo | Tech | Agent |
|------|------|-------|
| `api/` | (your tech stack) | api |
| `app/` | (your tech stack) | app |
| `manager/` | (your tech stack) | manager |
| `documentation/` | Markdown | librarian |

## Branch Strategy

```
feature/{description} -> staging -> main
```

- Create feature branches from `staging`
- PR to `staging` first, test there
- PR `staging` to `main` only after staging is verified
- Keep `staging` synced: after any `main` merge, immediately merge `main` back into `staging`
- `staging` must NEVER be behind `main`

## Environments

| Environment | URL | Notes |
|-------------|-----|-------|
| Local | `localhost:{port}` | |
| Staging | (your staging URL) | |
| Production | (your production URL) | |

## Adding a New Feature (Full Stack)

1. **architect** - analyze codebase, write spec at `documentation/specs/{feature}.md`
2. **operator** - decompose spec into agent tasks with dependencies
3. **api** (if backend needed) - build endpoints, deploy to staging
4. **app/manager/website** - build frontend, deploy to staging
5. **reviewer** - test the feature end-to-end
