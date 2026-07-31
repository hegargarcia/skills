# Data and databases

## Queries and mapping

- Prefer Drizzle query APIs, selections, helpers, and typed TypeScript mapping over raw SQL or string-built queries.
- Push filtering and counting into the database or API query instead of fetching a broader result and filtering it in application code.
- Compose predicates with typed helpers such as `or` and `isNotNull`. When `or(...)` is inferred as optional at a required boundary, use the narrow non-null assertion instead of falling back to raw SQL.
- Use Drizzle's conditional-expression API such as `.if(condition)` instead of ternaries that return a predicate or `undefined`.
- Use established shared SQL helpers for reusable timestamps, casts, aliases, search behavior, and operator semantics instead of repeating inline SQL fragments.
- Pass multiple columns or expressions to a SQL helper as a typed array and join them inside the helper; do not make callers wrap them in a raw SQL fragment.
- Give custom search builders a concrete SQL predicate return type and normalize search text at the shared helper boundary.
- Put repeated driver decoding in a shared database mapper module and pass it to `mapWith`. Do not mix value decoding into SQL expression helpers or repeat inline callbacks across queries.
- Remember that a generic such as `sql<Date>` changes only the TypeScript type. Map selected date expressions with their timestamp column or a shared decoder.
- Prefer database fallback expressions such as `coalesce(updatedAt, createdAt)` in selections over repairing the result shape afterward.
- Prefer two typed queries plus clear TypeScript filtering over one brittle raw SQL expression when the typed single-query form becomes unreasonable.
- Reserve raw SQL for cases where the typed or shared-helper path is genuinely unreasonable, and make that tradeoff explicit in the handoff.

## Schemas and mutations

- Use Drizzle's column `enum` configuration for TypeScript safety even when the database does not have a native enum type.
- Use `.$defaultFn` for runtime-generated IDs and timestamps, especially with SQLite.
- Prefer database-side `now()` for audit timestamps in conflict-update SQL so the recorded time belongs to the transaction.
- Resolve active-row identifiers inside the mutation transaction that uses them when another transaction could soft-delete and recreate the active row.
- Make upsert overwrite guards atomic by encoding the still-valid precondition in the conflict update. When no row is returned, reread the state needed to report the actual outcome instead of trusting a stale precheck.

## Migrations and tests

- Run migrations and backfills through the repository's package scripts and migration tooling. Do not hand-create generated artifacts, migration plumbing, or replacement control flow unless Hegar explicitly requests custom SQL.
- Prefer the migration tool's generated drop/create shape when it satisfies the requested change.
- Never deep-mock the Drizzle query-builder chain. Use the driver's mock or proxy driver so queries build normally while the test controls returned rows or captures compiled SQL.

For Postgres query tuning or index design, also read [postgres-performance.md](./postgres-performance.md).
