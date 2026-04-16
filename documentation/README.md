# Documentation

This folder holds architecture docs, specs, and guides for the project. Owned by the **librarian** agent.

## Structure

```
documentation/
├── README.md         (this file)
├── specs/            (feature specs from architect)
│   └── {feature}.md
├── architecture/     (system architecture docs)
└── guides/           (how-to guides, onboarding)
```

## Conventions

- Feature specs go in `specs/` and follow the naming pattern `{feature-name}.md`
- Architecture docs describe the system as-built, not as-planned
- The librarian periodically sweeps agent learnings into these docs
- Product repos should have only a README at root. Deep documentation belongs here.
