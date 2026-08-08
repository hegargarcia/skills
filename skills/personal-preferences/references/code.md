# 2 Code

Rules in this chapter apply when shaping code. Established repository patterns take precedence (see 1.3).

## 2.1 Naming

### 2.1.1 Function names state one action

Give functions one clear action. Action verbs must not be joined with `and` or `or`.

### 2.1.2 Result verbs describe value-returning functions

Prefer result verbs such as `fetch`, `get`, or `resolve` for functions that return domain values. Side-effect verbs such as `refresh` must not describe them.

### 2.1.3 Arguments carry context

Let arguments carry context instead of suffixing the function name when inputs already distinguish a generic operation.

### 2.1.4 Domain nouns over `input*` names

Use the domain noun instead of an `input*` name unless `Input` is part of the domain term.

### 2.1.5 Helpers are named for their operation

Name helpers for the domain operation they actually perform, not for their caller, their audience, or a vague verb such as `build`.

### 2.1.6 Predicates have a capable subject

Give predicates a subject that can literally perform the verb.

### 2.1.7 Names identify one lifecycle stage

Name the lifecycle stage the code operates on. Multiple stages must not be fused into one compound noun.

### 2.1.8 New code uses current domain vocabulary

Use the current domain vocabulary in new code even when legacy storage or nearby code still uses a retired term.

### 2.1.9 Exported types get their public name at the definition

Give exported types their intended public name at the definition. Do not immediately re-export an intermediate alias under its real name.

## 2.2 Shape and abstraction

### 2.2.1 Changes are narrowly scoped

Keep changes narrowly scoped to the requested behavior and its ownership boundary.

### 2.2.2 Declaration style follows the surroundings

Preserve the surrounding declaration style. When the codebase leaves the choice open, prefer function declarations for named functions and expressions for callbacks or value semantics.

### 2.2.3 The newest established pattern wins

When repository precedents conflict, follow the newest established idiomatic pattern rather than the nearest legacy example.

### 2.2.4 Symbols are defined before first use

Define constants, types, helpers, and functions before their first use.

### 2.2.5 Method shorthand for object-literal functions

Prefer method shorthand for object-literal functions that do not need lexical `this`.

### 2.2.6 Symbols stay private until needed

Keep symbols private until a real caller exists outside the file.

### 2.2.7 Check for an owning package first

Before declaring a shared type or helper, check whether the workspace already has an owning package that exports it.

### 2.2.8 No pass-through barrels or forwarding exports

Avoid pass-through barrels, forwarding exports, and renamed copies of another module's symbol.

**Exception:** intentional package entrypoints required by the repository.

### 2.2.9 Directories provide domain context

Start with locally meaningful filenames such as `agent.ts`, `types.ts`, `client.ts`, or `service.ts`, and split narrower files only after they earn it.

### 2.2.10 Abstractions must earn their place

Add or keep an abstraction only when it isolates meaningful complexity, removes real duplication, owns a reusable contract, centralizes a repeated boundary check, or follows a local pattern.

### 2.2.11 Trivial indirection is inlined

Inline single-use helpers, constants, aliases, config objects, and wrappers that merely narrate or rename a trivial expression or branch. Call an underlying dependency directly instead of adding a forwarding getter that exposes it unchanged.

Example:

```ts
const active = users.filter((user) => user.status === "active")
```

### 2.2.12 Helpers return the shape callers consume

Make helpers return the shape their callers consume instead of repeating the same conversion at every call site.

### 2.2.13 Typed provider payloads are used directly

Use typed provider payloads directly when they already express the source contract. Map them at the consumer or write boundary instead of adding an intermediate DTO.

### 2.2.14 Tiny trusted serialization stays direct

Do not introduce JSON, base64, or schema machinery for a couple of internal scalar fields when a compact versioned representation and local checks suffice.

### 2.2.15 Functions over classes

Avoid classes for repository and service patterns; prefer functions, typed contexts, and module-level helpers.

### 2.2.16 Domain value first, context second

Pass a helper's primary domain value first and a single operational context second. Pass one scalar identifier directly; use an object when the primary value contains several fields.

Example:

```ts
async function archiveProfile(profileId: string, { actorId, db }: AppContext) {}

async function createNote(
  note: { body: string; profileId: string },
  { createdBy, tx }: WriteContext,
) {}
```

### 2.2.17 Shared context types for repeated dependency shapes

Reuse a shared domain-context type for repeated dependency shapes such as `{ db }` or `{ actorId, db }`.

### 2.2.18 Registries derive from one source of truth

Keep registries and their accepted names derived from one behavior-bearing source of truth. Parallel string allowlists must not be maintained.

### 2.2.19 Orchestration stays linear

Keep orchestration linear and scannable. Let public functions own transactions and iteration while focused helpers own meaningful per-item validation or side effects.

## 2.3 Control flow and errors

### 2.3.1 Separate operations over mode flags

Prefer separate public operations when one operation would otherwise need materially different mode flags or caller-specific branches.

### 2.3.2 Explicit `if` blocks over ternaries

Prefer explicit `if` blocks. Ternaries are reserved for compact local value selection, never awaited work or a larger statement.

### 2.3.3 Strict equality

Use strict equality. Spell out both nullish conditions when needed instead of relying on loose equality.

### 2.3.4 Independent work starts early

Start independent promises or child workflows before awaiting them; keep only real data dependencies sequential.

### 2.3.5 `map` plus `filter` for optional extraction

Prefer `map` plus `filter` for optional scalar extraction. Use `flatMap` only when one input can produce multiple outputs.

### 2.3.6 `Map.groupBy` when it reads more clearly

Use `Map.groupBy` for straightforward grouping when the target runtime supports it and it reads more clearly than a manual loop. Keep the loop when it also normalizes or aggregates.

### 2.3.7 `!!value` for truthiness coercion

Prefer `!!value` for local truthiness coercion over comparison with `=== true`.

### 2.3.8 Discriminated results for expected failures

Return a discriminated result for expected failures that callers should inspect, log, or route. Throw for genuinely exceptional paths.

### 2.3.9 Custom errors extend `Error`

Make custom errors extend `Error`. They must not be modeled as standalone object types.

## 2.4 Boundaries and ownership

### 2.4.1 Invariants live in the shared layer

Enforce durable invariants in the shared domain, query, repository, or API layer so invalid or hidden data cannot leak downstream.

### 2.4.2 Route handlers stay thin

Keep route handlers thin when the local architecture provides domain or repository modules for validation and read/write flows.

### 2.4.3 Distinct entrypoints for distinct surfaces

Prefer distinct public entrypoints for distinct domain surfaces when that improves caller clarity, even if implementations share lower-level primitives.

### 2.4.4 Model the real owner of data

Do not substitute environment-scoped namespaces for missing user, workspace, or tenant identity.

### 2.4.5 Direct imports over speculative injection

Import stable shared values directly inside a self-contained system. Add dependency injection only when a real seam needs to vary.

### 2.4.6 Typed RPC clients over generic fetch wrappers

Prefer a framework's typed RPC client over generic fetch wrappers and response casts when working inside its typed client/server surface.

### 2.4.7 Neutral modules break cycles

Put shared contracts in a neutral module when importing them from an aggregator would create a cycle.

## 2.5 Structure and interface code

### 2.5.1 Feature folders with focused files

Prefer feature folders with focused files when one module owns multiple concerns.

### 2.5.2 One-use workflow helpers stay local

Keep one-use workflow or activity helpers local to their consumer instead of extracting a dedicated module for them.

### 2.5.3 Shared workflow constants live in neutral modules

Keep pure constants shared by workflow and activity code in a neutral module. Activity implementations must not be imported into workflow code for constants.

### 2.5.4 One retryable side effect per activity

In workflow and activity systems, give each independently retryable side effect its own activity instead of batching unrelated side effects behind one retry boundary.

### 2.5.5 Shared fetch caches require identical field needs

Share memoized route fetch logic (such as `React.cache`) only when callers need the same fields at the same detail level.

**Note:** defer to the framework's own guidance for mechanics — the [React `cache` reference](https://react.dev/reference/react/cache) for sharing and invalidation pitfalls, and the Next.js [data fetching](https://nextjs.org/docs/app/getting-started/fetching-data) and [caching](https://nextjs.org/docs/app/getting-started/caching) guides for request memoization, parallel fetching, streaming, and revalidation patterns.

### 2.5.6 Dates are formatted at the display boundary

Format serialized dates and timestamps at the display boundary. Preserve date-only calendar values without timezone conversion, and render timestamps in the intended viewer timezone.

### 2.5.7 No manufactured temporal precision

Do not manufacture temporal precision, such as appending midnight to a date-only value, merely to make a formatter accept it.
