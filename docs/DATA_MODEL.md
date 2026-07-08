# Data Model

## team_members
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | owner scope (post lock-down) |
| name | text not null | |
| email | text | |
| created_at | timestamptz | |

## clients
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| name | text not null | |
| financial_year_end | date | |
| service_type | text not null | Accounting, GST, Payroll, Tax, Audit, CorpSec |
| person_in_charge | text | free text, joins to team_members by name |
| internal_notes | text | |
| created_at | timestamptz | |

## document_requests
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| client_id | uuid FK → clients | cascades on delete |
| document_name | text not null | |
| deadline | date | |
| status | text not null | enum: Pending, Waiting for Client, Partially Received, Received, In Review, Completed |
| follow_up_date | date | |
| client_reply | text | |
| created_at | timestamptz | |

## reminder_messages
| Field | Type | Notes |
|---|---|---|
| id | uuid PK | |
| user_id | uuid nullable | |
| client_id | uuid FK → clients | |
| message_text | text not null | AI field: also stores message_text_source, message_text_confidence, message_text_review_status |
| message_text_source | text | e.g. `rule_template` or `ai_draft` |
| message_text_confidence | numeric | 1.0 for rule-based; <1.0 for AI-drafted |
| message_text_review_status | text | default `unreviewed`; set to `approved` before copy |
| generated_at | timestamptz | |
| created_at | timestamptz | |

## RLS
- All tables: v1 open read + write policies (any visitor).
- Lock-down sprint: replace with `auth.uid() = user_id` owner policies.
