# Architecture

## Stack
- **Frontend:** Next.js 14 (App Router) + Tailwind CSS
- **Database + Auth:** Supabase (Postgres, RLS, Auth)
- **Hosting:** Vercel
- **Clipboard API:** Browser-native

## What to Build Now vs Later
**Now:** Client CRUD, document request CRUD, status updates, deadline-sorted dashboard, reminder message generator, open RLS (demo-first).
**Later:** Auth + per-user RLS, follow-up date alerts, CSV export, recurring templates, bulk actions.

## Key User Action — Step by Step
1. User opens dashboard — app fetches `document_requests` joined with `clients`, ordered by `deadline ASC`, status ≠ Completed.
2. User clicks "Add Request" for a client — form captures client, missing documents, deadline, PIC, service type.
3. On submit — row inserted into `document_requests`; dashboard refetches and re-renders.
4. User clicks "Generate Reminder" — app reads `client.name`, `document_request.missing_documents`, `document_request.deadline`, renders a plain-text message template, stores draft in `reminder_message` field with `source = 'template'`, `confidence = 1.0`, `review_status = 'unreviewed'`.
5. User clicks "Copy" — `navigator.clipboard.writeText()` fires; user pastes into WhatsApp or email.
6. User updates status to "Waiting for Client" — single field update persists; dashboard badge refreshes immediately.

## Layer Plan
1. **Data layer first** — tables, constraints, RLS policies, seed rows.
2. **App logic** — CRUD forms, status machine, deadline sort, message template renderer.
3. **Smart features on top** — AI-assisted message refinement, overdue scoring, suggested follow-up dates (these are additive; removing them leaves the core intact).

## Core Without AI
The reminder message is generated from a deterministic string template. The dashboard ranking is pure SQL `ORDER BY deadline ASC`. The app is fully functional with zero AI calls.
