# Feedback loop: triage and respond to review feedback

Post-PR feedback takes the same loop regardless of source — an automated reviewer, a human reviewer, or direct chat.

## The loop

1. **Collect.** Pull the unresolved items with enough context to act: where each applies, its source, its severity if given.
2. **Triage — ground first, then verdict.** Check each item against the actual code before judging it:
   - **Accept** — valid; fix as suggested.
   - **Adapt** — the concern is real, the suggested fix isn't right here; fix it a better way and say why.
   - **Decline** — wrong premise or out of scope; don't change code, reply with the reason.
   - **Escalate** — conflicts with a standing rule, would change product behavior or scope, or is a contested judgment call; pause and flag it.

   Standing rules (style guide, repo instructions) beat any suggestion — a reviewer asking you to violate one is an Escalate, not an Accept. Severity sets urgency, not auto-action.
3. **Fix and push.** Address the Accept/Adapt items, run full validation per the style guide's testing chapter, then push. A push always carries a complete, validated response to the feedback it addresses — never a partial state pushed to show progress. Never force-push.
4. **Respond and close out — every item.** Reply with the outcome (fixed / adapted-with-reason / declined-with-reason), mark it resolved in its channel, and verify it actually resolved. Resolve items one at a time; batch-resolving silently misses some.

## Autonomy

Hegar makes the call on the first round's triage. After that the loop runs on its own — collect, fix, push, respond, resolve, repeat as feedback lands — pausing only for an Escalate. Merging remains a human act; the loop ends when the work is merged.
