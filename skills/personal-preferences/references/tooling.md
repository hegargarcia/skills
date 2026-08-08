# 7 Tooling

## 7.1 Libraries and runtimes

### 7.1.1 Active packages over custom solutions

Before writing a custom solution, look for an npm package that covers the need and shows active development. Prefer proven libraries for core mechanics such as Git, SQL, parsers, and protocol clients over hand-rolled wrappers.

**Exception:** Hegar specifies a custom implementation.

### 7.1.2 Package-backed APIs over shell wrappers

Prefer package-backed, type-aware APIs over custom shell or tool wrappers when a suitable package exists.

### 7.1.3 Replacement semantics are verified

Verify replacement-library semantics against the edge behavior the existing implementation depends on; similar APIs can differ in failures, empty results, timezones, and platform behavior.

### 7.1.4 No redundant conversion layers

Pass values directly when a library already accepts their source type; do not add redundant conversion or parsing layers.

### 7.1.5 Dependencies must earn inclusion

Add dependencies only when they materially reduce fragility or match the requested direction.

### 7.1.6 The repository's package manager is used

Use the repository's package manager; do not switch package managers for convenience.

### 7.1.7 The repository runtime is respected

Use the runtime's own commands and native primitives first, and reach for compatibility APIs only for operations it does not provide. In Bun projects, that means Bun commands and native file primitives first, with `node:` APIs as the fallback; defer to [Bun's Node.js compatibility reference](https://bun.com/docs/runtime/nodejs-apis) for what each side covers.

### 7.1.8 No convenience I/O wrappers

Use the runtime or standard library directly instead of writing convenience I/O wrappers.

### 7.1.9 Typed clients before raw escape hatches

When a library offers both a typed client and a raw escape hatch, use the typed surface and drop to raw commands only when no typed method covers the operation (for example `simpleGit()` versus `.raw`).

### 7.1.10 CLIs use an established framework

Build CLIs with an established framework that provides parsing, help, versions, and unknown-command handling. Keep schema validation focused on argument values, and avoid unstable pre-1.0 dependencies for unattended tooling.

## 7.2 Environment and installation

### 7.2.1 Environment values pass through the typed schema

Validate required runtime environment values in the project's typed environment schema or loader and pass the typed values forward.

### 7.2.2 No existence-asserting getter wrappers

Do not add getter wrappers whose only purpose is asserting that an environment variable exists.

### 7.2.3 Platform-owned variables over project aliases

Prefer platform-owned environment variables over project-specific aliases for the same value.

### 7.2.4 Installation authorization is narrow

Treat authorization to install a tool narrowly. Do not add workspace directories, personal package prefixes, shell `PATH` entries, or user configuration unless Hegar requested them or the tool strictly requires them to function.

### 7.2.5 Shared tooling carries no machine specifics

Keep shared tooling free of hardcoded home directories, repository URLs, and absolute binary paths. Derive machine-specific values at runtime and keep personal configuration in ignored environment files with committed examples when the project uses that pattern.
