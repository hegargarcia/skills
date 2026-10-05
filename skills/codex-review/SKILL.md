---
name: codex-review
description:
  Use when asking Codex for an independent review of changes, a branch, a commit, or a PR.
---

# Codex Review

Use in Claude Code and Codex. Get a separate review with `gpt-6-astra`, unless the user selects
another model. Keep small checks local; you still own the review.

## Run

- Establish the repository and exact target. For a PR, inspect its base and head; use a separate
  checkout if needed so the user's working tree is preserved.
- Check `codex exec review --help`. Create a unique temporary directory for the report and logs.
- Use the command below, replacing `--uncommitted` with one of the other targets as needed. If the
  user selects another model, change both `-m` and `review_model` to that selector:

```bash
codex exec -C "$repo" -m gpt-6-astra -s read-only \
  -c 'review_model="gpt-6-astra"' -c 'service_tier="fast"' \
  -c 'approval_policy="never"' --json -o "$task_dir/report.md" \
  review --uncommitted > "$task_dir/events.jsonl" 2> "$task_dir/stderr.log"
```

| Target                                  | Review argument     |
| --------------------------------------- | ------------------- |
| Staged, unstaged, and untracked changes | `--uncommitted`     |
| Branch changes relative to a base       | `--base <base-ref>` |
| One commit                              | `--commit <sha>`    |

- Target flags cannot be combined with a custom review prompt. For specific files, requirements,
  commit ranges, or a PR requiring extra context, use `codex exec review -` with the same model,
  configuration, sandbox, and output options before `review`. Omit target flags and send a
  self-contained assignment on stdin; name the review target in the assignment.
- Name the target and requirements in that assignment. Request actionable defects, regressions,
  security problems, and missing regression protection for concrete failures. Each finding must
  identify severity, file and line, the triggering condition, and the impact. Skip cosmetic
  feedback.
- Use the shell tool's background handle for long runs. Wait for completion and check the exit
  status before reading the report. A partial report from a failed run is not a completed review.

## Report

- Validate each finding against the code and requirements. Report confirmed problems first; label
  anything still uncertain. Do not automatically apply suggested changes.
- A successful review with no findings is a valid result. State what was reviewed and relevant
  limits; do not rerun just because the report is clean.
- If the worker fails, report the specific failure. Continue the review yourself when possible.
