# Feedback loop: triage and respond to review feedback

How review feedback on the delivered work gets handled — **the same way regardless of source**: an automated PR reviewer (e.g. Greptile), a human reviewer, or direct feedback in chat. Used after delivery (Gate 3) and any time feedback arrives. Roles start cold, so this is self-contained.

## The loop
1. **Collect.** Gather the open feedback items with enough context to act on each: where it applies (file/line, or the area in question), its source, and its severity if the source gives one. Pull *unresolved* items only.
2. **Triage — ground first, then verdict.** Check each item against the actual code/state before judging it. Then assign one verdict:
   - **Accept** — valid; fix as suggested.
   - **Adapt** — the concern is real but the suggested fix isn't right for this codebase; fix it a better way and say why.
   - **Decline** — the premise is wrong, or it's out of scope for this ticket; don't change code, reply with the reason.
   - **Escalate** — it conflicts with a repo/user rule, would change product behavior or scope, or is a contested judgment call; flag it to the human, don't decide alone.

   Severity sets **urgency, not auto-action**: even a low-severity nit is grounded before acting, and a high-severity item is still verified, not blindly applied. **Repo and user rules beat any suggestion** — a reviewer (especially a bot) asking you to violate a standing convention is an Escalate, not an Accept.
3. **Address.** Fix the Accept/Adapt items (batched per PR or source is fine), then clear the **verification gate** (format → lint → typecheck → tests) before pushing — same bar as any other change.
4. **Respond and close out — always.** Every item gets a reply with its outcome (fixed / adapted-with-reason / declining-with-reason) and is marked resolved in its channel; then **verify it actually resolved** — re-check, don't assume. Closing out is a required step, not something a re-push does implicitly. Resolve items **one at a time and confirm each** — batch-resolving tends to silently miss some.

How you *collect* and *close out* depends on the source: a PR thread is replied to and resolved through the platform's API; direct chat feedback is closed out by saying what you did in the reply. The loop and the verdicts are identical either way.

## Autonomy
The human makes the **initial call** on the first round of triage. After that the loop **runs on its own** — collect, fix, respond, resolve, and repeat as new feedback arrives — pausing only to surface an **Escalate**. Keep going until the work is approved and (for PRs) merged.
