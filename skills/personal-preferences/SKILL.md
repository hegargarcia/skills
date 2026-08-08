---
name: personal-preferences
description: Hegar's durable, cross-project preferences for how agents shape code, tests, documentation, plans, tooling changes, reviews, and handoffs. Apply silently whenever work requires subjective choices or creates or modifies an artifact. Let explicit current instructions and repository conventions take precedence. Feedback is folded in by a weekly review job; edit the tracked skill mid-session only when Hegar explicitly asks.
---

# Hegar's Personal Style Guide

## 1 Introduction

This document serves as the complete definition of Hegar's durable, cross-project preferences for shaping code, tests, documentation, plans, tooling changes, reviews, and handoffs. It preserves his taste across agents, sessions, and repositories. Use it as a small personal operating manual, not as a substitute for understanding the current task or codebase.

### 1.1 Terminology notes

In this guide, the terms *must*, *must not*, *should*, *should not*, and *may* are to be interpreted as described in RFC 2119. The terms *prefer* and *avoid* correspond to *should* and *should not*, respectively. Imperative and declarative statements are prescriptive and correspond to *must*.

Other explanatory notes appear as **Tip:**, **Note:**, or **Exception:** callouts.

### 1.2 Guide notes

Example code in this guide is **non-normative**. That is, while the examples follow this guide, they do not illustrate the only stylish way to satisfy a rule. Optional stylistic choices made in examples must not be enforced as rules.

### 1.3 Precedence

Instructions closer to the current work always win. Resolve guidance in this order, highest first:

1. Hegar's explicit current-turn instructions.
2. Repository-local instructions and established surrounding conventions.
3. This guide, used to fill gaps and make judgment calls.

This guide must not be used to override safety requirements, product decisions, or deliberate repository conventions.

### 1.4 Application

Apply this guide silently. It is an internal guardrail, not a user-facing workflow; do not announce it unless higher-level instructions require disclosure.

Treat the guide as constant: apply it, do not update it. Feedback is folded into the tracked source by a weekly review job. Edit the tracked source in the skills repository only when Hegar explicitly asks, and never edit a detached installed copy.

### 1.5 Core principles

- Prefer directness over indirection.
- Model real concepts, ownership, and boundaries instead of papering over them with convenient stand-ins.
- Respect established local patterns before introducing something novel.
- Keep scope and diffs small; avoid speculative completeness and incidental cleanup.
- Preserve the purpose of an existing artifact when changing its implementation or vocabulary.
- Trust strong types and contracts; validate at real runtime boundaries.
- Add abstractions only when they remove meaningful complexity or duplication.
- Verify in proportion to risk and provide concrete evidence for behavior that benefits from it.
- Explain outcomes and mental models before implementation details.

### 1.6 Reading this guide

Chapters 2–9 live under `references/`. Chapters 2–5 cover the artifact being shaped, from general code down to specific stack layers; chapters 6–9 cover the working process: verifying, tooling, shipping, and explaining. Before acting, read every chapter whose scope materially applies to the work; do not load unrelated chapters.

- [2 Code](./references/code.md) — naming, abstraction, control flow, boundaries, and structure for any code, in any language or framework.
- [3 TypeScript](./references/typescript.md) — the type system, casts, runtime validation, and Zod.
- [4 Data](./references/data.md) — databases end to end: queries, mapping, schemas, migrations, and Postgres performance.
- [5 GraphQL](./references/graphql.md) — schema design, resolvers, codegen mappers, and DataLoader.
- [6 Testing](./references/testing.md) — which tests to write, their shape, and how to verify finished work.
- [7 Tooling](./references/tooling.md) — dependencies, runtimes, environment configuration, and tool installation.
- [8 Delivery](./references/delivery.md) — diffs, commits, branches, pushes, and review flow.
- [9 Writing](./references/writing.md) — documentation, technical explanations, and pull-request prose.
