# Intelligence Layer

## Messy Inputs
- Staff describe missing documents inconsistently ("Jan bank stmt", "bank statements for Jan", "January bank")
- Deadlines typed in various formats
- Status sometimes left at default even after documents arrive

## Auto-Structure (v1 — rule-based)
Reminder message template (deterministic, no AI):
```json
{
  "client_name": "Maple Trading Pte Ltd",
  "service_type": "Accounting & GST",
  "missing_documents": [
    "Bank statements Jan–Dec 2024",
    "Sales invoices Q4 2024"
  ],
  "deadline": "15 Feb 2025",
  "generated_message": "Dear Maple Trading Pte Ltd,\n\nThis is a friendly reminder that we are still awaiting the following documents for your Accounting & GST filing:\n\n• Bank statements Jan–Dec 2024\n• Sales invoices Q4 2024\n\nKindly send these to us by 15 Feb 2025.\n\nThank you for your cooperation."
}
```

## Events to Track
- Document request created
- Status changed (from → to, timestamp, who)
- Reminder message generated
- Deadline passed with status still open

## Urgency Scoring (rule-based, v1)
- Overdue: deadline < today AND status not Completed → score 3 (red)
- Due ≤ 7 days: score 2 (amber)
- Due > 7 days: score 1 (normal)
- Dashboard sorts by score desc, then deadline asc.

## Later (not v1)
- AI-drafted message tone variation (formal / friendly)
- Auto-suggest document names based on service type
- Confidence scoring on AI-drafted messages stored in `message_text_confidence`
