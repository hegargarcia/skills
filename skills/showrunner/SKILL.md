---
name: showrunner
description: The default end-to-end workflow for feature development — plans the work as a task graph, builds it, opens draft PRs as slices complete, and works review feedback until merge. Fire on any request to implement, add, build, fix, refactor, wire up, or ship product code — "add an endpoint for X", "fix the upload bug", "make the card show Y", a ticket ID like FON-1234, a pasted PR or thread — even when no skill is named and no ticket exists. Fire also when a feature arrives as an open question — "give me proposals for the UI", "how should we build X", "we're missing a Y", "we want to ship Z" — proposals and direction-picking are this workflow's planning step, not a reason to skip it. And fire on feedback for open PRs — "address the review comments", "check greptile", "rebase and fix the feedback". Skip for questions about existing behavior, standalone code review (that's the code-review skill), and work outside a product codebase.
---

# Showrunner — ship a change end to end

One lead agent — you — owns the delivery: understand the ask, plan the work as a graph, build it, open draft PRs as slices complete, and run review feedback to merge. There are no standing roles and no relay; you implement directly and delegate only when a specific piece of work benefits from it.

This skill sequences the work; it does not define standards. How code, tests, commits, and prose are shaped is governed by the personal-preferences style guide and the repository's own instructions — read the chapters that apply and follow them. Rules here name patterns ("the tracker", "the automated reviewer", "the stacking tool"); any specific product is an illustration from the current stack.

## 1 · Intake

Work arrives as a ticket, a PR, a thread, or a plain request. Gather enough to state the goal, the acceptance criteria (explicit or inferred and confirmed), and the non-goals. Scope is a hard boundary — no unrelated cleanup, refactors, or product work.

A tracker ticket is optional context, never a prerequisite. Never create or restructure tickets to satisfy this workflow; the tracker is an audit trail for the team, not the driver.

## 2 · Plan as a graph

Decompose the work into a dependency graph of buildable nodes — each node a coherent slice whose impact you can state in one sentence (if you can't, re-cut it). Register the nodes and their blocked-by edges in the harness's task list when one exists.

For anything beyond small or mechanical work, render the plan with the **html-plan** skill (it lives at `.cache/plans/<slug>/plan.html` inside the repo, gitignored) and share the path. Put genuine open questions in the plan as decision cards rather than blocking on chat.

Ask for approval once, and only when scope or approach is genuinely ambiguous or the change is large. Small, well-understood work proceeds without ceremony.

**Tracker touchpoint 1 of 2:** if a ticket exists, post the plan summary as a comment and move the ticket to its in-progress state.

## 3 · Build ready nodes

You implement directly. Work the graph: take unblocked nodes, build them, mark them done, and keep the plan file's JSON current (re-read it at phase boundaries and after any context compaction — it is the durable state, your context window is not).

Delegate to a subagent only when a node genuinely benefits from parallelism or fresh context. Subagents are short-lived and task-scoped: a self-contained brief, a bounded task, a structured or tightly summarized return. Never spawn standing roles, never relay messages between agents, and never poll — await the result or let its completion notification come to you.

Verify per the style guide's testing chapter: targeted checks while building, full validation before any commit or push.

## 4 · Draft PR per slice

When a slice is complete and validated, cut it and open a **draft PR immediately** — never hold finished work for an end-of-delivery packaging step. Slices are cut for review complexity, not deploy safety; each PR should be judgeable without holding the whole change in your head. Branch and stack mechanics belong to the stacking tool's skill (currently `gh-stack`). Descriptions follow the style guide's writing chapter: outcome first, reviewer narrative, explicit dependency order for stacks.

## 5 · Review pass

Before calling the delivery done, run one fresh-context review subagent over the full working state, applying the style guide and repository conventions — simplicity, naming and taxonomy fit with the existing codebase, and reviewability are the point, not plan-conformance. Exercise the running app (a functional check) only when user-facing behavior warrants it, and include concrete proof.

Fix what the review surfaces. Done means: the graph is done, the review is clean, and the drafts are marked ready for review with the links handed to Hegar.

## 6 · Feedback loop until merge

All post-PR feedback — automated reviewer, human review, or chat — runs through one loop: collect, triage against the real code, fix, respond, and close out every item. See `references/feedback-loop.md`.

Hegar makes the call on the first round's triage; after that the loop runs autonomously, **including pushes** — with one discipline: a push always carries a complete, fully validated response to the feedback it addresses. Never push a partial understanding of a problem to show progress; finish the fix, validate, then push. Never force-push. An escalation pauses the loop.

**Merging is a human act.** Merge only with unambiguous, specific authorization; confirm anything that merely reads like it. Prepping a branch is never authorization to merge.

**Tracker touchpoint 2 of 2:** if a ticket exists, post the PR links when they go up and set the ticket's final state when the work merges. Nothing in between.

## Escalation and pausing

Hegar can pause everything at any time. Stop and ask — with your recommendation — when an implementation choice would change product behavior, scope, or the agreed plan; when acceptance criteria turn out ambiguous; when feedback conflicts with a standing rule; or when a blocker appears. Otherwise, keep moving.

## References

- `references/feedback-loop.md` — triage verdicts and close-out mechanics for post-PR feedback.
- The `html-plan` skill — the plan artifact (step 2).
- The stacking tool's skill (`gh-stack`) — branch and stacked-PR mechanics (step 4).
