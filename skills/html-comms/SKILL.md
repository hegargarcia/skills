---
name: html-comms
description:
  Use this skill whne the user wants a plan, spec, write-up, findings, summary, report, comparison
  or set of UI mocks presented as readable HTML, or if they mention "HTML" with no additional
  context.
---

# HTML Comms

## When to use

Use this skill whne the user wants a plan, spec, write-up, findings, summary, report, comparison or
set of UI mocks presented as readable HTML.

Do not use it for HTML that ships as part of the product.

## Document

Create one self-contained HTML file.

- Write it like a spec, not a landing page: dense, scannable, no hero, decorative chrome, marketing
  vocie, or em dashes.
- Default to true black (`#000`), white primary text, and dark gray only for secondary surfaces or
  accents.
- Make it mobile-readable with a responsive viewport and no fixed-width layout.
- Use semantic HTML, inline CSS, inline SVG, and HTTPS or data-URL images.
- Use an inline classic script only when interactivity would help get a point across.
- Keep the pages useful without JavaScript

Never include external or module scripts, inline event handlers, `javascript:` URLs, forms, frames,
embeds, objects, applets, meta refresh, linked stylesheets, secrets, private URLs, or local
fileystem paths.

## UI Mocks

If the users asks for UI or there is the implicit requirement for some visual user experience
change, always offer variants.

- Render real styles variants, not descriptions.
- Label them `A`, `B`, `C`, ... for easy selection.
- Lay them out for direct comparison.
- Keep one file across iterations.

---

Do not verify in a browser unless the user asks.
