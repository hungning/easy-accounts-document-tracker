# Data Model

## clients
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | gen_random_uuid() |
| user_id | uuid nullable | owner scope, added at lock-down |
| created_at | timestamptz | default now() |
| name | text | required |
| contact_name | text | |
| contact_whatsapp | text | |
| contact_email | text | |
| financial_year_end | text | e.g. "31 Dec" |
| service_type | text | Accounting / GST / Payroll / Tax / Audit / CorpSec |
| person_in_charge | text | |
| notes | text | |

## document_requests
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| client_id | uuid FK → clients.id | cascade delete |
| service_type | text | may differ from client default |
| financial_year | text | e.g. "FY2023" |
| missing_documents | text | required; newline-separated list |
| deadline | date | |
| follow_up_date | date | |
| person_in_charge | text | |
| status | text | default 'Pending'; one of six allowed values |
| client_reply | text | |
| internal_notes | text | |
| reminder_message | text | **AI field** |
| reminder_message_source | text | e.g. 'template' or 'ai-generated' |
| reminder_message_confidence | numeric | 0.0–1.0 |
| reminder_message_review_status | text | default 'unreviewed' |

## activity_logs
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| created_at | timestamptz | |
| entity_type | text | 'client' or 'document_request' |
| entity_id | uuid | |
| action | text | e.g. 'status_changed', 'request_created' |
| old_value | text | |
| new_value | text | |
| actor_label | text | display name or email |

## RLS
All tables: v1 open policies (select + all using true). Replaced with `auth.uid() = user_id` at lock-down sprint.

## Relationships
`document_requests.client_id` → `clients.id` (many requests per client).
