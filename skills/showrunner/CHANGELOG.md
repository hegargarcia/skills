# Changelog

Newest first. See `references/self-improvement.md` for when and how to add entries.

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
