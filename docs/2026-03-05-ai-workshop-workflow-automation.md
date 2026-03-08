# AI Workshop Advanced: Workflow Automation

**Duur:** 4 uur (halve dag, incl. pauzes)
**Groep:** 10 personen, gemengd technisch niveau (Faber Electronics)
**Locatie:** Faber Electronics, Velp
**Benodigdheden deelnemers:** Laptop, Make.com account (gratis)

## Doel

Deelnemers leren processen herkennen, tekenen en automatiseren. Ze vertrekken met een werkende automatisering die ze zelf hebben gebouwd, en een concreet idee voor hun eigen werk.

## Tools

| Tool | Doel |
|------|------|
| Excalidraw | Processen visueel uittekenen |
| Make.com | Hands-on automatisering bouwen (gratis account) |
| Order test formulier | Testbestellingen versturen naar webhook |
| OpenAI API | AI-module voor slimme orderverwerking (API key van trainer) |
| n8n | Demo — krachtigere alternative |
| Landing page | Centrale plek met agenda, checklist, links (QR code) |

## Tijdschema

| Tijd | Blok | Stijl |
|------|------|-------|
| 0:00 - 0:30 | 1. Wat zijn processen & wanneer automatiseren? | Interactieve discussie |
| 0:30 - 1:00 | 2. Proces uittekenen in Excalidraw | Hands-on oefening |
| 1:00 - 1:15 | Pauze | |
| 1:15 - 1:45 | 3. Introductie Make.com | Live demo |
| 1:45 - 2:45 | 4. Bouw de order intake automatisering | Begeleide hands-on |
| 2:45 - 3:00 | Pauze | |
| 3:00 - 3:20 | 5. Blik op n8n | Demo |
| 3:20 - 3:45 | 6. Eigen automatiseringskans identificeren | Groepsoefening |
| 3:45 - 4:00 | 7. Afsluiting, bronnen & Q&A | Discussie |

**Rode draad:** denken -> tekenen -> zien -> bouwen -> volgende stappen

---

## Blok 1: Wat Zijn Processen & Wanneer Automatiseren? (30 min)

### Interactieve opener (10 min)

Vraag aan de groep: *"Noem iets wat je vandaag al hebt gedaan dat elke dag hetzelfde gaat."*

Schrijf de antwoorden op een whiteboard of scherm. Typische antwoorden: "email checken", "orders invoeren", "leverancier bellen", "pakbon controleren". Dit is het ruwe materiaal voor de rest van het blok.

### Mini-framework: de automatiserings-checklist (10 min)

Introduceer vier criteria om te bepalen of iets automatiseerbaar is:

1. **Herhalend** — Gebeurt het regelmatig?
2. **Regelgebaseerd** — Kun je de stappen beschrijven als regels/beslissingen?
3. **Digitaal** — Gaat het om digitale tools of data?
4. **Tijdrovend** — Kost het merkbare tijd?

Score 3 of 4 = sterke automatiseringskandidaat.

### Groeps-scoring (10 min)

Neem 3-4 voorbeelden uit de opener en scoor ze samen met de checklist. Laat discussie ontstaan — sommigen zullen het oneens zijn, en dat is goed. Het doel is dat ze leren denken in "is dit automatiseerbaar?"

---

## Blok 2: Proces Uittekenen in Excalidraw (30 min)

### Snelle Excalidraw intro (5 min)

- Iedereen opent Excalidraw via de link op de landingspagina
- Laat alleen zien wat ze nodig hebben: rechthoeken, pijlen, tekst
- Benadruk: het is een denktool, geen design tool — lelijk mag

### Begeleid voorbeeld (10 min)

Teken het order intake proces samen op scherm:

```
Klant stuurt aanvraag
    |
Ontvangst check
    |
Alle specs compleet? --nee--> Terugvragen bij klant
    |ja
Invoer in systeem
    |
Bevestiging naar klant
    |
Planning notificatie
```

- Laat decision diamonds zien (ja/nee splits)
- Houd het op 5-7 stappen max

### Duo-oefening (15 min)

- Paren van 2 kiezen een proces uit de eerdere brainstorm
- Teken het in Excalidraw — maximaal 8 stappen
- Kleurcodering: oranje = handmatig, groen = kan geautomatiseerd worden
- Laatste 3 minuten: 2-3 duo's delen kort hun scherm

**Kernboodschap:** *"Als je het kunt tekenen, kun je het automatiseren."* Deze manier van denken in blokken en pijlen is precies hoe Make.com werkt.

---

## Blok 3: Introductie Make.com (30 min)

### Kernconcepten (10 min)

Leg de basisconcepten uit en koppel ze aan wat ze net hebben getekend:

| Make.com term | Wat het is | Excalidraw equivalent |
|---------------|-----------|----------------------|
| **Scenario** | Je automatisering | Het hele plaatje |
| **Module** | Een stap | Een rechthoek |
| **Connection** | Link naar een tool | De pijl naar buiten |
| **Trigger** | Wat het aftrapt | Het eerste blok |

Toon hun Excalidraw-tekening naast een leeg Make.com scenario: *"Zie je? Hetzelfde."*

### Live interface tour (10 min)

- Iedereen maakt een Make.com gratis account aan (link op landingspagina)
- Loop samen door: scenario aanmaken, modules zoeken, verbinden
- Laat de "Run once" knop zien — directe feedback, geen deploy nodig

### Pre-built demo (10 min)

Laat de afgebouwde order intake automatisering live draaien:

1. Order formulier wordt ingevuld
2. AI analyseert de bestelling en genereert respons
3. Bevestigingsmail wordt verstuurd (AI-geschreven)
4. Notificatie-email gaat naar "productie" (met AI-analyse)

Run het live zodat ze data door de modules zien stromen. Sluit af met: *"Dit gaan jullie nu zelf bouwen."*

---

## Blok 4: Bouw de Order Intake Automatisering (60 min)

### Setup (5 min)

- Open de landingspagina checklist — elke stap die ze afronden, vinken ze af
- Controleer dat iedereen Make.com open heeft en is ingelogd

### Stap-voor-stap begeleide bouw (45 min)

De checklist op de landingspagina loopt hen door elke stap:

**Stap 1: Make.com account aanmaken (5 min)**
- Registreren op Make.com via de link op de landingspagina
- Inloggen en het dashboard verkennen

**Stap 2: Webhook trigger instellen (5 min)**
- Nieuw scenario aanmaken
- Module: Custom Webhook
- Webhook URL kopiëren

**Stap 3: AI module toevoegen (5 min)**
- Module: OpenAI -> Create a Completion
- API key invoeren (van trainer)
- Prompt instellen: analyseer de bestelling en genereer een bevestigingstekst

**Stap 4: Bevestigingsmail module (10 min)**
- Module: Email -> Send an Email
- Aan: het email-veld uit de webhook data
- Onderwerp: "Bevestiging ontvangst aanvraag"
- Body: AI-gegenereerde bevestigingstekst met bestelling details

**Stap 5: Productie notificatie (5 min)**
- Module: Email -> Send an Email
- Aan: eigen e-mailadres (simuleert "productie team")
- Samenvatting met bestelling details en AI-analyse

**Stap 6: Testen (10 min)**
- Open het testformulier (assets/order-form.html)
- Plak de webhook URL in het formulier
- Verstuur een testbestelling
- Controleer: bevestigingsmail ontvangen met AI-gegenereerde tekst? Notificatie ontvangen met AI-analyse?

### Troubleshooting buffer (10 min)

- Loop rond, help mensen die vastlopen
- Koppel snelle afmakers aan langzamere deelnemers — peer help werkt goed in groepen van 10
- **Stretch goal voor snelle afmakers:** voeg een filter toe (bijv. alleen notificatie als Aantal > 100)

---

## Blok 5: Blik op n8n (20 min)

### Wat is n8n (5 min)

- Open source en self-hostable — je data blijft bij jou
- Gratis op eigen server, of gehost via n8n.cloud
- Zelfde concept als Make.com: visuele flows met modules en verbindingen

### Vergelijking naast elkaar (10 min)

Laat hetzelfde order intake scenario zien, opgebouwd in n8n met een Form Trigger. Benoem de verschillen:

- Meer technische interface, maar meer flexibiliteit
- Code nodes — je kunt JavaScript/Python schrijven als dat nodig is
- Self-hosted = geen data verlaat je gebouw (relevant voor elektronica/IP)
- Community nodes voor niche-integraties
- n8n heeft ook een OpenAI node — dezelfde AI-functionaliteit is beschikbaar

### Wanneer wat gebruiken (5 min)

| | Make.com | n8n |
|---|---------|-----|
| **Ideaal voor** | Quick wins, eenvoudige flows | Complexe logica, privacy-eisen |
| **Trigger** | Webhook / app-integraties | Form Trigger / Webhook / app-integraties |
| **Gebruiker** | Niet-technisch | Technisch team beschikbaar |
| **Data** | SaaS (cloud) | Self-hosted optie |
| **AI** | OpenAI module | OpenAI node |
| **Kosten** | Abonnement per operatie | Gratis (self-hosted) of betaald cloud |

Geen hands-on — alleen bewustwording. *"Als je straks meer wilt, is dit de volgende stap."*

---

## Blok 6: Eigen Automatiseringskans Identificeren (25 min)

### Individuele brainstorm (5 min)

- Ga terug naar de processen uit Blok 1
- Kies er een die hoog scoorde op de automatiserings-checklist
- Schrijf op: Wat triggert het? Wat zijn de stappen? Welke tools zijn betrokken?

### Teken het in Excalidraw (10 min)

- Map het gekozen proces zoals in Blok 2
- Kleurcodering: oranje = nu handmatig, groen = kan geautomatiseerd worden
- Maximaal 8 stappen

### Duo-sharing & feedback (10 min)

Deel met een partner. De partner stelt twee vragen:
1. *"Is er een stap die je kunt weglaten?"* (vereenvoudigen)
2. *"Welke module in Make.com zou je hier gebruiken?"* (koppelen aan tooling)

2-3 vrijwilligers delen hun idee met de hele groep.

---

## Blok 7: Afsluiting, Bronnen & Q&A (15 min)

### Recap (5 min)

Loop terug door de boog: **denken -> tekenen -> zien -> bouwen -> eigen idee**

Benoem wat ze bereikt hebben: iedereen heeft vandaag een werkende automatisering gebouwd.

Kernboodschap: *"Automatisering is geen IT-project. Het begint met een proces en een tekening."*

### Bronnen op de landingspagina (5 min)

- Make.com Academy (gratis cursussen)
- n8n documentatie & community
- Excalidraw (bookmark)
- Contactgegevens voor follow-up vragen
- Challenge: automatiseer binnen 2 weken iets op je werk, deel het resultaat

### Q&A (5 min)

- Open vragen
- Verzamel processen die ze hebben geidentificeerd en waar ze hulp bij willen — potentiele follow-up voor RocketFlow

---

## Landing Page

Eenpagina HTML site, toegankelijk via QR code die op tafel/slides staat.

### Structuur

1. **Header** — Workshop titel, datum, logo's Faber Electronics + RocketFlow
2. **Agenda** — Visuele tijdlijn van de dag
3. **Checklist** — Interactieve checkboxen voor de hands-on bouw (7 stappen uit Blok 4)
4. **Tool links** — Make.com signup, Excalidraw, Order test formulier
5. **Referentiemateriaal** — Automatiserings-checklist framework, Make.com vs n8n vergelijking
6. **Bronnen** — Post-workshop leermateriaal en tutorials
7. **Contact** — RocketFlow contactgegevens voor follow-up

### Technisch

- Enkele HTML pagina, responsive (werkt op laptop en telefoon)
- Gehost op een publieke URL
- QR code geprint op tafelkaarten of eerste slide
- Checkboxen werken client-side (localStorage), geen backend nodig

---

## Voorbereiding (voor de trainer)

### Vooraf regelen

- [ ] Make.com scenario pre-builden voor de demo in Blok 3
- [ ] n8n scenario pre-builden voor de demo in Blok 5
- [ ] Order test formulier testen met webhook URL
- [ ] Landing page bouwen en hosten
- [ ] QR code genereren en printen (tafelkaarten of eerste slide)
- [ ] Excalidraw testen op het netwerk van Faber
- [ ] OpenAI API key klaarzetten en testen
- [ ] Controleren dat Make.com signup niet geblokkeerd is op hun netwerk

### Mee te nemen

- [ ] Laptop + adapter voor beamer/scherm
- [ ] Backup slides (PDF) voor als internet uitvalt
- [ ] Whiteboard markers (voor de opener in Blok 1)
