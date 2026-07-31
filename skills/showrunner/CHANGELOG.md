# Changelog

Newest first. See `references/self-improvement.md` for when and how to add entries.

## 2026-07-31 — Review pass: relay model, spawn mechanics, verification gate, slicing criterion
- **Feedback:** a full read-through of the skill (not a ticket run) surfaced instructions that couldn't execute as written and gaps that produce recurring red builds. Also two corrections to the review's own findings from Hegar: per-agent worktree isolation is handled at the harness level and doesn't belong in the skill, and slicing is now about **review complexity, not deploy sequencing**, because the new CD system holds service deployment in a dependency graph.
- **Triage:** operational — each item is a property of how the skill is written and would recur on every ticket.
- **Change:**
  - `SKILL.md` — replaced the "sub-agents may communicate directly" claim with a **relay model** (Product is the only channel between roles; that relay is what makes the oversight triggers enforceable), and updated the Code Review loop bullet to match. Added **Spawning and continuing** plus a **pass contents, not paths** table to Agent briefs (role agents run in the project repo, so relative `references/*.md` paths never resolved for them; the table says which references each role gets). Expanded **Gate 2** from one sentence to a four-item checklist (AC coverage with evidence, non-goals intact, role verdicts collected with open P2/P3 accepted or ticketed, PR breakdown still matches what got built). Added a **parallel passes** note to the build/verify loop (QA / Review / Docs read the same tip; run them concurrently and consolidate into one Engineer round).
  - `references/verification-gate.md` — new: the ordered format → lint → typecheck → tests → full-suite bar, with "read CI config, don't assume the commands", when it applies, and how to handle pre-existing failures. Absorbs the 2026-07-23 format-gate lesson.
  - `references/pr-standards.md` — added the **slice for review complexity, not deploy safety** criterion (CD sequences rollout, so no slice must be independently shippable) and a **How to cut the stack** section for Gate 3 that **defers the branch plumbing to the `gh-stack` skill** rather than restating it, keeping only the two judgment calls the tool doesn't make (cut in dependency order so per-PR CI is green by construction; clear the verification gate on each branch, not just the tip). `agents/engineer.md` points at the same skill for packaging.
  - `SKILL.md` Linear hygiene — recast the state transitions as **intents rather than state names** (work-started / awaiting-review / done), since workflow states and their semantics are the team's; the skill now says to read the team's states once and map by meaning, and to ask when two states could plausibly carry an intent. Gate 1's literal `In Progress` generalized to match.
  - `references/feedback-loop.md` — the circular "same verification you'd run" now names the gate.
  - `agents/engineer.md` — verification gate replaces the standalone format bullet; loops re-worded as round-trips via Product; added repo `CLAUDE.md` + `personal-code-style` + commit-convention adherence, and commit-along-the-seams to make Gate 3 cheap.
  - `agents/code-review.md`, `agents/functional-qa.md` — findings return via Product, not directly to the Engineer. Fixed QA's `P3` label, which had drifted out of sync with the other three copies.
  - `references/self-improvement.md` — noted that the severity block is mirrored in four files and must be changed together.
- **Approval:** approved by hegar (this session), item by item. Two findings deliberately **not** actioned: source/installed-copy drift (being solved separately by the skill-sync project) and a worktree-isolation rule (harness-level concern).

## 2026-07-23 — Merging is a human gate; confirm ambiguous authorization
- **Feedback:** Hegar asked "why did you merged?" after Product interpreted "it's merch, please. Rebase the rest of the stack" as merge authorization and landed the FON-1987 stack; the likelier reading was "it's merged" (he had just merged the bottom PR himself) plus a request to prep the rest.
- **Triage:** operational; ambiguous transcribed instructions before irreversible actions will recur.
- **Change:** added a "Merging is a human gate" section to SKILL.md: unambiguous delegation required, confirm ambiguous phrasing, prep is never merge authorization.
- **Approval:** additive — no approval needed.

## 2026-07-23 — Product never touches the repo, even for mechanical fixes
- **Feedback:** Hegar: "never make the changes yourself, you are the manager" — after Product had directly committed a format fix and a one-line SDL copy fix on FON-1987.
- **Triage:** operational; the "it's just mechanical" exception will recur on every ticket without a rule.
- **Change:** expanded the Product role definition in SKILL.md to state Product never commits/pushes repo changes of any size; Engineer owns all repo writes.
- **Approval:** additive — no approval needed.

## 2026-07-23 — Engineer brief: run the repo format gate before pushing
- **Feedback:** two red CI builds on FON-1987 came from the same miss: an agent hand-off passed package lint/tests but skipped the repo's root format gate (oxfmt), which is the exact check CI runs.
- **Triage:** operational; will recur on any repo whose format gate differs from package-level lint.
- **Change:** added a "run the repository's formatter/format gate before every push or handoff" bullet to agents/engineer.md, How you work.
- **Approval:** additive — no approval needed.

## 2026-06-29 — Feedback loop: triage and respond to review feedback
- **Feedback:** after PRs open, most of a delivery's remaining work was fetching review comments (mainly from Greptile) and addressing them — that flow was missing from the skill. It should be **source-agnostic** (PR bot, human reviewer, or direct chat feedback all take the same flow), run **autonomously after the human's initial call** (flagging only escalations), and the ticket's done-state should be **merge, not PR-open**. (Reconstructed from the FON-1727 delivery thread.)
- **Triage:** operational — handling post-delivery review feedback was an unwritten part of the lifecycle.
- **Change:** added `references/feedback-loop.md` — a generic loop (collect → triage [Accept/Adapt/Decline/Escalate; ground-first; repo/user rules beat suggestions; severity = urgency not auto-action] → address → respond + resolve + verify; autonomous after the initial call). `SKILL.md`: added an "After delivery — Respond to review feedback" stage, shifted the ticket done-state from PR-open to **merged** (Gate 3 + Linear hygiene), added a feedback-rule-conflict escalation trigger to oversight, and linked the new reference. `agents/engineer.md`: noted the Engineer's address + close-out mechanics during the loop.
- **Approval:** approved by hegar (this session). Decisions settled with the human: comment-loop scope only; source-agnostic; autonomous-after-initial-call; done = merged.

## 2026-06-29 — Tightened the skill description
- **Feedback:** the `description` was too long and explained the skill's inner workings instead of just signaling when to trigger.
- **Triage:** operational — the description's only job is triggering; how-it-works detail belongs in the body.
- **Change:** `SKILL.md` frontmatter — cut the sub-agent roster and the process narration; kept the one-line what-it-does, the trigger cues/examples, and the fire-even-if-unnamed instruction. Triggering scope unchanged (same cues retained).
- **Approval:** approved by hegar (this session).

## 2026-06-29 — Dynamic build/verify loop; review covers the whole stack
- **Feedback:** the fixed Phase 0→8 numbering was too rigid — want the middle dynamic (one review pass if that's all that's needed, N back-and-forths if not). Also: internal review over the full working state already covers all changes end-to-end (it's the tip of the stack), so per-slice review is unnecessary.
- **Triage:** operational — the rigid numbered cycle is a structural property of how the skill was written.
- **Change:** `SKILL.md` — replaced the numbered Phase 0–8 cycle with **three fixed gates** (plan approved → product/human sign-off → package & open PRs) wrapping a **dynamic build/verify loop** (Implement / Functional QA / Code Review / Documentation, sequenced and repeated by Product's judgment, passes skippable with a stated reason). Made explicit that review runs over the full working state / stack tip, so there's no per-slice review. Renamed phase cross-references to gates in `references/pr-standards.md` and the prior changelog entry; relabeled the "Phase 0 gate" invariant in `references/self-improvement.md` to "plan-approval gate" (invariant substance unchanged — human still approves before any code).
- **Approval:** approved by hegar (this session). Gate invariants preserved; only the surrounding sequence became dynamic.

## 2026-06-29 — PR-stack delivery, impact-first descriptions, stronger code-review sweep
- **Feedback:** (1) project-wide PRs are hard for the team to review — need them split into small, reviewable units; (2) Code Review misses obvious issues an external bot catches (naming clarity, domain-term overloading); (3) PR descriptions should explain the problem/impact, not the code diff (model: kumospace/fonzi#4867).
- **Triage:** operational — all three are recurring failure modes baked into how the skill was written (no PR step existed at all; the review brief gave no systematic sweep; descriptions were unspecified).
- **Change:**
  - `SKILL.md` — the plan gate now requires a **PR breakdown** in the human-approved plan (ordered stack of small reviewable PRs on plain stacked branches, each with a one-line impact-focused description intent). Added a **Package & open PRs** delivery step (Engineer cuts the stack mechanically; Product owns descriptions). Updated the product-review hand-off, the team roster, Linear hygiene, and References to match.
  - `references/pr-standards.md` — new: slicing rules + coherence test, the impact-over-diff description template, and #4867 as the model.
  - `agents/engineer.md` — added the delivery-time packaging note; explicitly does *not* own descriptions.
  - `agents/code-review.md` — rewrote around a **systematic sweep** with an inline checklist grounded in real misses from a sample of 42 recent fonzi PRs (273 review comments), with worked examples per category.
- **Approval:** approved by hegar (this session). Additive parts (pr-standards, code-review checklist, engineer note) need no approval; the plan/review wording changes and new delivery step were approved in-session.

## 2026-06-23 — Renamed to `showrunner`
- **Feedback:** "Ticket Delivery" was too generic a name.
- **Triage:** authoring change (not feedback from a run).
- **Change:** Renamed the skill and directory from `ticket-delivery` to `showrunner`. No workflow behavior changed; the `description` (which controls triggering) is unchanged.
- **Approval:** approved by the human.

## 2026-06-23 — Initial skill
- **Feedback:** n/a — initial authoring.
- **Triage:** n/a.
- **Change:** Created the product-led ticket-delivery workflow (`SKILL.md`), the four role briefs under `agents/`, and the self-improvement loop (`references/self-improvement.md`).
- **Approval:** authored with the human.
