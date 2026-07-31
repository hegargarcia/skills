# PR standards: slicing and descriptions

How a delivered ticket becomes reviewable PRs. Used at **Gate 1** (plan the stack) and **Gate 3** (open the PRs). Roles start cold, so this is self-contained.

## Slice into a reviewable stack

A ticket ships as an ordered stack of small, independently-reviewable PRs on **plain stacked branches** — not one project-wide PR the team has to swallow whole.

- Slice by **reviewable unit / concern**, in dependency order. Typical seams: db schema → models/types → service & business logic → API wiring → UI. Follow the team's branch-naming convention (e.g. `hjgr/fon-1727-db`).
- **Slice for review complexity, not deploy safety.** CD holds service deployment in a dependency graph, so merge order doesn't have to encode rollout order and no slice needs to be independently shippable. Cut wherever it makes a reviewer's job easiest. The seams above stay useful because they're natural units of review, not because they sequence a deploy.
- Each PR should stand on its own: a reviewer can understand and judge it without holding the whole ticket in their head.
- **Coherence test:** if you can't state a slice's impact in one plain sentence (its description intent), it isn't a coherent slice — re-cut it. Planning the per-slice description *is* how you validate the breakdown. This is why Product, who owns descriptions, also owns the slicing decision in the plan.
- **Build then slice.** The Engineer builds, tests, and iterates on the whole ticket as a single unit; the stack is cut only at delivery (Gate 3). The internal QA / review / docs loops run over the whole unit — equivalently, the tip of the stack — so they cover all the changes end-to-end, not per slice.

## How to cut the stack (Gate 3)

The Engineer builds the whole ticket first, then cuts it: the bottom slice off the trunk, every later slice off the branch below it, each PR based on the branch below so its diff shows only its own layer.

**Use the `gh-stack` skill for the mechanics** — it owns creating, pushing, submitting, and restacking stacked branches, including the rebase/sync churn that feedback-loop fixes cause on a live stack. Don't hand-roll the branch plumbing here. If the extension is missing, install it (`gh extension install github/gh-stack`).

Two things the tool won't decide for you:

- Every branch contains its ancestors, so per-PR CI stays green as long as the slices are cut in dependency order. If a slice needs something from a *higher* slice to pass, the seam is in the wrong place — move that dependency down or fold the two slices together.
- Clear the verification gate on each branch as you cut it, not just on the tip.

Nothing here is a product decision: the seams and the descriptions were settled at Gate 1.

## Write the description (Product owns this)

A description gives the reviewer **context**, not a code tour. Explain the **problem and how it's solved** — the impact to **ux / business / platform** — not the technical intricacies of the diff. Most PRs are about a real-world change; the rarer purely-technical PR can be more technical, but still leads with its purpose. Keep engineering input to the bare facts you need; the framing is Product's.

Structure (adapt as needed):

- **Summary** — the problem or purpose in plain language: what changes for users / the business / the platform, and why.
- **How it works** — what the change does *behaviorally*. Reader-facing bullets, not a file-by-file diff.
- **What it doesn't do / edge cases** — explicit non-goals and how the tricky cases are handled, so reviewers aren't left guessing.
- **Docs** — what product documentation changed, if any.
- `ref: <ticket-id>`.

In a stack, every PR gets its own description in this shape; together they tell the ticket's story in dependency order.

## Model description — kumospace/fonzi#4867

> **feat: sync Ashby schedule updates**
>
> Keeps Fonzi's internal pipeline view in sync with what is happening in a customer's own hiring system. For Ashby-connected customers, when an interview is scheduled, rescheduled, or cancelled in Ashby, the candidate's Interview Request card in Fonzi updates to match, so staff see the real scheduling state without anyone re-entering it by hand.
>
> **## How it works**
> - Ashby sends Fonzi a webhook whenever an interview schedule changes. Fonzi finds the matching Interview Request and, for accepted requests still interviewing, updates the card's scheduling status and time.
> - When a round is scheduled, the card moves to Scheduled, records the update source as ATS, and shows the earliest interview time for that round. If that time later changes, the card follows it.
> - When scheduling is cancelled, still needed, or waiting on the candidate, the card returns to Awaiting Scheduling and the scheduled time is cleared.
> - Existing notes and offer details on the card are preserved, and the team is notified only when the scheduling status or time actually changes, not on every webhook.
>
> **## How the edge cases are handled**
> ATS updates arrive in any order and can reference rounds the candidate has already left, so the sync is careful about which ones move the card:
> - **Only the candidate's current round counts.** An update tied to a round the candidate has already moved past does not drag the card backward. It is skipped, and the team is flagged about the mismatch to review.
> - **Stale, out-of-order updates never move the card back a round.** If a late event lands after the candidate has advanced, the card holds its place instead of regressing, and the discrepancy is flagged the same way.
> - **Only formal interview rounds are reflected.** Pre-interview steps such as a recruiter screen are ignored, since the pipeline tracks interview rounds.
>
> In short, the card always reflects the candidate's furthest-along scheduling state, and anything that does not line up surfaces to the team instead of quietly corrupting the card.
>
> **## Docs**
> Updates the Interview Requests feature doc with the customer-system schedule update behavior, including the rules above.
>
> ref: fon-1739

Note what it does **not** do: no mention of function names, file paths, or how the diff is structured. It explains the behavior and the judgment calls a reviewer needs to evaluate the change.
