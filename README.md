# AI Workshop: Workflow Automation

Complete workshop package for a 4-hour hands-on session on process automation. Participants learn to identify, map, and automate business processes using Excalidraw, Make.com, and n8n.

**Client:** Faber Electronics, Heerenveen
**Date:** 5 maart 2026
**Participants:** 10 (mixed technical levels)
**Language:** Dutch

## Workshop Arc

> denken → tekenen → zien → bouwen → volgende stappen

| Tijd | Blok | Stijl |
|------|------|-------|
| 0:00 – 0:30 | 1. Wat zijn processen & wanneer automatiseren? | Discussie |
| 0:30 – 1:00 | 2. Proces uittekenen in Excalidraw | Hands-on |
| 1:00 – 1:15 | Pauze | |
| 1:15 – 1:45 | 3. Introductie Make.com | Demo |
| 1:45 – 2:45 | 4. Bouw de order intake automatisering | Hands-on |
| 2:45 – 3:00 | Pauze | |
| 3:00 – 3:20 | 5. Blik op n8n | Demo |
| 3:20 – 3:45 | 6. Eigen automatiseringskans identificeren | Oefening |
| 3:45 – 4:00 | 7. Afsluiting, bronnen & Q&A | Discussie |

## Repository Structure

```
├── index.html                          Landing page (central hub for participants)
├── slides.html                         Presentation slides (32 slides, press F to present)
├── slides.pdf                          PDF export of the slides
├── assets/
│   ├── header-banner.png               Landing page header banner
│   ├── social-card.png                 Open Graph social sharing image
│   ├── qr-landing-page.png             QR code to landing page (300 DPI)
│   └── qr-landing-page.pdf             QR code vector PDF for print
├── docs/
│   ├── 2026-03-05-ai-workshop-workflow-automation.md
│   │                                   Full workshop script & trainer notes
│   ├── make-scenario-blueprint.json    Make.com scenario export
│   ├── make-scenario-setup.md          Make.com step-by-step setup guide
│   ├── n8n-workflow.json               n8n workflow export
│   └── n8n-workflow-setup.md           n8n step-by-step setup guide
└── .chief/prds/main/
    ├── prd.json                        Product requirements (11 user stories)
    └── progress.md                     Implementation log
```

## Deliverables

### Landing Page (`index.html`)

Single-file HTML page — no build step, no dependencies. Serves as the central hub during the workshop.

- **Agenda** — Visual timeline with color-coded block types
- **Checklist** — Interactive 7-step build tracker with localStorage persistence
- **Tool Links** — Quick access cards to Make.com, Excalidraw, Google Forms, Google Sheets
- **Reference Material** — Automation checklist (4 criteria), Make.com vs n8n comparison, terminology table
- **Resources** — Post-workshop learning links and 2-week challenge

### Slides (`slides.html` / `slides.pdf`)

32-slide presentation covering all 7 blocks. The HTML version has a full presentation mode:

- **F** — Start presentation (fullscreen)
- **Arrow keys / Space** — Navigate slides
- **O** — Overview mode (thumbnail grid)
- **Esc** — Exit presentation
- Touch/swipe support for tablet presenting

The PDF export (`slides.pdf`) works as a standalone backup.

### Make.com Scenario (`docs/make-scenario-*`)

Order intake automation demo for Block 3:

```
Google Form → Google Sheet → Bevestigingsmail klant → Notificatie productie
```

Blueprint JSON + setup guide with all 6 form fields mapped (Bedrijfsnaam, Contactpersoon, Email, Product omschrijving, Aantal, Gewenste leverdatum).

### n8n Workflow (`docs/n8n-workflow-*`)

Same order intake flow in n8n for the side-by-side comparison in Block 5. JSON export + setup guide including credential configuration.

### QR Code (`assets/qr-landing-page.*`)

Points to the landing page URL. Available as PNG (900x900, 300 DPI) and vector PDF for print.

## Prerequisites for Participants

- Laptop with modern browser
- Google account (for Forms & Sheets)
- Free Make.com account (signup link on landing page)
