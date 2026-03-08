# Make.com Demo Scenario: Order Intake Automatisering

Setup-handleiding voor de pre-built demo in Blok 3 van de workshop.

## Overzicht

Het scenario automatiseert het order intake proces:

```
Custom Webhook (trigger) --> OpenAI (ChatGPT) --> Bevestigingsmail (naar klant) --> Notificatiemail (naar productie)
```

## Stap 1: Make.com Scenario opbouwen

### Module 1: Custom Webhook (Trigger)

1. Maak een nieuw scenario in Make.com
2. Kies module: **Webhooks > Custom Webhook**
3. Klik op **Add** om een nieuwe webhook aan te maken
4. Geef de webhook een naam, bijv. "Order Intake Webhook"
5. Klik **Save** en kopieer de gegenereerde **Webhook URL**
6. Klik op **Re-determine data structure** en stuur een test-POST met de volgende JSON-body (of gebruik het HTML-formulier, zie Stap 2):

```json
{
  "Bedrijfsnaam": "Test BV",
  "Contactpersoon": "Jan de Tester",
  "Email": "test@voorbeeld.nl",
  "Product omschrijving": "Printplaten PCB-2024",
  "Aantal": 50,
  "Gewenste leverdatum": "2026-03-14"
}
```

De webhook herkent nu automatisch de volgende velden:

| Veld | Type |
|------|------|
| Bedrijfsnaam | Text |
| Contactpersoon | Text |
| Email | Text |
| Product omschrijving | Text |
| Aantal | Number |
| Gewenste leverdatum | Text |

### Module 2: OpenAI - Create a Chat Completion

1. Voeg module toe: **OpenAI > Create a Chat Completion**
2. Maak een connectie aan met de API key die de trainer uitdeelt tijdens de workshop
3. Configureer:
   - **Model:** `gpt-4o-mini` (goedkoopste optie, snel genoeg voor deze toepassing)
   - **System prompt:**

```
Je bent een professionele klantenservice medewerker. Je ontvangt ordergegevens en genereert twee outputs in JSON formaat: 1) Een beleefde, persoonlijke bevestigingsmail in het Nederlands, 2) Een korte analyse van de bestelling voor het productieteam (urgentie, productcategorie, geschatte complexiteit). Antwoord ALLEEN met valid JSON.
```

   - **User message:**

```
Nieuwe bestelling ontvangen:
Bedrijfsnaam: {{1.Bedrijfsnaam}}
Contactpersoon: {{1.Contactpersoon}}
Email: {{1.Email}}
Product: {{1.Product omschrijving}}
Aantal: {{1.Aantal}}
Gewenste leverdatum: {{1.Gewenste leverdatum}}
```

4. Het verwachte antwoordformaat (JSON) ziet er als volgt uit:

```json
{
  "bevestigingsmail": "Beste Jan de Tester,\n\nHartelijk dank voor uw bestelling...",
  "analyse": {
    "urgentie": "normaal",
    "productcategorie": "printplaten",
    "complexiteit": "gemiddeld"
  }
}
```

> **Let op:** De trainer deelt een gedeelde API key uit tijdens de workshop. Voer deze in bij het aanmaken van de OpenAI-connectie in Make.com.

### Module 3: Email - Send an Email (Bevestiging naar klant)

1. Voeg module toe: **Email > Send an Email**
2. Configureer:
   - **To:** `{{1.Email}}`
   - **Subject:** `Bevestiging ontvangst aanvraag - {{1.Bedrijfsnaam}}`
   - **Content:** `{{2.result}}` (het `bevestigingsmail`-veld uit de geparseerde JSON van de OpenAI-module)

> **Tip:** Gebruik de functie `parseJSON()` in Make.com om het JSON-antwoord van OpenAI te parsen. De content wordt dan: `{{parseJSON(2.result).bevestigingsmail}}`

### Module 4: Email - Send an Email (Notificatie naar productie)

1. Voeg module toe: **Email > Send an Email**
2. Configureer:
   - **To:** je eigen e-mailadres (simuleert het productie team)
   - **Subject:** `Nieuwe bestelling - {{1.Bedrijfsnaam}}`
   - **Content:**

```
Nieuwe bestelling ontvangen:

Bedrijf: {{1.Bedrijfsnaam}}
Contactpersoon: {{1.Contactpersoon}}
Email: {{1.Email}}
Product: {{1.Product omschrijving}}
Aantal: {{1.Aantal}}
Gewenste leverdatum: {{1.Gewenste leverdatum}}

--- AI Analyse ---
Urgentie: {{parseJSON(2.result).analyse.urgentie}}
Productcategorie: {{parseJSON(2.result).analyse.productcategorie}}
Complexiteit: {{parseJSON(2.result).analyse.complexiteit}}

Actie vereist: controleer beschikbaarheid en plan productie.
```

## Stap 2: Testen

1. Klik **Run once** in Make.com
2. Open het HTML-bestelformulier (`assets/order-form.html`) in je browser
3. Plak de **Webhook URL** uit Stap 1 in het URL-veld van het formulier
4. Vul het formulier in met testdata:
   - Bedrijfsnaam: "Test BV"
   - Contactpersoon: "Jan de Tester"
   - Email: je eigen e-mailadres
   - Product omschrijving: "Printplaten PCB-2024"
   - Aantal: 50
   - Gewenste leverdatum: volgende week
5. Klik op **Verstuur bestelling**
6. Verifieer:
   - [ ] OpenAI-module geeft een JSON-antwoord terug (check in de module-output)
   - [ ] Bevestigingsmail ontvangen met AI-gegenereerde tekst
   - [ ] Notificatiemail ontvangen met AI-analyse (urgentie, categorie, complexiteit)

> **Tip:** Je kunt ook handmatig een POST-request sturen met een tool als cURL of Postman naar de Webhook URL met de JSON-body uit Stap 1.

## Stap 3: Scenario activeren (optioneel)

Voor de live demo kun je het scenario op "On" zetten zodat het automatisch triggert bij nieuwe webhook requests, of gebruik "Run once" voor gecontroleerde demo's.

## Scenario structuur (visueel)

```
[Webhooks]            [OpenAI]              [Email]              [Email]
 Custom Webhook -----> ChatGPT -----------> Send Email -------> Send Email
 (Trigger)            (Analyse &            (Bevestiging)        (Notificatie +
                       mailtekst)                                 AI analyse)
```

## Blueprint

Een referentie-blueprint is beschikbaar in `make-scenario-blueprint.json`. Dit bestand documenteert de volledige scenario-structuur met alle module-configuraties en veld-mappings.

## Troubleshooting

| Probleem | Oplossing |
|----------|----------|
| Webhook URL werkt niet | Controleer of je de volledige URL hebt gekopieerd inclusief het pad na `hook.make.com` |
| Velden worden niet herkend | Klik op **Re-determine data structure** en stuur opnieuw een test-POST met alle velden |
| Email komt niet aan | Check de spam folder; gebruik een echt e-mailadres voor de test |
| "Run once" toont geen data | Zorg dat je eerst "Run once" klikt en daarna het formulier verstuurt (binnen 5 minuten) |
| Formulier geeft CORS-fout | Open het HTML-bestand lokaal in de browser, niet vanaf een andere server |
| OpenAI API key ongeldig | Controleer of je de juiste API key van de trainer hebt ingevoerd; maak eventueel een nieuwe connectie aan |
| OpenAI rate limit error | Wacht 30-60 seconden en probeer opnieuw; bij aanhoudende fouten, vraag de trainer om een alternatieve key |
| OpenAI geeft geen valid JSON | Controleer of de system prompt exact is overgenomen; voeg eventueel "Antwoord ALLEEN met valid JSON, geen extra tekst." toe aan het einde van de system prompt |
| parseJSON() fout in Make.com | Het OpenAI-antwoord bevat mogelijk extra tekst buiten de JSON; gebruik een Text Parser module om alleen de JSON te extraheren |

## Bonus: Spreadsheet koppeling

Wil je de bestellingen ook opslaan in een spreadsheet? Voeg dan een 5e module toe aan het scenario:

### Optie A: Google Sheets

1. Voeg module toe: **Google Sheets > Add a Row**
2. Maak een connectie met je Google account
3. Selecteer of maak een spreadsheet met kolommen: Bedrijfsnaam, Contactpersoon, Email, Product omschrijving, Aantal, Gewenste leverdatum
4. Map de velden van de webhook (Module 1) naar de kolommen

### Optie B: Microsoft 365 Excel

1. Voeg module toe: **Microsoft 365 Excel > Add a Row**
2. Maak een connectie met je Microsoft 365 account
3. Selecteer of maak een werkmap met dezelfde kolommen
4. Map de velden van de webhook (Module 1) naar de kolommen

Plaats de spreadsheet-module direct na de webhook (tussen Module 1 en Module 2), zodat de data eerst wordt opgeslagen voordat de AI-verwerking en e-mails worden verstuurd.
