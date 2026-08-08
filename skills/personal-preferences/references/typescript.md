# 3 TypeScript

## 3.1 Types

### 3.1.1 Return types are inferred

Avoid explicit function return types unless the type checker or a public contract needs one.

### 3.1.2 `as const` for small stable shapes

Prefer `as const` for small stable object shapes over noisy return annotations.

### 3.1.3 Contracts own their fields

Infer domain and boundary types from focused producers or define the fields the contract owns. An ORM table's entire inferred row type must not be used as the contract.

### 3.1.4 Repeated type operations extract a small generic

Extract a small generic when several aliases repeat the same nested type operation.

### 3.1.5 Derived collections are typed from their source

Type derived collections from their inferred source values instead of declaring an interface that merely restates the producer's result.

### 3.1.6 Typed internals are trusted

Trust TypeScript inside typed functions. Do not revalidate data already owned by a typed internal contract.

### 3.1.7 Guards before casts

Use a type guard or boundary schema before a cast. Treat casting as a last resort.

### 3.1.8 Casts cover the exact incompatible expression

When a framework mismatch requires a cast, cast the exact incompatible expression while preserving contextual typing for the surrounding callback.

### 3.1.9 Real variants get a discriminator

Do not use arbitrary property-presence checks to compensate for unstable owned data. Give real variants a discriminator or normalize their shared shape at the producer boundary.

### 3.1.10 Normalize producers, not consumers

Do not build permissive union mappers around producers that return inconsistent representations of the same entity. Normalize the producers first and derive consumers from one canonical shape.

## 3.2 Runtime boundaries

### 3.2.1 Untrusted boundaries are validated

Validate complex data that crosses an untyped or untrusted runtime boundary. Earn a boundary type instead of asserting it:

```ts
const parsed = webhookEventSchema.safeParse(JSON.parse(raw))
if (!parsed.success) return { ok: false, error: parsed.error }

handle(parsed.data.type)
```

### 3.2.2 Trusted internal responses are not revalidated

Do not defensively revalidate trusted internal responses; type the contract and trust it.

### 3.2.3 Malformed contracts fail validation

Let malformed known contracts fail validation instead of hiding them behind defaults.

**Exception:** fallback behavior that is part of the contract.

### 3.2.4 Identifier validation lives with its owner

Keep shared identifier validation with the package that owns the identifier format.

### 3.2.5 Schemas are the contract, not regexes

Express reusable validation contracts as schemas rather than exporting raw regular-expression constants as the contract.

### 3.2.6 One shared boundary, derived adapters

Define a shared boundary once when client and server consumers interpret the same inputs; derive their framework adapters from that contract.

## 3.3 Schema validation

Defer to the schema library's own documentation for current APIs and idioms rather than restating them here. For Zod, that is the [API reference](https://zod.dev/api), the [v4 migration guide](https://zod.dev/v4/changelog) for deprecated-versus-current forms, and the [library authors guide](https://zod.dev/library-authors) for generic schema parameters.

### 3.3.1 Permissive objects use the library's current idiom

Allow unknown keys with the schema library's supported permissive-object form, and validate unknown values only when they genuinely require validation.

**Note:** on Zod 4 this means `z.looseObject({ ... })` over the deprecated `.passthrough()`, with `.catchall(...)` reserved for unknown values that need validation.

### 3.3.2 Source-boundary schemas stay source-shaped

Keep source-boundary schemas source-shaped. Map provider or database field names where values are consumed instead of transforming solely to rename fields.

### 3.3.3 Anti-corruption boundaries normalize in the schema

For an anti-corruption boundary that intentionally produces an app-owned shape, perform the full normalization in its schema rather than parsing and then running a separate normalization pass.

### 3.3.4 Coerce before validation, transform after

Normalize raw input with the library's preprocessing or coercion primitives before validation, and derive values only after the inner schema can already validate them (with Zod: `z.preprocess` or `z.coerce.*` before, `.transform()` after). Avoid codecs, stacked pipes, and transform chains unless bidirectional behavior is genuinely needed.

### 3.3.5 Typed codecs for JSON-string fields

Use a typed codec for a JSON-string field when its input contract is a string and its output schema is known; surface invalid JSON as a validation issue.

### 3.3.6 Built-in primitives first

Prefer the library's built-in coercion, format, and default primitives over hand-rolled equivalents when they express the source contract (for example `z.coerce.number()`, `z.url()`, and `.prefault()`).

### 3.3.7 Defaults for missing inputs still validate

When a missing input should receive a default, apply it so the value still passes through validation (Zod's `.prefault(value)`). Do not treat `null` as missing unless the source contract does.

### 3.3.8 Element schemas reject malformed elements

In array preprocessors, normalize each element and let the element schema reject malformed results. Drop elements only when dropping is part of the contract.

### 3.3.9 Trivial primitive schemas are inlined

Inline trivial primitive schemas unless an alias names a real domain concept or removes meaningful repetition.

### 3.3.10 Caller-supplied schema types are preserved

Preserve a caller-supplied schema's inferred type with a generic bounded by the library's schema type; do not erase it behind `unknown`.

```ts
function defineEndpoint<T extends z4.$ZodType>(
  input: T,
  handler: (data: z4.infer<T>) => void,
) {}
```

### 3.3.11 Diagnostics stay proportional

Avoid treeified or otherwise verbose error output unless a caller or debugging workflow needs it.

### 3.3.12 One safe parse on hot paths

On hot paths, run safe parsing once and branch on the result. Extract a generic parsing loop only when several consumers repeat the same behavior.
