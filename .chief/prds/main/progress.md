## Codebase Patterns
- Landing page is a single `index.html` file at project root with inline CSS and JS (no build step)
- Use safe DOM methods (createElement, textContent, appendChild) instead of innerHTML to pass security hooks
- Dutch is primary language; section headings include English subtitle
- Checklist state persists via localStorage with key `workshop-checklist`

---

## 2026-03-05 - US-001
- Implemented full landing page with all 7 sections: Header, Agenda (visual timeline), Checklist (interactive with localStorage), Tool Links (card grid), Reference Material (checklist framework + comparison tables + terminology), Resources (links + 2-week challenge), Contact (RocketFlow)
- Files changed: `index.html` (new, ~25KB)
- **Learnings for future iterations:**
  - Security hook blocks `innerHTML` usage even with hardcoded content - use DOM methods instead
  - Playwright MCP cannot open `file://` URLs - need a local HTTP server for testing
  - The workshop doc at `docs/2026-03-05-ai-workshop-workflow-automation.md` contains all content details (agenda, steps, terminology tables)
  - US-002 through US-006 content is already partially implemented in US-001 (agenda timeline, checklist, tool links, reference material, resources/contact) - those stories may just need refinements
---

## 2026-03-05 - US-002
- Added visual timeline enhancements: type legend (Discussie, Hands-on, Demo, Pauze), click-to-toggle active block highlighting with type-specific colors, hint text
- Files changed: `index.html` (CSS: active states, legend styles; HTML: legend + hint; JS: click handler for timeline items)
- **Learnings for future iterations:**
  - Timeline items already had data-type attributes and color coding from US-001 — just needed active state CSS and click handler
  - Active highlighting uses scale(1.02) + box-shadow ring + type-colored background for clear visual distinction
  - Each subsequent US (003-006) likely just needs incremental refinements to existing sections
---

## 2026-03-05 - US-003
- All acceptance criteria already met by US-001 implementation: 7 checkable steps with titles/descriptions, localStorage persistence, progress bar with "X/7 stappen voltooid", confetti celebration, reset button
- Files changed: `.chief/prds/main/prd.json` (marked passes: true)
- **Learnings for future iterations:**
  - US-001 implemented comprehensive checklist covering all US-003 requirements — no code changes needed
  - When prior stories implement future story features, just verify and mark as passing
---

## 2026-03-05 - US-004
- All acceptance criteria already met by US-001 implementation: 4 tool cards (Make.com, Excalidraw, Google Forms, Google Sheets) with target="_blank", Dutch descriptions, card-style layout with hover effects
- Files changed: `.chief/prds/main/prd.json` (marked passes: true)
- **Learnings for future iterations:**
  - US-001 implemented tool links as clickable cards covering all US-004 requirements — no code changes needed
---
