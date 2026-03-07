# Make.com Demo Scenario: Order Intake Automatisering

Setup-handleiding voor de pre-built demo in Blok 3 van de workshop.

## Overzicht

Het scenario automatiseert het order intake proces:

```
Microsoft Form (trigger) --> Excel Online (rij toevoegen) --> Bevestigingsmail (naar klant) --> Notificatiemail (naar productie)
```

## Stap 1: Microsoft Form aanmaken

Maak een Microsoft Form met de titel **"Order Intake - Faber Electronics"** en de volgende velden:

| Veld | Type | Verplicht |
|------|------|-----------|
| Bedrijfsnaam | Kort antwoord | Ja |
| Contactpersoon | Kort antwoord | Ja |
| Email | Kort antwoord | Ja |
| Product omschrijving | Lang antwoord | Ja |
| Aantal | Kort antwoord (nummer) | Ja |
| Gewenste leverdatum | Datum | Ja |

## Stap 2: Excel Online werkmap aanmaken

Maak een Excel Online werkmap met de naam **"Orders"** en de volgende kolommen in rij 1:

| A | B | C | D | E | F |
|---|---|---|---|---|---|
| Bedrijfsnaam | Contactpersoon | Email | Product omschrijving | Aantal | Gewenste leverdatum |

## Stap 3: Make.com Scenario opbouwen

### Module 1: Microsoft 365 - Watch Form Responses (Trigger)

1. Maak een nieuw scenario in Make.com
2. Kies module: **Microsoft 365 > Watch Form Responses**
3. Maak een connectie met je Microsoft 365 account
4. Selecteer het formulier "Order Intake - Faber Electronics"
5. Klik **OK** en kies "From now on" als startpunt

### Module 2: Microsoft 365 Excel - Add a Row

1. Voeg module toe: **Microsoft 365 Excel > Add a Row**
2. Gebruik dezelfde Microsoft 365 connectie
3. Selecteer werkmap: "Orders"
4. Map de velden:

| Sheet kolom | Formulier veld |
|-------------|---------------|
| Bedrijfsnaam | `{{1.Bedrijfsnaam}}` |
| Contactpersoon | `{{1.Contactpersoon}}` |
| Email | `{{1.Email}}` |
| Product omschrijving | `{{1.Product omschrijving}}` |
| Aantal | `{{1.Aantal}}` |
| Gewenste leverdatum | `{{1.Gewenste leverdatum}}` |

### Module 3: Email - Send an Email (Bevestiging naar klant)

1. Voeg module toe: **Email > Send an Email**
2. Configureer:
   - **To:** `{{1.Email}}`
   - **Subject:** `Bevestiging ontvangst aanvraag - {{1.Bedrijfsnaam}}`
   - **Content:**

```
Beste {{1.Contactpersoon}},

Bedankt voor uw aanvraag. Wij hebben de volgende gegevens ontvangen:

Bedrijf: {{1.Bedrijfsnaam}}
Product: {{1.Product omschrijving}}
Aantal: {{1.Aantal}}
Gewenste leverdatum: {{1.Gewenste leverdatum}}

Wij nemen zo spoedig mogelijk contact met u op.

Met vriendelijke groet,
Faber Electronics
```

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

Actie vereist: controleer beschikbaarheid en plan productie.
```

## Stap 4: Testen

1. Klik **Run once** in Make.com
2. Vul het Microsoft Form in met testdata:
   - Bedrijfsnaam: "Test BV"
   - Contactpersoon: "Jan de Tester"
   - Email: je eigen e-mailadres
   - Product omschrijving: "Printplaten PCB-2024"
   - Aantal: 50
   - Gewenste leverdatum: volgende week
3. Verifieer:
   - [ ] Nieuwe rij in Excel Online werkmap "Orders"
   - [ ] Bevestigingsmail ontvangen op het ingevulde e-mailadres
   - [ ] Notificatiemail ontvangen op het productie e-mailadres

## Stap 5: Scenario activeren (optioneel)

Voor de live demo kun je het scenario op "On" zetten zodat het automatisch triggert bij nieuwe form submissions, of gebruik "Run once" voor gecontroleerde demo's.

## Scenario structuur (visueel)

```
[Microsoft Forms]  [Excel Online]     [Email]           [Email]
 Watch Responses --> Add a Row -----> Send Email -----> Send Email
 (Trigger)          (Orders)         (Bevestiging)     (Notificatie)
```

## Blueprint

Een referentie-blueprint is beschikbaar in `make-scenario-blueprint.json`. Dit bestand documenteert de volledige scenario-structuur met alle module-configuraties en veld-mappings.

## Troubleshooting

| Probleem | Oplossing |
|----------|----------|
| Form responses komen niet binnen | Controleer of de Microsoft 365 connectie actief is en het juiste formulier geselecteerd |
| Microsoft OAuth fout | Controleer of de juiste permissions (Forms.Read, Files.ReadWrite) zijn toegekend in de Microsoft 365 connectie |
| Sheet kolommen matchen niet | Zorg dat de kolomnamen exact overeenkomen met de formuliervelden |
| Email komt niet aan | Check de spam folder; gebruik een echt e-mailadres voor de test |
| "Run once" toont geen data | Vul eerst het formulier in, wacht 10 seconden, dan "Run once" |
