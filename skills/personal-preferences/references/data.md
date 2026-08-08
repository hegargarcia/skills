# 4 Data

Rules in this chapter cover database work end to end: queries, mapping, schema design, migrations, and Postgres performance.

## 4.1 Queries and mapping

### 4.1.1 Typed query APIs over raw SQL

Prefer Drizzle query APIs, selections, helpers, and typed TypeScript mapping over raw SQL or string-built queries.

### 4.1.2 Filtering and counting happen in the database

Push filtering and counting into the database or API query instead of fetching a broader result and filtering it in application code.

### 4.1.3 Predicates compose with typed helpers

Compose predicates with typed helpers such as `or` and `isNotNull`. When `or(...)` is inferred as optional at a required boundary, use the narrow non-null assertion instead of falling back to raw SQL.

### 4.1.4 `.if(condition)` over predicate ternaries

Use Drizzle's conditional-expression API such as `.if(condition)` instead of ternaries that return a predicate or `undefined`.

### 4.1.5 Shared SQL helpers over repeated fragments

Use established shared SQL helpers for reusable timestamps, casts, aliases, search behavior, and operator semantics instead of repeating inline SQL fragments.

### 4.1.6 Helpers accept typed arrays

Pass multiple columns or expressions to a SQL helper as a typed array and join them inside the helper. Callers must not be made to wrap them in a raw SQL fragment.

### 4.1.7 Search builders return concrete predicates

Give custom search builders a concrete SQL predicate return type and normalize search text at the shared helper boundary.

### 4.1.8 Driver decoding lives in a shared mapper module

Put repeated driver decoding in a shared database mapper module and pass it to `mapWith`; do not mix value decoding into SQL expression helpers or repeat inline callbacks across queries.

**Note:** a generic such as `sql<Date>` changes only the TypeScript type, so map selected date expressions with their timestamp column or a shared decoder.

### 4.1.9 Fallbacks are expressed in the database

Prefer database fallback expressions such as `coalesce(updatedAt, createdAt)` in selections over repairing the result shape afterward.

### 4.1.10 Two typed queries over one brittle raw query

Prefer two typed queries plus clear TypeScript filtering over one brittle raw SQL expression when the typed single-query form becomes unreasonable.

### 4.1.11 Raw SQL is a disclosed last resort

Reserve raw SQL for cases where the typed or shared-helper path is genuinely unreasonable, and make that tradeoff explicit in the handoff.

## 4.2 Schemas and mutations

### 4.2.1 Column `enum` configuration for type safety

Use Drizzle's column `enum` configuration for TypeScript safety even when the database does not have a native enum type.

### 4.2.2 `.$defaultFn` for runtime-generated values

Use `.$defaultFn` for runtime-generated IDs and timestamps, especially with SQLite.

### 4.2.3 Database-side `now()` for audit timestamps

Prefer database-side `now()` for audit timestamps in conflict-update SQL so the recorded time belongs to the transaction.

### 4.2.4 Active rows resolve inside the mutation transaction

Resolve active-row identifiers inside the mutation transaction that uses them when another transaction could soft-delete and recreate the active row.

### 4.2.5 Upsert overwrite guards are atomic

Make upsert overwrite guards atomic by encoding the still-valid precondition in the conflict update. When no row is returned, reread the state needed to report the actual outcome instead of trusting a stale precheck.

## 4.3 Migrations and tests

### 4.3.1 Migrations run through repository tooling

Run migrations and backfills through the repository's package scripts and migration tooling. Do not hand-create generated artifacts, migration plumbing, or replacement control flow.

**Exception:** Hegar explicitly requests custom SQL.

### 4.3.2 Generated migration shapes are accepted

Prefer the migration tool's generated drop/create shape when it satisfies the requested change.

### 4.3.3 The query builder is never deep-mocked

Never deep-mock the Drizzle query-builder chain. Use the driver's mock or proxy driver so queries build normally while the test controls returned rows or captures compiled SQL.

## 4.4 Performance diagnosis

### 4.4.1 Reason from the query shape

Reason from the query shape first: filter location, operator type, join path, cardinality, requested sort, and whether the caller needs items, counts, or both. Do not optimize from one example query as if it represents every filter shape.

### 4.4.2 Measure with `EXPLAIN (ANALYZE, BUFFERS)`

Use `EXPLAIN (ANALYZE, BUFFERS)` and take separate timings for item queries, count queries, relation filtering, and join proof. Treat cold-cache and warm-cache timings as different signals.

## 4.5 Choosing indexes

### 4.5.1 Partial indexes for soft-delete tables

Use partial active-row indexes for soft-delete tables when the query always filters `deleted_at is null`.

### 4.5.2 Exact and fuzzy text paths stay separate

Use btree indexes for `eq` and `in`, and trigram GIN indexes for `like` and `ilike`.

### 4.5.3 Relation filters index the searched column with the join key

For relation filters, index the searched relation column with the join key. Cover residual predicates with included columns before adding duplicate partial indexes for every boolean variant.

### 4.5.4 No blanket current-only duplicates

Avoid blanket current-only duplicate indexes. Add a current-specific partial index only when measured query plans show that the predicate prunes enough rows to justify its write and storage cost.

## 4.6 Beyond indexes

### 4.6.1 Partitioning is a last resort

Do not reach for table partitioning unless common predicates actually prune partitions. Prefer partial indexes, covering indexes, denormalized join keys, or a purpose-built read model first.

### 4.6.2 Denormalize sort keys when indexes cannot stabilize latency

When relation filters and the default sort live on different tables, consider denormalizing the sort or owner key onto relation rows, or building a filter-terms read model, when indexes alone cannot stabilize item-page latency.
