---
name: html-plan
description: Authors and maintains plans as single-file interactive HTML documents whose embedded state the human edits in the browser and exports back as a prompt. Use when starting multi-step work that needs a navigable plan artifact — "plan it", "make an html plan", "show me the plan", "break this down", "let's plan before building" — when resuming work whose plan exists under .cache/plans/<slug>/plan.html in the repo, when recording decisions or phase progress on an existing plan, or when another skill (e.g. showrunner) reaches its planning step. Skip for single-step tasks, quick answers, and plans that live in someone else's tracker.
---

# HTML plans

A plan is a control surface, not a transcript. One self-contained HTML file gives Hegar spatial layout, density, and interactivity that a markdown wall linearizes away — and gives the agent durable, structured state that survives context loss. The render is for the human; the embedded JSON is for you.

## Where plans live

`.cache/plans/<slug>/plan.html`, relative to the project root of the repo being worked on — `<slug>` is a short kebab-case name for the work (e.g. `.cache/plans/fon-2100-resume-upload/plan.html`). The path is repo-relative on purpose: remote harnesses can only write inside the project root, and `.cache` is already covered by standard Node gitignores, so plans stay out of commits with no setup. If the repo's `.gitignore` does not cover `.cache/`, add that line before writing the plan.

Plans are never committed, never appear in pull requests, and are never uploaded anywhere. One plan per piece of work; revise the file in place.

## Portability is a hard constraint

The skill runs identically from any harness (Claude Code, Codex, pi, or anything else that can write a file). Therefore:

- Pure file + browser. No hooks, no harness-specific tools, no helper scripts, no build step.
- Everything inline: `<style>`, `<script>`, inline SVG. No CDN, no web fonts, no `eval`.
- Dark and light via `prefers-color-scheme`. Target ≤ ~40KB total.

## The JSON is the source of truth

Every plan embeds `<script type="application/json" id="plan-data">` holding the canonical state:

```json
{
  "plan_title": "...", "goal": "...", "project": "...", "slug": "...",
  "created_at": "ISO 8601", "updated_at": "ISO 8601", "current_phase": 1,
  "phases": [{ "id": 1, "title": "...", "status": "pending|in_progress|complete|blocked",
               "blocked_by": [], "items": [{ "text": "...", "done": false }] }],
  "decisions": [{ "id": "D1", "question": "...", "options": { "a": "...", "b": "..." },
                  "recommended": "a", "selected": null, "note": "" }],
  "progress_log": [{ "ts": "ISO 8601", "phase": 1, "summary": "..." }],
  "errors": []
}
```

The rendered HTML is derived from it. When state changes, update the JSON **and** keep the visible markup consistent — never let them disagree. Extra fields are fine when the work needs them.

## Update discipline

- **Re-read the plan JSON at every phase boundary and after any context compaction.** The file is the durable memory; your context window is not.
- After completing a phase: set its `status` and bump `current_phase`, append a `progress_log` entry, and reflect it in the markup.
- Log failures in `errors` — knowledge that must survive a cleared session.
- The human edits state through the page (decision cards, Save). After Hegar says he used the page, re-read the file before acting.

## The export channel — required

An interactive artifact with no way back to the agent is a dead end. Every plan that carries decisions or checkable state ends with a sticky action bar:

- **Copy as prompt** — serializes the human's selections and notes into plain prompt text on the clipboard, ready to paste into any agent session.
- **Save** — writes current state back into the file's JSON block via the File System Access API, with a download fallback for non-Chromium browsers.

## Anatomy

Adapt `references/template.html` — its scaffolding (CSS variables, action bar, JSON block, decision/save/copy script) is reusable; the content sections are per-plan. Include only the sections the work needs:

1. **Header** — title, one-line goal, meta line (date, source, file path).
2. **Stat tiles** — only when a handful of numbers genuinely frame the problem.
3. **Dependency graph** — inline SVG of the phases/tasks and their edges, when the work has meaningful dependency structure. Mirror the harness task list when one exists.
4. **Phase cards** — status chip, items, what blocks what.
5. **Decision cards** — one card per open question: the why in one line, 2–4 options with a marked recommendation, a notes field. Radio + textarea, wired into the JSON.
6. **Action bar** — the export channel.

## Aesthetic

Editorial dashboard, not SaaS dashboard:

- One accent color; status colors only with a text label, never color alone. No gradients, no shadows.
- Sharp corners (≤ 4px), 1px borders, strong typographic hierarchy, information density over whitespace.
- System fonts only: `system-ui`, `ui-monospace` for data and paths. Tables before cards.
- WCAG AA contrast in both modes; semantic landmarks; the SVG graph carries an `aria-label`.

## Credits

Patterned after OthmanAdi/plan-it (MIT) — single-file plans with embedded JSON state — and Theo's HTML-over-markdown principle that every interactive artifact must end with an export channel back to the agent.
