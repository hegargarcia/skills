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
| [`showrunner`](skills/showrunner/SKILL.md) | Product-led, multi-agent workflow that delivers a single Linear ticket end to end — plan with the human, then build, test, review, document, and open reviewable PRs. |

## Layout

```
skills/
  <skill-name>/
    SKILL.md        # the skill; its frontmatter `description` controls when the agent triggers it
    ...             # optional CHANGELOG.md, references/, agents/, etc.
```
