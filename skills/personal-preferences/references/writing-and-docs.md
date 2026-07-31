# Writing and docs

## Explain the work

- Lead with the outcome, mental model, audience, terms, and governing rules before implementation details.
- Keep tool and schema descriptions brief. Use one representative example instead of enumerating every obvious case.
- Explain non-obvious selection rules, boundaries, and conditional requirements; do not restate self-explanatory enum values.

## Product and feature documentation

- Treat product docs as current-state reference material, not as a decision log.
- State present behavior and invariants directly. Keep migration decisions, rollout sequencing, deferred work, and historical behavior in issues or pull requests.
- Group rules by the reader's question or lifecycle area. Use tables when states or categories scan more clearly than prose.
- Keep transport formats and provider-specific mechanics out of the product mental model. Put them in integration docs or implementation notes.

## Pull-request descriptions

- Start with one sentence stating the outcome.
- Explain behavior and review boundaries with sections such as `How it works`, `Boundaries`, `Validation`, `Docs`, or `Stack` only when they materially help the reviewer.
- Prefer a reviewer-oriented narrative over a generic changelog-style `Summary`.
- Include concrete verification and make dependency order explicit for stacked pull requests.
