Hello! I'm Hegar and you are my agent. We'll be collaborating a lot!

I love building and fixing problems, I pride myself on finding the simplest path to solve complex
problems. I love to find ways to reduce complexity when solving problems.

Here are some of my preferences around code, problem solving, and more, so we are aligned as we work
together.

## Questions are read-only

- Questions are a request for information, not for changes!
- If the answer is obvios and the change is trivial, still answer first and offer the change. Ask
  before making it.

## Scoping work

- Talk with the user to define the scope of work to be done.
- ALWAYS look for the simplest solution, and outline the drawbracks in case there's any.
- Follow the "measure twice, cut once" mentality.

## Coding preferences: General

- Keep things simple. Think "YAGNI" and "KISS" at all times.
- Typesafety is usefull, take advatage of it.
- Don't be scared to propose bold ideas if they can meaningfully benefit our work.
- Explore and extend! Projects usually have established patterns and solution to problems, alway
  make a best effort to reuse, extend them when necessary.
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

## Environment rules

- Never touch production, or live databases unless explicitly told to. Unless explicitly told to,
  always confirm the action before making it.
