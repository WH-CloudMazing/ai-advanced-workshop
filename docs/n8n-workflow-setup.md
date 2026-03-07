# n8n Demo Workflow: Order Intake Automatisering

Setup-handleiding voor de pre-built demo in Blok 5 van de workshop.

## Overzicht

De workflow spiegelt het Make.com scenario en automatiseert hetzelfde order intake proces:

```
Microsoft Forms Trigger --> Excel Online (rij toevoegen) --> Bevestigingsmail (naar klant)
                                                          --> Notificatiemail (naar productie)
```

Na de Excel Online node splitst de workflow in twee parallelle e-mail nodes (in tegenstelling tot Make.com waar ze sequentieel zijn). Dit is een goed voorbeeld van een verschil om te bespreken in de vergelijking.

## Stap 1: Voorbereidingen

Gebruik dezelfde Microsoft Form en Excel Online werkmap als bij het Make.com scenario (zie `make-scenario-setup.md` Stap 1 en 2).

Daarnaast heb je nodig:
- Een draaiende n8n instance (cloud of self-hosted)
- SMTP-instellingen voor het verzenden van e-mails (bijv. Gmail App Password, Mailgun, of een ander SMTP-account)
- Microsoft 365 account met toegang tot Forms en Excel Online

## Stap 2: Workflow importeren

1. Open n8n en ga naar **Workflows**
2. Klik op het menu (drie puntjes) en kies **Import from File**
3. Selecteer `n8n-workflow.json`
4. De workflow verschijnt met 4 nodes

## Stap 3: Credentials configureren

### Microsoft Forms Trigger
1. Klik op de node **Microsoft Forms Trigger**
2. Maak een nieuwe credential aan: **Microsoft OAuth2 API**
3. Volg de autorisatiestappen en geef toegang tot Microsoft Forms
4. Selecteer het formulier "Order Intake - Faber Electronics"

### Microsoft Excel 365 - Rij toevoegen
1. Klik op de node **Microsoft Excel 365 - Rij toevoegen**
2. Maak een nieuwe credential aan: **Microsoft OAuth2 API** (gebruik dezelfde als bij Forms)
3. Selecteer de werkmap "Orders"
4. Controleer dat de kolomnamen overeenkomen

### Bevestigingsmail & Notificatiemail
1. Klik op een van de e-mail nodes
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

## Stap 5: Workflow activeren (optioneel)

Klik op de **Active** toggle rechtsboven om de workflow automatisch te laten triggeren bij nieuwe form submissions.

## Workflow structuur (visueel)

```
[Microsoft Forms Trigger] --> [Excel Online] --+--> [Bevestigingsmail]
                                                |
                                                +--> [Notificatiemail]
```

## Vergelijking met Make.com

| Aspect | Make.com | n8n |
|--------|----------|-----|
| Trigger | Microsoft 365 > Watch Form Responses | Microsoft Forms Trigger node |
| Sheet | Microsoft 365 Excel > Add a Row | Microsoft Excel 365 node (append) |
| Email | Email > Send an Email (2x sequentieel) | Email Send node (2x parallel na split) |
| Credentials | Per-module connecties | Centraal credential management |
| Expressies | `{{1.Bedrijfsnaam}}` | `{{ $json.Bedrijfsnaam }}` |
| Flow | Lineair (A > B > C > D) | Kan splitsen (A > B > C+D parallel) |

## Blueprint

Een referentie-workflow is beschikbaar in `n8n-workflow.json`. Dit bestand kan direct geimporteerd worden in n8n via **Import from File**.

## Troubleshooting

| Probleem | Oplossing |
|----------|----------|
| Microsoft Forms Trigger werkt niet | Controleer of de Microsoft OAuth2 credential correct is en het formulier geselecteerd |
| Microsoft OAuth fout | Controleer of de juiste permissions (Forms.Read, Files.ReadWrite) zijn toegekend; herconnecteer indien nodig |
| Sheet kolommen matchen niet | Zorg dat de kolomnamen in de node exact overeenkomen met de sheet headers |
| E-mail komt niet aan | Check SMTP-instellingen; bij Gmail: gebruik een App Password (niet je gewone wachtwoord) |
| Workflow test toont geen data | Vul eerst het formulier in, wacht even, voer dan de test opnieuw uit |
