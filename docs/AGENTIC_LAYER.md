# Agentic Layer

## Risk Levels & Actions

### Low Risk — Auto-execute
- Generate reminder message text from template (no send, just draft)
- Compute overdue status and urgency score
- Auto-suggest follow-up date = deadline minus 7 days

### Medium Risk — Show result, one-click confirm
- Update document request status (e.g. Pending → Waiting for Client)
- Create a new document request pre-filled from a recurring template

### High Risk — Explicit approval required
- Send reminder message via external channel (not v1; would require user to confirm content + recipient before any dispatch)

### Critical — Human only
- Delete a client and all associated requests
- Bulk-delete or bulk-complete requests

## Named Tools (v1)
- `generate_reminder_message(request_id)` — reads client + request, renders template, writes to `reminder_message` field
- `update_request_status(request_id, new_status)` — validates status enum, writes, logs to activity_logs
- `create_document_request(client_id, fields)` — inserts row, logs creation

## Audit Log Fields
Every meaningful action writes to `activity_logs`: `entity_type`, `entity_id`, `action`, `old_value`, `new_value`, `actor_label`, `created_at`.

## v1 vs Later
- **v1:** All three named tools above, all medium-risk or lower.
- **Later:** WhatsApp/email dispatch tool (high risk, always approval gate before firing).
