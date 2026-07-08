# Intelligence Layer

## Messy Input
Accountants type free-form lists of missing documents ("Bank stmts Oct-Dec, FA schedule, directors loan agmt"). Deadlines are entered manually. Status is updated ad-hoc.

## Auto-Structured Schema (reminder message output)
```json
{
  "client_name": "Bumi Jaya Sdn Bhd",
  "contact_name": "Mr Hafiz",
  "missing_documents": [
    "Bank statements (Oct–Dec 2023)",
    "Fixed asset schedule",
    "Directors' loan agreement"
  ],
  "deadline": "31 July 2024",
  "generated_message": "Dear Mr Hafiz, ...polite body...",
  "source": "template",
  "confidence": 1.0,
  "review_status": "unreviewed"
}
```

## Events to Track
- Request created
- Status changed (old → new)
- Reminder message generated
- Deadline changed
- Days overdue (computed at query time)

## Scoring Rules (rule-based, v1)
- **Urgency score** = days until deadline (lower = more urgent); negative = overdue
- **Staleness score** = days since last status change
- Dashboard `ORDER BY deadline ASC NULLS LAST` implements urgency ranking without AI

## What Gets Ranked
Document requests on the dashboard, ranked by deadline. Overdue rows surface first with a red badge.

## v1 vs Later
- **v1:** Deterministic template-based message generation; rule-based deadline sort.
- **Later:** AI rewrites the reminder message for tone/language; suggests follow-up date based on client reply patterns; flags clients that are consistently late.
