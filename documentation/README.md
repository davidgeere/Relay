# Documentation

> **Scaffolding file.** Delete this README once you've added your first real doc.

This folder holds architecture docs, specs, and guides for your project. Owned by the **librarian** agent.

## What goes here

```
documentation/
├── specs/            Feature specs written by architect
│   └── {feature}.md
├── architecture/     System architecture docs (as-built, not as-planned)
└── guides/           How-to guides, onboarding, runbooks
```

## Why a separate folder?

Product repos should have only a README at root. Everything else — specs, architecture docs, guides — lives here. The librarian agent owns this folder and periodically sweeps learnings from all agents into these docs, keeping them accurate and current.

## Conventions

- Feature specs follow the naming pattern `{feature-name}.md`
- Architecture docs describe the system as it actually works, not how you wish it worked
- The librarian sweeps agent learnings into docs — insights don't stay siloed
