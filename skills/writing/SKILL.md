---
name: writing
description:
  Use whenever the user asks to write, draft, rewrite, edit, or improve copy, messages, emails,
  posts, documentation, or other prose, including quick edits.
---

# Writing

Use for every writing request in Claude Code and Codex, including quick edits. Delegate writing to
`gpt-6.1-sol` with high reasoning on the fast tier, unless the user selects another model. You own
the final wording.

## Voice and tone

Keep a consistent voice: plain, conversational, specific, and willing to take a position. Adjust the
tone to the audience and situation. Preserve the actual claim, criticism, enthusiasm, and
uncertainty rather than replacing them with a clever line or softening them automatically.

Tweet guidance comes from Forge's `write-tweets` skill and its approved examples. The other cases
are starting defaults. Current instructions, the supplied draft, and approved writing take
precedence; an assistant suggestion alone is not evidence of the user's voice.

| Case                            | Voice and tone                                                         | Apply it this way                                                                                                                                                                                                                                                                                      |
| ------------------------------- | ---------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| Tweets and replies              | Conversational builder sharing an observation, frustration, or opinion | Use contractions and the draft's vocabulary and casing. Ground the point in real details. Let humor come from self-awareness or a recognizable annoyance. Keep profanity, emojis, and enthusiasm when supported; don't add them as a costume. Avoid engagement bait, slogans, and manufactured wisdom. |
| Personal messages               | Warm, informal, candid                                                 | Match the relationship and the user's usual phrasing. Say the actual feeling or request without forced slang or a polished speech.                                                                                                                                                                     |
| Work messages                   | Direct, collegial, practical                                           | Give the context, point, and next step. Keep disagreements clear and respectful; avoid corporate padding.                                                                                                                                                                                              |
| Emails                          | Clear, personable, respectful                                          | Match the recipient's formality. Put the reason for writing and the ask early. Use a greeting and sign-off that fit the relationship.                                                                                                                                                                  |
| Sensitive feedback or apologies | Calm, considerate, accountable                                         | Name the issue and its impact plainly. Own what is appropriate and state a concrete next step. Avoid jokes, forced positivity, or minimizing the concern.                                                                                                                                              |
| Product and marketing copy      | Confident, concrete, useful                                            | Explain what the reader can do and why it helps. Use supported benefits and claims; avoid hype and launch-copy polish.                                                                                                                                                                                 |
| Documentation and explainers    | Plain, precise, practical                                              | Explain the problem and the useful details in a logical order. Use examples when they clarify; avoid jargon that adds no precision.                                                                                                                                                                    |

- Add or update cases here as the user gives preferences or approved examples. Keep feedback
  specific to its case unless the user makes it a general rule.
- For revisions, preserve what the user likes, change what they identify, and drop requirements they
  retract. If a draft doesn't sound like them, check their examples rather than adding slang.

## Brief

- Establish the audience, purpose, channel, language, tone, and length. Use context already given;
  ask only when a missing detail would materially change the draft.
- Select the relevant voice and tone case above and include its guidance and any user overrides in
  the worker's brief. For mixed cases, use the audience and purpose to choose the tone.
- Include the relevant facts, existing draft or conversation, desired response or call to action,
  constraints, and any examples of the user's voice. Pass relevant parent-harness instructions.
- Preserve the user's meaning and voice when editing. Use plain language and concrete wording; avoid
  padding, sales clichés, inflated claims, and generic AI phrasing.
- Tell the worker to use supplied facts and flag necessary gaps rather than invent names, quotes,
  numbers, results, deadlines, or commitments. Request one strong draft unless variants are useful
  or requested. Tell it to draft only: no file edits, sending, publishing, or delegating.

## Run

In T3, call `orchestrator_capabilities` once per thread. Use the Codex provider's `gpt-6.1-sol` with
options `{ reasoningEffort: "high", serviceTier: "priority" }`. Priority is the fast tier. Start one
worker with `delegate_task` (`role: "general"`, `mode: "wait"`, a short `title`, the brief as
`task`). Save `taskId`. The child gets no history, so the brief must stand alone. Do not use
`t3_thread_send`, `create_threads`, or `t3_thread_launch` for writing.

If T3 tools are not listed, try one direct capability call. Outside T3, use a native Sol subagent
and keep its ID. In Claude Code, use a custom subagent only if it is set up to run Sol. If no route
runs Sol, report the blocker. Do not substitute a model.

A wait timeout does not cancel the child: follow its `next`. Do not poll or start a second worker.
Timeout, error, or empty reply is not a draft. On failure, cancel, verify stop, report it, and
finish the draft locally.

For revisions, use a fresh `delegate_task` in T3, or follow up the saved native ID. Send the brief,
the last draft, and the user's feedback.

## Deliver

- Check the draft against the facts, audience, voice, and requested length. Resolve unsupported
  claims and awkward wording before presenting it.
- Match the channel: subject and body for a new email, a ready-to-paste message for chat, or the
  requested structure for product copy and posts. Preserve formatting that matters to the reader.
- Lead with the finished text. Keep any necessary assumptions or missing facts separate from the
  draft. Avoid commentary about the writing process unless requested.
