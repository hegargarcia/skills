---
name: make-pr
description: Use when the user asks to file, create, open or make a pull request (pr).
---

# Make PR

- Make sure titles follow conventions from the repo. They should be simple and easy to understand.
  Convential commit styles in projects that use them, i.e. "feat(graphql): expose crm campaign
  entities".
- PR descriptions should aim for simplicity. Open with a minimal and clear description of the
  problem. Follo wup with how you solved it.
- Open a real PR, not a draft. Drafts do not get review-bot coverage.
- Rebase onto latest `main` before opening. Stale branches conflict and waste a review round.
- Merge only per the disposition given in the requests, e.g. "merge when green", "stop and report".
  If none was given, report and ask.
