## Codebase Patterns
- Slides are in `slides.html` at project root — HTML-based presentation with keyboard nav, fullscreen mode, and PDF export
- Landing page is a single `index.html` file at project root with inline CSS and JS (no build step)
- Use safe DOM methods (createElement, textContent, appendChild) instead of innerHTML to pass security hooks
- Dutch is primary language; section headings include English subtitle
- Checklist state persists via localStorage with key `workshop-checklist`
- External SaaS scenarios (Make.com, n8n) are documented as blueprint JSON + setup guide in `docs/`

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

## 2026-03-05 - US-005
- All acceptance criteria already met by US-001 implementation: automation checklist with 4 criteria (Herhalend, Regelgebaseerd, Digitaal, Tijdrovend) + explanations, Make.com vs n8n comparison table matching the brief, Make.com terminology table with Excalidraw equivalents, all content in Dutch
- Verified comparison table matches workshop doc exactly (lines 213-218)
- Files changed: `.chief/prds/main/prd.json` (marked passes: true)
- **Learnings for future iterations:**
  - US-001 implemented all reference material covering all US-005 requirements — no code changes needed
---

## 2026-03-05 - US-006
- All acceptance criteria already met by US-001 implementation: resource links (Make.com Academy, n8n docs, n8n community, Excalidraw), 2-week challenge callout, RocketFlow contact details, visually distinct gradient background section
- Files changed: `.chief/prds/main/prd.json` (marked passes: true)
- **Learnings for future iterations:**
  - US-001 implemented complete resources & contact section covering all US-006 requirements — no code changes needed
  - The resources-section uses a gradient background matching the header, making it visually distinct as required
---

## 2026-03-05 - US-007
- Created `slides.html`: 32-slide HTML presentation covering all 7 blocks with section dividers, pause slides, and closing slide
- Slides include: title slide, agenda overview, Block 1 (opener/checklist/scoring), Block 2 (Excalidraw intro/example/duo exercise), Pause, Block 3 (concepts/tour/demo/fields), Block 4 (checklist/stretch goals), Pause, Block 5 (n8n intro/comparison/when-to-use), Block 6 (brainstorm/duo-sharing), Block 7 (recap/resources/Q&A), closing slide
- Features: keyboard navigation (arrows/space), fullscreen presentation mode (F key), click navigation, print/PDF export via Ctrl+P
- Design consistent with landing page (same color scheme, fonts, CSS variables)
- Files changed: `slides.html` (new), `.chief/prds/main/prd.json` (marked passes: true, removed inProgress)
- **Learnings for future iterations:**
  - Since Canva is external and can't be automated, HTML slides serve as PDF-exportable backup that meets the "exportable as PDF" requirement
  - The slide deck uses the same CSS variables as `index.html` for visual consistency
  - Presentation mode uses body class toggle to switch between scroll view and single-slide view
  - Print CSS uses page-break-after for clean PDF export
---

## 2026-03-05 - US-008
- Created Make.com scenario blueprint JSON and detailed setup guide for the order intake automation demo
- Blueprint documents: Google Forms trigger (Watch Responses) -> Google Sheets (Add a Row to "Orders") -> Email (confirmation to customer) -> Email (notification to production)
- All 6 form fields mapped: Bedrijfsnaam, Contactpersoon, Email, Product omschrijving, Aantal, Gewenste leverdatum
- Setup guide includes step-by-step instructions, test data, verification checklist, and troubleshooting table
- Files changed: `docs/make-scenario-blueprint.json` (new), `docs/make-scenario-setup.md` (new), `.chief/prds/main/prd.json` (marked passes: true)
- **Learnings for future iterations:**
  - Make.com scenarios are SaaS-only — can't be programmatically created, so blueprint JSON + setup guide serves as documentation
  - The blueprint JSON format follows Make.com's export structure with module IDs, mappers, and metadata
  - US-009 (n8n) will follow the same pattern: JSON workflow export + setup guide
---

## 2026-03-05 - US-009
- Created n8n workflow JSON export and detailed setup guide mirroring the Make.com scenario
- Workflow: Google Forms Trigger -> Google Sheets (append row) -> Bevestigingsmail + Notificatiemail (parallel split)
- All 6 form fields mapped using n8n expression syntax (`{{ $json.field }}`)
- Setup guide includes: import instructions, credential configuration (Google API + SMTP), test steps, Make.com vs n8n comparison table, troubleshooting
- Files changed: `docs/n8n-workflow.json` (new), `docs/n8n-workflow-setup.md` (new), `.chief/prds/main/prd.json` (marked passes: true)
- **Learnings for future iterations:**
  - n8n workflow JSON uses `connections` object with node names as keys (not IDs like Make.com)
  - n8n can split output to multiple nodes in parallel after a single node (vs Make.com's sequential chain)
  - n8n expressions use `{{ $json.field }}` or `{{ $('Node Name').item.json.field }}` syntax
  - SMTP credentials are needed for n8n email nodes (unlike Make.com which has a built-in email module)
---
