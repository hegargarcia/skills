---
name: personal-preferences
description: Hegar's durable, cross-project preferences for how agents shape code, tests, documentation, plans, tooling changes, reviews, and handoffs. Apply silently whenever work requires subjective choices or creates or modifies an artifact. Let explicit current instructions and repository conventions take precedence. Update the tracked skill when Hegar gives durable, reusable feedback about how work should be approached or presented.
---

# Personal Preferences

Preserve Hegar's taste across agents, sessions, and repositories. Use this skill as a small personal operating manual, not as a substitute for understanding the current task or codebase.

## Apply the preferences

Use this precedence, highest first:

1. Follow Hegar's explicit current-turn instructions.
2. Follow repository-local instructions and established surrounding conventions.
3. Use these personal preferences to fill gaps and make judgment calls.

Apply the skill silently. Do not turn it into a user-facing workflow or announce it unless higher-level instructions require disclosure.

Do not use this skill to override safety requirements, product decisions, or deliberate repository conventions.

## Follow the core direction

- Prefer directness over indirection.
- Model real concepts, ownership, and boundaries instead of papering over them with convenient stand-ins.
- Respect established local patterns before introducing something novel.
- Keep scope and diffs small; avoid speculative completeness and incidental cleanup.
- Trust strong types and contracts; validate at real runtime boundaries.
- Add abstractions only when they remove meaningful complexity or duplication.
- Verify in proportion to risk and provide concrete evidence for behavior that benefits from it.
- Explain outcomes and mental models before implementation details.

## Load the relevant references

Read every reference whose scope materially applies before acting. Do not load unrelated references.

- For naming, abstraction, control flow, architecture, project structure, or UI code, read [code.md](./references/code.md).
- For TypeScript types, errors, runtime boundaries, or Zod, read [typescript-and-validation.md](./references/typescript-and-validation.md).
- For Drizzle, SQL, schemas, migrations, transactions, or database mapping, read [data-and-databases.md](./references/data-and-databases.md).
- For test selection, test shape, checks, or behavioral proof, read [testing-and-verification.md](./references/testing-and-verification.md).
- For dependencies, runtimes, environment configuration, Git, diffs, commits, or pull-request mechanics, read [tooling-and-delivery.md](./references/tooling-and-delivery.md).
- For product docs, technical explanations, or pull-request prose, read [writing-and-docs.md](./references/writing-and-docs.md).
- Before Postgres query tuning or index work, read [postgres-performance.md](./references/postgres-performance.md).

## Capture durable feedback

Update this skill when Hegar gives feedback that is clearly:

- A personal preference rather than a generic fact or platform rule
- Likely to recur
- Useful across repositories or contexts
- Actionable enough to change future behavior
- Not already captured by an existing rule

When feedback qualifies:

1. Find the closest topical reference.
2. Sharpen an existing rule instead of adding another whenever possible.
3. Generalize away repository, product, and incident-specific names.
4. Reconcile conflicting guidance immediately; do not preserve both positions.
5. Add an example only when the preference would otherwise remain ambiguous.
6. Create a new reference only after a distinct topic has enough durable guidance to earn one.

Do not record product direction, isolated bugs, temporary workarounds, historical narration, or conventions that belong to one repository. Do not keep a raw feedback diary; let repetition establish ambiguous feedback as durable.

## Maintain the canonical source

Edit the tracked source in the skills repository, never a detached installed copy. If only an installed copy is available, locate the checkout containing `skills/personal-preferences`; if no checkout is available, tell Hegar instead of creating another divergent copy.

Before editing, inspect the source and its Git status. Preserve unrelated changes, keep preference updates focused, and validate the skill after structural changes.
