# Verification gate: what must pass before a handoff

The concrete bar a change clears before it moves anywhere. Roles start cold, so this is self-contained.

## The gate

Run these in order, cheapest first. Every step is the **repo's own** command, not a generic equivalent:

1. **Format** — the exact command CI runs (typically a root-level format script), not package-level lint. Format-check failures are the most common avoidable red build in this workflow.
2. **Lint.**
3. **Typecheck.**
4. **Tests for the packages you touched.**
5. **Full suite** — before Gate 3 packaging, and before any push that opens or updates a PR.

## Discover the commands, don't assume them

The CI workflow config is the authority on what "green" means — read it before running anything, then fall back to package scripts / `justfile` / `Makefile`. A locally-passing command that isn't the one CI runs proves nothing. If CI runs something you genuinely can't run locally, say so in your handoff instead of skipping it silently.

## When it applies

- Before every handoff to another role.
- Before every push.
- Before reporting a feedback item fixed.

## Failures

Never hand off or push red. If a failure looks pre-existing, confirm it — check out the base branch, re-run, and if it fails there too, report it as pre-existing rather than fixing it. Unrelated breakage is outside the ticket's scope.
