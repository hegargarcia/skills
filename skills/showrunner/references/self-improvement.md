# Self-improvement: edit policy, invariants, and changelog

The Product agent owns this. Read it before changing the skill in any way.

## What you may edit
- `SKILL.md` — the orchestrator workflow.
- `agents/*.md` — the role briefs.
- `references/*.md` — supporting material (you may add new files here).

Edit the skill's **source** (its repo or working copy), never a read-only installed copy. Edits take effect on the **next** run — the current ticket finishes under the rules it started with. Self-improvement is durable, not live mid-run patching.

## Graduated by risk
Match the action to the risk:

1. **Additive (low risk — default).** Append a lesson, a clarifying note, an example, or a new `references/*.md` file. You may make additive changes and record them, no approval needed.
2. **Modifying or removing an existing instruction (higher risk).** Propose a diff with a one-paragraph rationale and get explicit human approval before it lands.
3. **Touching an invariant (below).** Never do this without the human explicitly approving *that specific invariant change*, called out as such.

Prefer additive fixes. A new clarifying note or example usually closes a process gap with less risk of contradiction or drift than rewriting an existing rule.

**Mirrored content.** The severity-label block is duplicated in `SKILL.md` and three role briefs (Functional QA, Code Review, Documentation) on purpose — role agents start cold and need it inline. If you change a label, change all four copies in the same edit.

## Invariants — preserve these
The loop may refine wording, add material, and tune triggers, but it must not weaken or delete these without explicit human sign-off:

- Human approves the plan before any code is written (the plan-approval gate).
- The human can pause anything at any time; you escalate on product drift, ambiguity, unresolved disagreement, or blockers.
- One agent per role per ticket; role agents run in clean, role-specific conversations; all roles inspect the same worktree.
- Only the Documentation agent edits the product-documentation folder.
- The ticket's scope and non-goals are hard boundaries.
- This self-improvement process keeps its own guardrails: triage first, the graduated edit policy, human approval for modify/remove/invariant changes, and a changelog entry for every change.

If feedback seems to demand weakening an invariant, that's a signal to escalate to the human — not to self-edit.

## Changelog
Record every skill change in `CHANGELOG.md`, newest first, using this format:

```
## <date> — <short title>
- **Feedback:** what prompted this (one or two lines).
- **Triage:** operational (or note why an exception applies).
- **Change:** what you edited or added, and where.
- **Approval:** "additive — no approval needed" or "approved by <human>".
```

A change isn't done until it's in the changelog.
