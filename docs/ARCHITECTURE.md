# Architecture

## Stack
- **Frontend:** Next.js (App Router) — hosted on Vercel
- **Database + Auth:** Supabase (Postgres + RLS + Auth, added later)
- **Styling:** Tailwind CSS

## What to Build Now vs Later
**Now:** Client CRUD, document request CRUD, status updates, deadline dashboard, reminder message generator — all without login.
**Later:** Login + per-user data isolation, follow-up reminders, filters, audit trail.

## Key User Action — Step by Step
1. Staff opens dashboard → Supabase query returns all clients with open document requests, ordered by earliest deadline.
2. Staff clicks a client → client detail page loads all document requests for that client.
3. Staff adds a missing document → form submits to `document_requests` table, row inserted, list re-renders.
4. Staff changes status → dropdown triggers update to `document_requests.status`, UI reflects new value immediately.
5. Staff clicks "Generate Reminder" → server-side template fills in client name, document list, and deadline → message text rendered in a textarea.
6. Staff clicks "Copy" → clipboard API copies message text; staff pastes into WhatsApp or email.

## Layer Plan
1. **Data layer first** — tables, constraints, seed data, open RLS policies.
2. **App logic** — CRUD forms, status machine, deadline sorting, reminder template engine.
3. **Smart features later** — AI-drafted message tone improvements, urgency scoring (rule-based first, then model-assisted).

## Core Runs Without AI
The reminder message generator uses a deterministic string template. No AI call is required for the app to function end-to-end.
