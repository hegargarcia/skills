# Tooling and delivery

## Libraries and runtimes

- Prefer proven libraries for core mechanics such as Git, SQL, parsers, and protocol clients over hand-rolled wrappers.
- Prefer package-backed, type-aware APIs over custom shell or tool wrappers when a suitable package exists.
- Pass values directly when a library already accepts their source type; do not add redundant conversion or parsing layers.
- Add dependencies only when they materially reduce fragility or match the requested direction.
- Use the repository's package manager; do not switch package managers for convenience.
- Respect the repository runtime. In Bun projects, use Bun commands and native file primitives first, and use `node:` APIs for operations Bun does not provide.
- Use the runtime or standard library directly instead of writing convenience I/O wrappers.
- With `simple-git`, use the typed client returned by `simpleGit()` and use `.raw` only when no typed method covers the operation.

## Environment and installation

- Validate required runtime environment values in the project's typed environment schema or loader and pass the typed values forward.
- Do not add getter wrappers whose only purpose is asserting that an environment variable exists.
- Prefer platform-owned environment variables over project-specific aliases for the same value.
- Treat authorization to install a tool narrowly. Do not add workspace directories, personal package prefixes, shell `PATH` entries, or user configuration unless Hegar requested them or the tool strictly requires them to function.

## Diffs, Git, and review flow

- Preserve Hegar's changes and unrelated dirty work.
- Avoid unrelated refactors, formatting churn, generated-file churn, compatibility scaffolding, and speculative branches.
- Inspect surrounding code immediately before editing; do not trust stale line numbers or prior context.
- Package only the intended diff when committing or pushing.
- When Hegar explicitly asks to commit and push, use the current branch. Do not invent a branch or pull request unless he asks for one or repository instructions require it.
- After a pull request is open, keep review-response edits local until Hegar explicitly asks to push them. Commit locally when useful, but do not push merely because the branch already exists remotely.
