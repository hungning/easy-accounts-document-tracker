# Agentic Layer

## Risk Levels & Actions

### Low Risk — Auto (no approval needed)
- Generate reminder message text from template → `generate_reminder_message(client_id)` — produces draft text only, does not send
- Compute urgency score for each open document request → displayed on dashboard
- Auto-suggest status change to "Completed" when all document requests for a client are marked Received

### Medium Risk — Light Approval
- Bulk-update status for all documents of a client (e.g. mark all Received) → user confirms before commit
- Mark a document request as Completed → single confirm step

### High Risk — Always Approval (v1: not built, noted for later)
- Sending the reminder message via email or WhatsApp API → must be explicitly triggered, logged, rate-limited

### Critical — Human Only
- Delete a client and all their document requests → confirmation modal + plain-language warning about data loss
- Bulk delete → not available in v1

## Named Tools (v1)
- `generate_reminder_message` — reads client + open document_requests, renders template string
- `copy_to_clipboard` — browser clipboard API only, no external call
- `update_document_status` — single-row update to `document_requests.status`

## Audit Log Fields (on every meaningful action)
- `action_type` (e.g. `status_updated`, `reminder_generated`, `client_deleted`)
- `entity_type` + `entity_id`
- `actor_user_id` (nullable in v1)
- `before_value`, `after_value`
- `created_at`

## Later
- WhatsApp Business API send (high risk, gated)
- Scheduled follow-up reminder nudges
