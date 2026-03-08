# n8n Demo Workflow: Order Intake Automatisering

Setup-handleiding voor de pre-built demo in Blok 5 van de workshop.

## Overzicht

De workflow gebruikt n8n's ingebouwde Form Trigger om een orderformulier te tonen, de ordergegevens door OpenAI te laten analyseren, en automatisch twee e-mails te versturen:

```
Form Trigger --> OpenAI Chat --+--> Bevestigingsmail (naar klant)
                               +--> Notificatiemail (naar productie)
```

De Form Trigger genereert automatisch een webformulier met alle benodigde velden. Na het invullen analyseert OpenAI de bestelling en genereert een persoonlijke bevestigingsmail en een productie-analyse. Beide e-mails worden vervolgens parallel verstuurd.

## Stap 1: Voorbereidingen

Je hebt nodig:
- Een draaiende n8n instance (cloud of self-hosted)
- SMTP-instellingen voor het verzenden van e-mails (bijv. Gmail App Password, Mailgun, of een ander SMTP-account)
- OpenAI API key (wordt verstrekt door de trainer)

Er zijn geen Microsoft 365, Forms of Excel credentials nodig. De Form Trigger is een ingebouwde n8n node die zonder externe koppelingen werkt.

## Stap 2: Workflow importeren

1. Open n8n en ga naar **Workflows**
2. Klik op het menu (drie puntjes) en kies **Import from File**
3. Selecteer `n8n-workflow.json`
4. De workflow verschijnt met 4 nodes

## Stap 3: Credentials configureren

### OpenAI API Key
1. Klik op de node **OpenAI - Bestelling analyseren**
2. Klik bij Credential op **Create New Credential**
3. Voer de API key in die je van de trainer hebt gekregen
4. Klik op **Save**

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

## Stap 4: OpenAI node configuratie (referentie)

De OpenAI node is al geconfigureerd in de geimporteerde workflow. Hier zijn de instellingen ter referentie:

| Instelling | Waarde |
|------------|--------|
| Node type | OpenAI > Chat |
| Model | gpt-4o-mini |
| Response format | JSON |

**System prompt:**
> Je bent een professionele klantenservice medewerker. Je ontvangt ordergegevens en genereert twee outputs in JSON formaat: 1) Een beleefde, persoonlijke bevestigingsmail in het Nederlands, 2) Een korte analyse van de bestelling voor het productieteam (urgentie, productcategorie, geschatte complexiteit). Antwoord ALLEEN met valid JSON.

**User message:** Bevat alle 6 formuliervelden (Bedrijfsnaam, Contactpersoon, Email, Product omschrijving, Aantal, Gewenste leverdatum).

**Verwacht JSON output formaat:**
```json
{
  "bevestigingsmail": {
    "onderwerp": "Bevestiging bestelling - [bedrijfsnaam]",
    "bericht": "Beste [naam], ..."
  },
  "productie_analyse": {
    "urgentie": "normaal|hoog|spoed",
    "productcategorie": "...",
    "geschatte_complexiteit": "laag|gemiddeld|hoog",
    "samenvatting": "..."
  }
}
```

De e-mail nodes gebruiken de output van OpenAI:
- **Bevestigingsmail**: Gebruikt `{{ $json.message.content }}` (geparsed als JSON) voor het onderwerp en de body
- **Notificatiemail**: Bevat de productie-analyse met urgentie en complexiteit

## Stap 5: Testen

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
   - [ ] OpenAI node toont JSON output met bevestigingsmail en productie-analyse
   - [ ] Bevestigingsmail ontvangen met AI-gegenereerde persoonlijke tekst
   - [ ] Notificatiemail ontvangen met productie-analyse (urgentie, complexiteit)

## Stap 6: Workflow activeren (optioneel)

Klik op de **Active** toggle rechtsboven om de workflow permanent te activeren. n8n genereert dan een **Production URL** voor het formulier die je kunt delen.

## Workflow structuur (visueel)

```
[Form Trigger] --> [OpenAI Chat] --+--> [Bevestigingsmail]
                                   |
                                   +--> [Notificatiemail]
```

## Vergelijking met Make.com

| Aspect | Make.com | n8n |
|--------|----------|-----|
| Trigger | Custom Webhook | Form Trigger node (ingebouwd formulier) |
| AI | OpenAI module (Chat Completion) | OpenAI node (Chat) |
| Email | Email > Send an Email (2x sequentieel) | Email Send node (2x parallel) |
| Credentials | Per-module connecties + webhook URL | Centraal credential management (SMTP + OpenAI) |
| Expressies | `{{1.Bedrijfsnaam}}` | `{{ $json.Bedrijfsnaam }}` |
| Flow | Lineair (A > B > C > D) | Kan splitsen (A > B > C+D parallel) |
| Externe tools | OpenAI (via module) | OpenAI (via node) |

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

In beide gevallen verbind je de Form Trigger met de spreadsheet node parallel aan de OpenAI node, of als extra stap in de keten.

## Blueprint

Een referentie-workflow is beschikbaar in `n8n-workflow.json`. Dit bestand kan direct geimporteerd worden in n8n via **Import from File**.

## Troubleshooting

| Probleem | Oplossing |
|----------|----------|
| Formulier URL werkt niet | Zorg dat de workflow in test- of active-modus staat; de URL is pas beschikbaar na het starten |
| OpenAI node geeft fout | Controleer of de API key correct is ingesteld; check je OpenAI account op voldoende credits |
| OpenAI response is geen valid JSON | Controleer de system prompt; probeer de temperature lager te zetten (bijv. 0.3) |
| E-mail komt niet aan | Check SMTP-instellingen; bij Gmail: gebruik een App Password (niet je gewone wachtwoord) |
| E-mail body toont raw JSON | Controleer dat de expressies in de e-mail nodes de juiste JSON-paden gebruiken (bijv. `{{ JSON.parse($json.message.content).bevestigingsmail.bericht }}`) |
| Velden komen niet door in OpenAI | Controleer dat de expressies exact overeenkomen met de veldnamen in de Form Trigger (bijv. `{{ $json.Bedrijfsnaam }}`) |
| Workflow test toont geen data | Open de Test URL in je browser en submit het formulier; de workflow wacht op een inzending |
