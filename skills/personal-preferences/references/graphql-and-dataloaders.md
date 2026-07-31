# GraphQL and DataLoader

## Schemas and mutations

- Model a mutation result as a union of a success type and specific named error types for its distinct expected failures.
- Reuse the same named error type across unions when it represents the same failure contract.
- Do not replace typed mutation outcomes with `success` booleans, string codes, or one catch-all mutation error carrying a code enum.

## Resolvers and mappers

- Keep resolvers as thin delegates. Put query and mutation behavior in the owning data source, service, or domain module.
- Do not import reusable behavior from another resolver file; move shared logic to a module whose ownership and name fit the codebase taxonomy.
- Use object-method shorthand for resolver methods.
- Key a resolver module's field map with the generated resolver type for the GraphQL type it implements, not a generic `Resolvers` alias.
- Use GraphQL Codegen mappers when a resolver parent or returned object legitimately differs from the schema shape. Do not bridge the difference with `as unknown as` casts.
- Keep mapper parent types in the package's established mapper module rather than defining them inside resolver or data-source files.
- Name data-source and service methods as functions that state their action and subject; do not mirror a GraphQL field name as a bare method name.

## DataLoader

- Type the batch function's input and let DataLoader's generics and result type infer when they remain clear.
- Name loaders with the repository's `<subject>By<Key>` convention rather than a `get` prefix.
- Keep `cacheKeyFn` when composite keys require it; do not add it mechanically for scalar keys.
