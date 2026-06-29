# Postgres performance & indexing

Reference for Postgres query-tuning and index work. Read this before optimizing a query or adding indexes. The general database rules live in [SKILL.md](./SKILL.md).

## Diagnose before optimizing

- Reason from the query shape first: filter location, operator type, join path, cardinality, requested sort, and whether the caller needs items, counts, or both. Don't optimize from one example query as if it represents every filter shape.
- Use `EXPLAIN (ANALYZE, BUFFERS)` and take separate timings for item queries, count queries, relation filtering, and join proof. Treat cold-cache and warm-cache timings as different signals.

## Index choices

- Use partial active-row indexes for soft-delete tables when the query always filters `deleted_at is null`.
- Keep exact and fuzzy text paths separate: btree indexes for `eq`/`in`, trigram GIN indexes for `like`/`ilike`. Don't expect one index shape to serve both well.
- For relation filters, index the searched relation column together with the join key. Cover residual predicates with included columns before adding duplicate partial indexes for every boolean variant.
- Avoid blanket "current-only" duplicate indexes. Add a current-specific partial index only when `EXPLAIN (ANALYZE, BUFFERS)` shows the current predicate prunes enough rows to justify the write and storage cost.

## When indexes aren't enough

- Don't reach for table partitioning unless common predicates actually prune partitions. For flexible filter surfaces, prefer partial indexes, covering indexes, denormalized join keys, or a purpose-built filter read model first.
- When relation filters and the default sort live on different tables, indexes alone may not stabilize latency. Consider denormalizing the sort/owner key (e.g. `person_id`) onto the relation rows, or building a filter-terms read model, for stable item-page latency.
