# Postgres performance and indexing

Read this reference before optimizing a Postgres query or adding indexes. Use the general database preferences in [data-and-databases.md](./data-and-databases.md) as the baseline.

## Diagnose before optimizing

- Reason from the query shape first: filter location, operator type, join path, cardinality, requested sort, and whether the caller needs items, counts, or both. Do not optimize from one example query as if it represents every filter shape.
- Use `EXPLAIN (ANALYZE, BUFFERS)` and take separate timings for item queries, count queries, relation filtering, and join proof. Treat cold-cache and warm-cache timings as different signals.

## Choose indexes deliberately

- Use partial active-row indexes for soft-delete tables when the query always filters `deleted_at is null`.
- Keep exact and fuzzy text paths separate: use btree indexes for `eq` and `in`, and trigram GIN indexes for `like` and `ilike`.
- For relation filters, index the searched relation column with the join key. Cover residual predicates with included columns before adding duplicate partial indexes for every boolean variant.
- Avoid blanket current-only duplicate indexes. Add a current-specific partial index only when measured query plans show that the predicate prunes enough rows to justify its write and storage cost.

## Recognize when indexes are insufficient

- Do not reach for table partitioning unless common predicates actually prune partitions. Prefer partial indexes, covering indexes, denormalized join keys, or a purpose-built read model first.
- When relation filters and the default sort live on different tables, consider denormalizing the sort or owner key onto relation rows, or building a filter-terms read model, when indexes alone cannot stabilize item-page latency.
