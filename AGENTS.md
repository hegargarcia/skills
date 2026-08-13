Hello! I'm Hegar and you are my agent. We'll be collaborating a lot!

I love building and fixing problems, I pride myself on finding the simplest path to solve complex
problems. I love to find ways to reduce complexity when solving problems.

Here are some of my preferences around code, problem solving, and more, so we are aligned as we work
together.

## Coding preferences: General

- Keep things simple. Channel "YAGNI" and "KISS" energy unless told otherwise.
- Typesafety is usefull, take advatage of it.
- Don't be scared to propose bold ideas if they can meaningfully benefit our work.
- Be careful with destructive actions that are not explicitly requested by the user! Even more when
  related to a production environment
- Test are good and useful! Endless smoke and functional tests; "regression tests" for feature
  deletion, tests for third party libraries, etc, much less good. Tests must be focused, not slop.
- Comments are great to clarify functionality, how code is used, and when to use it. Don't comment
  every line, but use them to describe (concisely) how elements should be used.
- Keep comments up to date! It's important to keep things in sync.

## Coding preferences: Typescript

- `any` is enemy #1. Inferred types are our friends. Our systems should adapts and react to changes,
  instead of needing changes everywhere.
- If your TS code looks like Python dev wrote it, it is bad TS code.
- Avoid one-line functions that are just casting wrappers.

## Questions are read-only

- Questions are a request for information, not for changes!
- If the answer is obvios and the change is trivial, still answer first and offer the change. Ask
  before making it.

## Size the task

- Do not spawn subagents or a multi-agent sysstem for work that a single agent can do in one pass.
  Delegation is for breadth or adversarial review, not for ordinary or simple tasks.

## Environment rules

- Never touch production, or live databases unless explicitly told to. Unless explicitly told to,
  always confirm the action before making it.

## Pull Requests

- Make sure titles follow conventions from the repo. They should be simple and easy to understand.
  Convential commit styles in projects that use them, i.e. "feat(graphql): expose crm campaign
  entities".
- PR descriptions should aim for simplicity. Open with a minimal and clear description of the
  problem. Follo wup with how you solved it.
- Open a real PR, not a draft. Drafts do not get review-bot coverage.
- Rebase onto latest `main` before opening. Stale branches conflict and waste a review round.
- Merge only per the disposition given in the requests, e.g. "merge when green", "stop and report".
  If none was given, report and ask.

## Babysit PRs

- When asked to monitor or babysit a PR: poll checks and comments newer than the last push; verity
  each finding against the source before acting on it; fix real ones and dismiss false positive with
  a written reason;
- Fix CI failures, distinguishing real breaks from known infra flakes.
- If nothing is new stay quite, don't post filler comments.
- Stop when the repo's review bots are green on the latest commit.
