# 9 Writing

## 9.1 Explaining the work

### 9.1.1 Outcome and mental model come first

Lead with the outcome, mental model, audience, terms, and governing rules before implementation details.

### 9.1.2 Descriptions stay brief

Keep tool and schema descriptions brief. Use one representative example instead of enumerating every obvious case.

### 9.1.3 Explain the non-obvious

Explain non-obvious selection rules, boundaries, and conditional requirements; do not restate self-explanatory enum values.

## 9.2 Documentation

### 9.2.1 Docs are current-state reference material

Treat product docs as current-state reference material, not as a decision log.

### 9.2.2 Feedback improves the artifact

Apply feedback by improving the artifact; do not transcribe review wording or negative instructions into the artifact as content.

### 9.2.3 Present behavior in docs, history elsewhere

State present behavior and invariants directly. Keep migration decisions, rollout sequencing, deferred work, and historical behavior in issues or pull requests.

### 9.2.4 Code-adjacent docs describe current intended use

Make code-adjacent docs, docstrings, schema descriptions, and prompts describe their current intended use. Omit future plans, transition notes, and incidental implementation facts that do not help the reader.

### 9.2.5 Rules are grouped by the reader's question

Group rules by the reader's question or lifecycle area. Use tables when states or categories scan more clearly than prose.

### 9.2.6 Transport mechanics stay out of the product model

Keep transport formats and provider-specific mechanics out of the product mental model. Put them in integration docs or implementation notes.

## 9.3 Pull-request descriptions

### 9.3.1 One sentence states the outcome

Start with one sentence stating the outcome.

### 9.3.2 Sections must earn their place

Explain behavior and review boundaries with sections such as `How it works`, `Boundaries`, `Validation`, `Docs`, or `Stack` only when they materially help the reviewer.

### 9.3.3 Reviewer narrative over changelog summaries

Prefer a reviewer-oriented narrative over a generic changelog-style `Summary`.

### 9.3.4 Verification and stack order are explicit

Include concrete verification and make dependency order explicit for stacked pull requests.
