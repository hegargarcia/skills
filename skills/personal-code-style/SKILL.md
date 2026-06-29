---
name: personal-code-style
description: Hegar's personal, cross-repo coding-style preferences — general taste, not any single project's product decisions. Apply silently as a guardrail whenever you write, edit, refactor, review, or generate code, tests, schemas, migrations, scripts, or code-describing docs. Defer to current-turn instructions and repo conventions first; use this to fill gaps. Update it when Hegar gives durable, repo-agnostic feedback about code shape, abstractions, naming, types, validation, errors, libraries, tooling, or diffs.
---

# Personal Code Style

Hegar's general coding taste, distilled from day-to-day feedback across many repos. This captures **how Hegar likes code to be shaped** — not the product or architecture decisions of any one project. The same file is shared by every agent Hegar works with (Claude and Codex), so edits here propagate everywhere.

## What this is for

- A silent guardrail applied while writing, editing, refactoring, reviewing, or generating code, tests, schemas, migrations, scripts, and code-describing docs.
- A single place to consolidate durable, cross-repo style feedback so it survives across sessions and across agents.

## What this is not

- **Not a user-invoked workflow.** Never announce it or run it as a standalone step — just apply it.
- **Not a home for project specifics.** Product direction, one-off bug fixes, temporary workarounds, and conventions that only apply inside a single repo belong in that repo's own instructions, not here.

## How to apply it

Precedence, highest first:

1. Explicit current-turn instructions from Hegar.
2. Repo-local instructions and the conventions of the surrounding code.
3. This skill, to fill gaps and catch recurring preferences.

If a rule here conflicts with current feedback or a clear repo convention, follow the feedback or convention. If that feedback is durable and repo-agnostic, also update this skill (see [Updating this skill](#updating-this-skill)).

---

## Naming

- Prefer direct function names with one clear action. Don't join action verbs with `and`/`or`.
- For a function that returns a domain value, prefer result verbs (`fetch`, `get`, `resolve`) over side-effect verbs (`refresh`).
- Prefer contextual argument names over suffixing a function name, when the inputs already narrow a generic action.
- Avoid `input*` argument names when the value is already a function input. Use the domain noun directly unless `Input` is part of the domain term.
- Name helpers for the domain operation they serve, not the audience or the caller.
- For predicate names, pick a subject that can literally perform the verb (e.g. name a date-boundary check for the window it checks, not "the event receives the entity").
- Avoid compound nouns that fuse two lifecycle stages of one entity; name the stage the code actually operates on.
- Avoid vague `build*` names for query/predicate helpers; say whether the helper resolves a column predicate or adapts an `EXISTS` predicate.

## Code shape & abstraction

- Prefer the repo's established patterns over new abstractions. Keep changes narrowly scoped to the requested behavior and its ownership boundary.
- Match the local declaration style (function expressions if nearby code uses them) and define constants, types, helpers, and functions before their first use.
- Keep functions, types, schemas, and constants private until there is a clear caller outside the file. No barrel files — import from the module that owns the value.
- Name files by the local purpose they serve and let the directory supply domain context. Start broad (`agent.ts`, `types.ts`, `client.ts`, `service.ts`) and split out a narrower file only once one earns it. Don't repeat the directory/domain name in the filename.
- Add an abstraction only when it removes real complexity, cuts meaningful duplication, or matches a local pattern. (See [Hard cases](#hard-cases).) In particular:
  - Inline single-use helpers, constants, and wrappers that only rename a trivial expression or branch — including one-off, route-specific error handling.
  - When review asks to inline, collapse the route-specific flow into the caller unless a helper is reused or isolates meaningful complexity. Do not keep helpers that only narrate steps.
  - Prefer a shared const/expression for a simple predicate over a wrapper function. But *do* extract a shared predicate for repeated framework/transport error-shape checks, while keeping the route-specific handling inline.
  - Avoid local aliases that only restate a getter or property; use it directly unless the alias removes meaningful repetition.
  - Don't introduce an intermediate DTO layer over a typed provider payload when the code can use the provider type directly. Map at the write boundary instead.
  - Inline one-use helper context types — don't create a `SomeHelperContext` alias unless it's reused or clarifies a shared contract.
  - Keep tiny internal serialization formats direct. Don't wrap a couple of trusted scalar fields in JSON/base64 or schema machinery when a compact versioned string and local parse checks are enough.
  - Avoid config objects for tiny helper concerns when a direct field or callback reads clearer.
  - For Temporal workflow/activity pairs, keep pure shared constants in a neutral local module instead of duplicating literals in both files. Do not import activity implementation modules into workflow files for shared values.
- Avoid classes for repository/service patterns. Prefer plain functions, typed contexts, and module-level helpers.
- **Helper signatures:** pass the primary domain value first, then a single context object of operational dependencies (`{ actorId, db }`, `{ createdBy, tx }`). Use an object for the primary value when it has multiple fields; pass the scalar directly when it's a single identifier (e.g. `userProfileId`). Don't pass long positional dependency lists. (See [Hard cases](#hard-cases).)
- Put repeated domain-context primitives (`{ db }`, `{ actorId, db }`) in a shared domain-context type instead of redefining local aliases.
- Keep orchestration linear and scannable. Keep public orchestration functions thin — let a per-item helper own validation while the public function owns the transaction and loop. Move side-effect-heavy branches into helpers once a function gets hard to read.
- Prefer shorthand arrow helpers for small reusable functions when the generic signature stays readable.

## Control flow

- Prefer explicit `if` blocks over ternaries. Reserve ternaries for compact local value selection — never for awaited work or as part of a larger statement.
- In orchestration code, start independent child workflows/promises before awaiting them; keep only real data dependencies sequential.
- When extracting optional scalar IDs from a list, prefer `map` + `filter` over `flatMap` unless one input can produce multiple outputs.
- For optional predicate expressions, prefer `!!value` when coalescing truthiness to a boolean instead of comparing to `=== true`.
- Prefer a `Result` value (`{ ok: true; data } | { ok: false; error }`) over throwing for expected failures the system should inspect, log, or route. Reserve throwing for genuinely exceptional paths. (See [Hard cases](#hard-cases).)
- Custom errors must extend `Error` — never model them as standalone plain object types.

## Types

- Avoid explicit function return types unless the type checker or a public contract needs one. Prefer `as const` for small stable object shapes over noisy return annotations.
- Trust TypeScript types inside typed functions. Avoid runtime `typeof` revalidation, and don't revalidate data you already own — type trusted internal responses and trust the contract. Reserve runtime validation for untyped/untrusted boundaries.
- Use type guards before casts; treat casting as a last resort. (See [Hard cases](#hard-cases).)

## Validation (Zod)

- Use Zod to validate and type data whose shape is complex or that crosses a runtime boundary (external input, untrusted sources, error envelopes). Reserve it for those boundaries.
- Don't use the deprecated `.passthrough()`. Use `z.looseObject({ ... })` for permissive objects (e.g. third-party payloads whose unknown fields should survive parsing), or an explicit `.catchall(...)` only when unknown values must be validated.
- For known data contracts, avoid defensive defaults that hide malformed input — parse the expected type and let invalid data fail validation, unless the fallback is part of the contract.
- Keep boundary schemas source-shaped. Don't use Zod transforms only to rename provider/DB fields snake→camel; map field names where the parsed result is consumed. For anti-corruption-layer schemas that bridge provider or bounded-context data into an app-owned shape, put the full normalization in the schema with `preprocess`, `transform`, `pipe`, or codecs. Do not parse a source shape and then run a separate secondary normalization pass, and do not share context-specific boundary schemas just because the fields happen to overlap. (See [Hard cases](#hard-cases).)
- Remember that `.transform()` runs after the inner schema validates. When normalizing raw source input so it can validate, use `z.preprocess` or `z.coerce.*` before validation, then use `.pipe` when the normalized output needs another validation pass.
- Prefer direct `z.coerce.*` schemas and narrow `z.preprocess` helpers over codecs, stacked pipes, or transform chains — unless you genuinely need bidirectional codec behavior. The exception: a JSON-string field with a known output schema and a string input contract, where a typed Zod codec is right (invalid JSON should surface as a validation issue).
- Prefer Zod's built-in schema APIs such as `z.coerce.number()`, `z.url()`, and `.prefault()` over handwritten parsing, URL normalization, or missing-value defaults when they express the source contract.
- Use `.prefault(defaultValue)` for missing-input defaults that should still run through validation. Do not convert `null` to a default unless the source contract treats `null` as missing.
- In array preprocessors, normalize element values and let the element schema reject malformed output. Do not filter invalid normalized values away unless dropping them is part of the source contract.
- Inline trivial Zod primitive schemas in object definitions unless the alias is a real domain concept or prevents meaningful repetition.
- When accepting a caller-supplied schema, preserve its type with a generic (`T extends z4.$ZodType`); don't erase it behind `z.unknown()`. (See [Hard cases](#hard-cases).)
- Avoid verbose validation diagnostics (e.g. treeified Zod errors) unless a caller or debugging workflow needs the extra shape.
- On hot paths, call `safeParse` once and branch on the result — don't `parse` in a try/catch and then re-parse for diagnostics or cursor extraction. If several getters repeat the same validation loop, extract a generic helper that owns the `safeParse` branch and returns the typed parsed row.

## Boundaries & architecture

- Enforce durable invariants in the shared API/query/repo/domain layer so no downstream surface receives invalid or hidden data.
- Keep route handlers thin. Put validation, read/write flow, and business logic in repo/domain modules when that's the local architecture.
- Prefer separate public entrypoints for distinct domain surfaces when caller clarity matters, even if the implementations share structure.
- Model the real owner of data explicitly. Don't paper over missing user/workspace/tenant identity with environment-scoped namespace or partition keys — model ownership properly, or keep the surface single-tenant until real ownership exists.
- In self-contained systems, import shared values directly instead of introducing dependency injection too early. For example, import a shared `db`/`paths` module directly rather than threading a context object through every call. Add DI only when there's a real seam to vary.
- For a local HTTP surface with a typed server framework available, prefer the framework's typed RPC client over generic `fetch` wrappers and response casts.

## Project structure & tests

- Prefer feature folders with focused files (e.g. `query.ts` for query execution, `schema.ts` for row-contract parsing) when a module owns both.
- Keep focused tests inside the feature folder, alongside the implementation they cover.
- Don't extract one-use helper modules with dedicated tests when the logic serves a single workflow/activity file — keep it local to the consumer.
- Avoid one-off tests that only assert a schema accepts static fixture shapes, unless they protect meaningful normalization or regression behavior.

## Libraries, runtime & tooling

- Prefer proven libraries for core domain mechanics (Git, SQL, parsers, protocol clients) over hand-rolled wrappers, and prefer package-backed, type-aware APIs over custom shell/tool wrappers when a suitable package exists.
- Don't add dependencies casually. Add one when it clearly reduces fragility or matches the direction Hegar asked for. Use the repo's package-manager-native commands; don't switch package managers for convenience.
- Respect the repo runtime. In Bun projects, reach for Bun commands and APIs first, including Bun-native file primitives (`Bun.file`, `Bun.write`). Use `node:` imports where Bun doesn't expose an operation (e.g. some directory/path work). Don't write custom I/O helpers when Bun or the standard runtime already covers the operation.
- Validate the runtime environment keys the system depends on with a tool like T3 Env. Put required-env invariants in the T3 Env schema/loader and pass the typed value forward — don't add getter/helper wrappers whose only job is to assert a var exists.
- Prefer platform-native environment variables over project-specific aliases when the platform already owns the value (e.g. use the platform-provided deployment URL rather than a hand-copied one).
- For `simple-git`, use the typed client returned by `simpleGit()` directly; don't hide it behind homemade command wrappers. Use `.raw` only when there's no typed method for the operation.

## Database (Drizzle & SQL)

- Prefer Drizzle query APIs, selects, helpers, and typed TypeScript mapping over raw SQL or string-built queries.
- Use existing shared SQL helpers (e.g. a shared `cast` or `aliasedColumn` helper) for reusable operations instead of inline casts, raw `sql` aliasing, or string fragments. Keep operator semantics in shared query helpers — feature code passes columns, predicates, or relation wrappers rather than reimplementing each filter operator locally. Normalize search text at the shared helper boundary, and type custom search builders to return a concrete SQL predicate.
- Prefer database-level fallback expressions such as `coalesce(table.updatedAt, table.createdAt)` in query selects over post-query shape repair helpers.
- Use Drizzle's column `enum` config on text columns for TypeScript safety, even where the database has no enum type (e.g. SQLite).
- Use `.$defaultFn` for runtime-generated defaults like IDs and timestamps — especially on SQLite, which has no timestamp column type. Prefer DB-side `now()` for audit timestamps inside conflict-update SQL, so the recorded time is tied to the transaction.
- Manage migrations and backfills through the repo's package.json scripts (`drizzle-kit`, etc.); don't hand-create migration/backfill files, hand-roll migration plumbing, or rewrite generated migrations into custom control flow. Prefer the generated drop/create shape unless the user asks for custom migration SQL.
- Don't carry active-row IDs across transaction boundaries when another transaction could soft-delete and recreate the active row; resolve those IDs inside the mutation transaction that uses them.
- Reserve raw SQL for when the typed/helper path is genuinely unreasonable, and make that tradeoff explicit in review or handoff notes. If a query is awkward as one SQL expression, prefer two typed queries plus TypeScript filtering over brittle inline SQL.
- **Postgres performance & indexing:** read [postgres-performance.md](./postgres-performance.md) before query-tuning or index work.

## UI & framework (React / TanStack)

- Use `React.cache` for shared route fetch logic only when the callers need the same fields at the same level of detail.
- For TanStack column definitions, use method shorthand (`cell() {}`) over property-arrow callbacks (`cell: () => {}`).

## Docs & verification

- For feature/product docs, lead with the mental model, audience, terms, and rules before implementation details. Tables, migrations, and field lists come only after the reader understands the concept.
- Avoid long ungrouped rule lists in product docs. Split rules by reader question or lifecycle area, and use tables when states or categories are easier to scan than prose bullets.
- Do not promote transport details, input formats, or provider-specific mechanics into standalone product concepts. State the user-visible domain behavior in feature docs and keep integration mechanics in integration docs or implementation notes.
- When validating UI or browser behavior, include proof (e.g. a screenshot) alongside the written verification summary.

## Checks & diff hygiene

- Don't run broad lint/typecheck after every edit. While debugging, use targeted tests, LSP diagnostics, or focused lint/typecheck. Run the appropriate full validation before commit/push when the task involved implementation.
- Treat repo-wide validation warnings as non-blocking only after confirming the command exited successfully and the warnings are unrelated.
- Re-check `git status` and the final diff after formatters, codegen, hooks, or generated artifacts run.
- Preserve the user's changes and any unrelated dirty work. Avoid unrelated refactors, formatting churn, generated-file churn, and metadata changes.
- Inspect the surrounding code before editing — don't assume old line numbers or prior context still match the file. Package only the intended diff when committing or pushing.
- After a PR is open, treat review-response edits as local until Hegar explicitly says to push them. Commit locally if useful, but do not push follow-up commits just because the branch already exists on remote.

---

## Hard cases

Worked examples for the rules that are hardest to convey in a sentence.

### Inline trivial helpers; abstract only to remove real complexity

```ts
// Over-abstracted: a one-line helper used in a single place, plus a wrapper
// around a trivial predicate.
function getActiveUsers(users: User[]) {
  return users.filter(isActive)
}
function isActive(u: User) {
  return u.status === "active"
}
const active = getActiveUsers(users)

// Preferred: inline the trivial branch; the predicate reads fine in place.
const active = users.filter((u) => u.status === "active")
```

Reach for an abstraction once it removes real complexity or duplication — not to name a single expression.

### Helper signature: primary value first, context object second

```ts
// Avoid: a long positional dependency list — the call site is unreadable.
async function archiveProfile(profileId: string, actorId: string, db: Db, tx: Tx) {}

// Preferred: primary domain value first, operational deps in one context object.
async function archiveProfile(profileId: string, { actorId, db }: AppContext) {}

// When the primary value has several fields, pass it as an object too.
async function createNote(note: { body: string; profileId: string }, { createdBy, tx }: WriteContext) {}
```

Pass the scalar directly when the primary value is a single identifier; use an object once it has multiple fields.

### Type guards before casts

```ts
// Avoid: assert the shape with a cast — `raw` was never actually checked.
const payload = JSON.parse(raw) as WebhookEvent
handle(payload.type)

// Preferred: validate at the boundary, then the type is earned, not asserted.
const parsed = webhookEventSchema.safeParse(JSON.parse(raw))
if (!parsed.success) return { ok: false, error: parsed.error }
handle(parsed.data.type)
```

A cast is a last resort; reach for a guard or schema first.

### Result over throwing for expected failures

```ts
type Result<T, E = string> = { ok: true; data: T } | { ok: false; error: E }

async function loadConfig(path: string): Promise<Result<Config>> {
  const file = Bun.file(path)
  if (!(await file.exists())) return { ok: false, error: "missing" }
  return { ok: true, data: parseConfig(await file.text()) }
}

const res = await loadConfig(path)
if (!res.ok) return renderMissingConfig(res.error) // expected, handled inline
use(res.data)
```

Throw only for genuinely exceptional paths. For failures the system should inspect, log, or route, return them as values.

### Keep boundary schemas source-shaped

```ts
// Avoid: a transform that exists only to rename provider fields snake -> camel.
const providerUser = z.object({
  first_name: z.string(),
  created_at: z.string(),
}).transform((u) => ({ firstName: u.first_name, createdAt: u.created_at }))

// Preferred: parse the source shape as-is; map names where the value is consumed.
const providerUser = z.object({ first_name: z.string(), created_at: z.string() })
const view = { firstName: parsed.first_name, createdAt: parsed.created_at }
```

The schema mirrors the boundary; renaming is a concern of the consumer, not the validator.

### Preserve a caller's Zod schema type

```ts
// Erases the caller's type — `data` arrives as `unknown`.
function defineEndpoint(input: z4.$ZodType, handler: (data: unknown) => void) {}

// Preferred: thread the schema through a generic so the inferred type survives.
function defineEndpoint<T extends z4.$ZodType>(
  input: T,
  handler: (data: z4.infer<T>) => void,
) {}
// `handler` now receives the caller's exact inferred type, not `unknown`.
```

---

## Updating this skill

Hegar has authorized agents to keep this skill current from his feedback. This is the single shared file for all agents — patching it here updates the guidance everywhere.

When Hegar gives feedback about code — including terse corrections like "don't use classes", "use Drizzle", "don't wrap that in a function", "too much abstraction", or "don't run that every time":

- Decide whether it's **durable, repo-agnostic style guidance** or a one-off/product/repo instruction. Only the former belongs here.
- If it's durable, patch this file in the same turn. Prefer sharpening an existing bullet over adding a new one, and keep edits concise and operational.
- Strip repo and product names — record the general principle, adding a neutral example only when it genuinely aids understanding.
- Don't add entries for product direction, single bugs, temporary workarounds, or conventions that apply only inside one repo (especially any that conflict with that repo's own instructions).
- Deep, specialized guidance that would bloat the main file (e.g. Postgres performance) belongs in a bundled reference file this skill links to, not inline.
