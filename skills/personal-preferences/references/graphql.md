# 5 GraphQL

## 5.1 Schemas and mutations

### 5.1.1 Mutation results are unions of named types

Model a mutation result as a union of a success type and specific named error types for its distinct expected failures.

### 5.1.2 Named error types are reused

Reuse the same named error type across unions when it represents the same failure contract.

### 5.1.3 No `success` booleans or catch-all errors

Typed mutation outcomes must not be replaced with `success` booleans, string codes, or one catch-all mutation error carrying a code enum.

## 5.2 Resolvers and mappers

### 5.2.1 Resolvers are thin delegates

Keep resolvers as thin delegates. Put query and mutation behavior in the owning data source, service, or domain module.

### 5.2.2 No cross-resolver imports

Do not import reusable behavior from another resolver file; move shared logic to a module whose ownership and name fit the codebase taxonomy.

### 5.2.3 Resolver methods use object-method shorthand

Use object-method shorthand for resolver methods.

### 5.2.4 Field maps are keyed by their generated resolver type

Key a resolver module's field map with the generated resolver type for the GraphQL type it implements, not a generic `Resolvers` alias.

### 5.2.5 Codegen mappers require a genuine shape difference

Use the code generator's mapper configuration when a resolver parent or returned object legitimately differs from the schema shape or carries source-only fields required by child resolvers. Do not bridge a shape difference with `as unknown as` casts, and do not configure a mapper when producer and schema shapes already match.

### 5.2.6 Mapper parent types live in the mapper module

Keep mapper parent types in the package's established mapper module rather than defining them inside resolver or data-source files.

### 5.2.7 Methods state their action and subject

Name data-source and service methods as functions that state their action and subject; do not mirror a GraphQL field name as a bare method name.

## 5.3 Batch loaders

Defer to the loader library's own documentation for batching, caching, and per-request lifecycle patterns; the [DataLoader README](https://github.com/graphql/dataloader) is the authoritative guide.

### 5.3.1 Typed inputs, inferred results

Type the batch function's input and let the loader's generics and result type infer when they remain clear.

### 5.3.2 Loaders follow `<subject>By<Key>` naming

Name loaders with the repository's `<subject>By<Key>` convention rather than a `get` prefix.

### 5.3.3 Custom cache keys only for composite keys

Keep a custom cache key function (DataLoader's `cacheKeyFn`) when composite keys require it; do not add one mechanically for scalar keys.
