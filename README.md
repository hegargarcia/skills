# skills

My personal [Agent Skills](https://www.skills.sh/) — folders of instructions an AI agent (Claude Code and others) can discover and use to work more reliably.

## Install

Install every skill in this repo:

```bash
npx skills add HegarGarcia/skills
```

## Skills

| Skill | What it does |
| --- | --- |
| [`showrunner`](skills/showrunner/SKILL.md) | End-to-end feature workflow — plan as a task graph, build, open draft PRs per slice, and work review feedback until merge. |
| [`html-plan`](skills/html-plan/SKILL.md) | Interactive HTML plans under `~/.plans` — human edits in the browser, agent reads embedded JSON as durable state. |
| [`personal-preferences`](skills/personal-preferences/SKILL.md) | Hegar's durable, cross-project preferences for how agents shape code, tests, docs, tooling changes, reviews, and handoffs. |

## Layout

```
skills/
  <skill-name>/
    SKILL.md        # the skill; its frontmatter `description` controls when the agent triggers it
    ...             # optional references/, scripts/, assets/, and agents/ resources
```
