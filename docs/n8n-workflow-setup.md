# n8n Demo Workflow: Order Intake Automatisering

Setup-handleiding voor de pre-built demo in Blok 5 van de workshop.

## Overzicht

De workflow gebruikt n8n's ingebouwde Form Trigger om een orderformulier te tonen en automatisch twee e-mails te versturen:

```
Form Trigger --> Bevestigingsmail (naar klant)
             --> Notificatiemail (naar productie)
```

De Form Trigger genereert automatisch een webformulier met alle benodigde velden. Na het invullen worden beide e-mails parallel verstuurd.

## Stap 1: Voorbereidingen

Je hebt nodig:
- Een draaiende n8n instance (cloud of self-hosted)
- SMTP-instellingen voor het verzenden van e-mails (bijv. Gmail App Password, Mailgun, of een ander SMTP-account)

Er zijn geen Microsoft 365, Forms of Excel credentials nodig. De Form Trigger is een ingebouwde n8n node die zonder externe koppelingen werkt.

## Stap 2: Workflow importeren

1. Open n8n en ga naar **Workflows**
2. Klik op het menu (drie puntjes) en kies **Import from File**
3. Selecteer `n8n-workflow.json`
4. De workflow verschijnt met 3 nodes

## Stap 3: Credentials configureren

### SMTP (voor beide e-mail nodes)
1. Klik op een van de e-mail nodes (bijv. **Bevestigingsmail**)
2. Maak een nieuwe credential aan: **SMTP**
3. Configureer:

| Instelling | Waarde |
|------------|--------|
| Host | smtp.gmail.com (of je SMTP provider) |
| Port | 465 (SSL) of 587 (TLS) |
| User | je e-mailadres |
| Password | App-specifiek wachtwoord |
| SSL/TLS | Aan |

4. Gebruik dezelfde SMTP credential voor beide e-mail nodes

### Productie e-mailadres instellen
1. Klik op de node **Notificatiemail**
2. Vervang `{{PRODUCTION_EMAIL}}` in het "Send To" veld door het gewenste e-mailadres

## Stap 4: Testen

1. Klik op **Test Workflow** (of "Execute Workflow")
2. n8n toont een **Test URL** voor het formulier. Open deze URL in je browser.
3. Vul het formulier in met testdata:
   - Bedrijfsnaam: "Test BV"
   - Contactpersoon: "Jan de Tester"
   - Email: je eigen e-mailadres
   - Product omschrijving: "Printplaten PCB-2024"
   - Aantal: 50
   - Gewenste leverdatum: volgende week
4. Klik op **Submit**
5. Verifieer:
   - [ ] Bevestigingsmail ontvangen op het ingevulde e-mailadres
   - [ ] Notificatiemail ontvangen op het productie e-mailadres

## Stap 5: Workflow activeren (optioneel)

Klik op de **Active** toggle rechtsboven om de workflow permanent te activeren. n8n genereert dan een **Production URL** voor het formulier die je kunt delen.

## Workflow structuur (visueel)

```
[Form Trigger] --+--> [Bevestigingsmail]
                 |
                 +--> [Notificatiemail]
```

## Vergelijking met Make.com

| Aspect | Make.com | n8n |
|--------|----------|-----|
| Trigger | Custom Webhook | Form Trigger node (ingebouwd formulier) |
| Email | Email > Send an Email (2x sequentieel) | Email Send node (2x parallel) |
| Credentials | Per-module connecties + webhook URL | Centraal credential management, alleen SMTP |
| Expressies | `{{1.Bedrijfsnaam}}` | `{{ $json.Bedrijfsnaam }}` |
| Flow | Lineair (A > B > C) | Kan splitsen (A > B+C parallel) |
| Externe tools | Geen (webhook vangt data op) | Geen (Form Trigger vangt data op) |

## Bonus: Spreadsheet koppeling

Wil je de orders ook opslaan in een spreadsheet? Voeg dan een extra node toe na de Form Trigger:

### Google Sheets
1. Voeg een **Google Sheets** node toe
2. Kies operatie **Append Row**
3. Koppel je Google account en selecteer de juiste spreadsheet
4. Map de velden: `{{ $json.Bedrijfsnaam }}`, `{{ $json.Contactpersoon }}`, etc.

### Microsoft Excel 365
1. Voeg een **Microsoft Excel 365** node toe
2. Kies operatie **Append**
3. Koppel je Microsoft 365 account en selecteer de werkmap
4. Map de velden op dezelfde manier

In beide gevallen verbind je de Form Trigger met drie nodes (spreadsheet + twee e-mails), die allemaal parallel kunnen draaien.

## Blueprint

Een referentie-workflow is beschikbaar in `n8n-workflow.json`. Dit bestand kan direct geimporteerd worden in n8n via **Import from File**.

## Troubleshooting

| Probleem | Oplossing |
|----------|----------|
| Formulier URL werkt niet | Zorg dat de workflow in test- of active-modus staat; de URL is pas beschikbaar na het starten |
| E-mail komt niet aan | Check SMTP-instellingen; bij Gmail: gebruik een App Password (niet je gewone wachtwoord) |
| Velden komen niet door in e-mail | Controleer dat de expressies exact overeenkomen met de veldnamen in de Form Trigger (bijv. `{{ $json.Bedrijfsnaam }}`) |
| Workflow test toont geen data | Open de Test URL in je browser en submit het formulier; de workflow wacht op een inzending |
