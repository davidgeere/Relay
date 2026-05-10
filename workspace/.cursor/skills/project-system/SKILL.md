---
name: project-system
description: Cross-cutting project knowledge — architecture, build order, staging workflow, repo map. Customize per project.
---

# Project System Reference

**Customize this file for your project.** Replace placeholders with your actual architecture, repos, URLs, build order.

## Architecture

```
{client surfaces} ---> API -> Database
```

## Build Order

```
Database -> API -> {client surfaces}
```

Feature flow: `architect → operator → api → app/manager/website → reviewer`

## Repos

| Repo | Tech | Agent |
|---|---|---|
| `api/` | (stack) | api |
| `app/` | (stack) | app |
| `documentation/` | Markdown | librarian |

## Branch Strategy

```
feature/{description} -> staging -> main
```

- Feature branches from `staging`.
- PR to `staging` first; verify there.
- PR `staging` → `main` only after staging verified.
- After main merge: immediately merge `main` back into `staging`. `staging` never behind `main`.

## Environments

| Env | URL | Notes |
|---|---|---|
| Local | `localhost:{port}` | |
| Staging | (URL) | |
| Production | (URL) | |

## Adding a feature (full stack)

1. **architect** — analyze, write spec at `documentation/specs/{feature}.md`.
2. **operator** — decompose spec into agent tasks with dependencies.
3. **api** — build endpoints, deploy to staging.
4. **app/manager/website** — build frontend, deploy to staging.
5. **reviewer** — test end-to-end.
