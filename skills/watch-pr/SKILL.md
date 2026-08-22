---
name: watch-pr
description: Use when the user asks to babysit, monitor, or watch a PR.
---

# Watch PR

- When asked to monitor or babysit a PR: poll checks and comments newer than the last push; verity
  each finding against the source before acting on it; fix real ones and dismiss false positive with
  a written reason;
- Fix CI failures, distinguishing real breaks from known infra flakes.
- If nothing is new stay quite, don't post filler comments.
- Stop when the repo's review bots are green on the latest commit.
