# Code

Use these defaults when shaping code. Let the repository's established patterns win when they conflict.

## Naming

- Give functions one clear action; do not join action verbs with `and` or `or`.
- Prefer result verbs such as `fetch`, `get`, or `resolve` for functions that return domain values; do not describe them with side-effect verbs such as `refresh`.
- Let arguments carry context instead of suffixing the function name when inputs already distinguish a generic operation.
- Use the domain noun instead of an `input*` name unless `Input` is part of the domain term.
- Name helpers for the domain operation they serve, not for their caller or audience.
- Give predicates a subject that can literally perform the verb.
- Name the lifecycle stage the code operates on; do not fuse multiple stages into one compound noun.
- Replace vague `build*` names with the operation the helper actually performs.
- Give exported types their intended public name at the definition; do not immediately re-export an intermediate alias under its real name.

## Shape and abstraction

- Keep changes narrowly scoped to the requested behavior and its ownership boundary.
- Preserve the surrounding declaration style. When the codebase leaves the choice open, prefer function declarations for named functions and expressions for callbacks or value semantics.
- Define constants, types, helpers, and functions before their first use.
- Prefer method shorthand for object-literal functions that do not need lexical `this`.
- Keep symbols private until a real caller exists outside the file.
- Avoid pass-through barrels, forwarding exports, and renamed copies of another module's symbol. Respect intentional package entrypoints required by the repository.
- Let directories provide domain context. Start with locally meaningful filenames such as `agent.ts`, `types.ts`, `client.ts`, or `service.ts`, and split narrower files only after they earn it.
- Add an abstraction only when it removes meaningful complexity, reduces real duplication, or follows a local pattern.
- Inline single-use helpers, constants, aliases, config objects, and wrappers that merely narrate or rename a trivial expression or branch.
- Call an underlying dependency directly instead of adding a forwarding getter or method that exposes it unchanged.
- Keep a helper when it isolates meaningful complexity, owns a reusable contract, or centralizes a repeated boundary check.
- Use typed provider payloads directly when they already express the source contract; map them at the consumer or write boundary instead of adding an intermediate DTO.
- Keep tiny trusted serialization formats direct. Do not introduce JSON, base64, or schema machinery for a couple of internal scalar fields when a compact versioned representation and local checks suffice.
- Avoid classes for repository and service patterns; prefer functions, typed contexts, and module-level helpers.
- Pass a helper's primary domain value first and a single operational context second. Pass one scalar identifier directly; use an object when the primary value contains several fields.
- Reuse a shared domain-context type for repeated dependency shapes such as `{ db }` or `{ actorId, db }`.
- Keep registries and their accepted names derived from one behavior-bearing source of truth; do not maintain parallel string allowlists.
- Keep orchestration linear and scannable. Let public functions own transactions and iteration while focused helpers own meaningful per-item validation or side effects.

## Control flow and errors

- Prefer separate public operations when one operation would otherwise need materially different mode flags or caller-specific branches.
- Prefer explicit `if` blocks over ternaries. Reserve ternaries for compact local value selection, never awaited work or a larger statement.
- Use strict equality. Spell out both nullish conditions when needed instead of relying on loose equality.
- Start independent promises or child workflows before awaiting them; keep only real data dependencies sequential.
- Prefer `map` plus `filter` for optional scalar extraction; use `flatMap` only when one input can produce multiple outputs.
- Use `Map.groupBy` for straightforward grouping when the target runtime supports it and it reads more clearly than a manual loop. Keep the loop when it also normalizes or aggregates.
- Prefer `!!value` for local truthiness coercion over comparison with `=== true`.
- Return a discriminated result for expected failures that callers should inspect, log, or route. Throw for genuinely exceptional paths.
- Make custom errors extend `Error`; do not model them as standalone object types.

## Boundaries and ownership

- Enforce durable invariants in the shared domain, query, repository, or API layer so invalid or hidden data cannot leak downstream.
- Keep route handlers thin when the local architecture provides domain or repository modules for validation and read/write flows.
- Prefer distinct public entrypoints for distinct domain surfaces when that improves caller clarity, even if implementations share lower-level primitives.
- Model the real owner of data. Do not substitute environment-scoped namespaces for missing user, workspace, or tenant identity.
- Import stable shared values directly inside a self-contained system. Add dependency injection only when a real seam needs to vary.
- Prefer a framework's typed RPC client over generic fetch wrappers and response casts when working inside its typed client/server surface.
- Put shared contracts in a neutral module when importing them from an aggregator would create a cycle.

## Structure and interface code

- Prefer feature folders with focused files when one module owns multiple concerns.
- Keep one-use workflow or activity helpers local to their consumer instead of extracting a dedicated module for them.
- Keep pure constants shared by workflow and activity code in a neutral module; do not import activity implementations into workflow code for constants.
- Use `React.cache` for shared route fetch logic only when callers need the same fields at the same detail level.
- Format serialized dates and timestamps at the display boundary. Preserve date-only calendar values without timezone conversion, and render timestamps in the intended viewer timezone.
- Do not manufacture temporal precision, such as appending midnight to a date-only value, merely to make a formatter accept it.

## Representative examples

Inline trivial single-use behavior:

```ts
const active = users.filter((user) => user.status === "active")
```

Shape helper parameters around the domain value and operational context:

```ts
async function archiveProfile(profileId: string, { actorId, db }: AppContext) {}

async function createNote(
  note: { body: string; profileId: string },
  { createdBy, tx }: WriteContext,
) {}
```
