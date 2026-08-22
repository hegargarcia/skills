# skills

My personal [Agent Skills](https://www.skills.sh/) — folders of instructions an AI agent (Claude
Code and others) can discover and use to work more reliably.

## Install

Install every skill in this repo:

```bash
npx skills add HegarGarcia/skills
```

To link this clone's instructions and skills into Claude Code, Codex, and other compatible agents:

```bash
./setup.sh
```

The script is safe to rerun and refuses to overwrite existing files or conflicting symlinks.

## Skills

| Skill                                      | What it does                                                                                                      |
| ------------------------------------------ | ----------------------------------------------------------------------------------------------------------------- |
| [`html-comms`](skills/html-comms/SKILL.md) | Self-contained HTML documents for plans, specs, reports, comparisons, and UI mocks — not product-shipping markup. |

## Layout

```
skills/
  <skill-name>/
    SKILL.md        # the skill; its frontmatter `description` controls when the agent triggers it
    ...             # optional references/, scripts/, assets/, and agents/ resources
```
