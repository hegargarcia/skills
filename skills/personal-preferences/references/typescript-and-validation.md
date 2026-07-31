# TypeScript and validation

## Types

- Avoid explicit function return types unless the type checker or a public contract needs one.
- Prefer `as const` for small stable object shapes over noisy return annotations.
- Infer domain and boundary types from focused producers or define the fields the contract owns; do not use an ORM table's entire inferred row type as the contract.
- Extract a small generic when several aliases repeat the same nested type operation.
- Type derived collections from their inferred source values instead of declaring an interface that merely restates the producer's result.
- Trust TypeScript inside typed functions. Do not revalidate data already owned by a typed internal contract.
- Use a type guard or boundary schema before a cast. Treat casting as a last resort.
- When a framework mismatch requires a cast, cast the exact incompatible expression while preserving contextual typing for the surrounding callback.
- Do not use arbitrary property-presence checks to compensate for unstable owned data. Give real variants a discriminator or normalize their shared shape at the producer boundary.
- Do not build permissive union mappers around producers that return inconsistent representations of the same entity. Normalize the producers first and derive consumers from one canonical shape.
- Configure GraphQL Codegen parent mappers only when producer and schema shapes genuinely differ or the producer carries source-only fields required by child resolvers.

## Runtime boundaries

- Validate complex data that crosses an untyped or untrusted runtime boundary.
- Do not defensively revalidate trusted internal responses; type the contract and trust it.
- Let malformed known contracts fail validation instead of hiding them behind defaults, unless fallback behavior is part of the contract.
- Keep shared identifier validation with the package that owns the identifier format.
- Express reusable validation contracts as schemas rather than exporting raw regular-expression constants as the contract.
- Define a shared boundary once when client and server consumers interpret the same inputs; derive their framework adapters from that contract.

## Zod

- On Zod 4, prefer `z.looseObject({ ... })` over deprecated `.passthrough()` for permissive objects. Use `.catchall(...)` only when unknown values themselves require validation.
- Keep source-boundary schemas source-shaped. Map provider or database field names where values are consumed instead of transforming solely to rename fields.
- For an anti-corruption boundary that intentionally produces an app-owned shape, perform the full normalization in its schema rather than parsing and then running a separate normalization pass.
- Use `z.preprocess` or `z.coerce.*` when raw input must be normalized before validation. Use `.transform()` only after the inner schema can already validate the value.
- Prefer direct coercion schemas and narrow preprocessors over codecs, stacked pipes, or transform chains unless bidirectional behavior is genuinely needed.
- Use a typed codec for a JSON-string field when its input contract is a string and its output schema is known; surface invalid JSON as a validation issue.
- Prefer built-in APIs such as `z.coerce.number()`, `z.url()`, and `.prefault()` when they express the source contract.
- Use `.prefault(value)` when a missing input should receive a default and still pass through validation. Do not treat `null` as missing unless the source contract does.
- In array preprocessors, normalize each element and let the element schema reject malformed results. Drop elements only when dropping is part of the contract.
- Inline trivial primitive schemas unless an alias names a real domain concept or removes meaningful repetition.
- Preserve a caller-supplied schema's inferred type with a generic such as `T extends z4.$ZodType`; do not erase it behind `unknown`.
- Keep diagnostics proportional. Avoid treeified or otherwise verbose error output unless a caller or debugging workflow needs it.
- On hot paths, call `safeParse` once and branch on the result. Extract a generic parsing loop only when several consumers repeat the same behavior.

## Representative examples

Earn a boundary type instead of asserting it:

```ts
const parsed = webhookEventSchema.safeParse(JSON.parse(raw))
if (!parsed.success) return { ok: false, error: parsed.error }

handle(parsed.data.type)
```

Preserve a caller's schema type:

```ts
function defineEndpoint<T extends z4.$ZodType>(
  input: T,
  handler: (data: z4.infer<T>) => void,
) {}
```
