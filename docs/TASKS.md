# Tasks & Sprints

## Sprint 1 — Database + Core CRUD
**Goal:** The database is live, demo data is seeded, staff can add/edit clients and document requests without logging in.

- [ ] Run migration SQL (clients, document_requests, team_members, reminder_messages, open RLS policies)
- [ ] Verify seed data visible in Supabase table editor
- [ ] Build `/` (dashboard) — table of clients with open doc count, FYE, service type, PIC; sorted by earliest deadline
- [ ] Loading state (skeleton rows), empty state ("No clients yet — add your first one"), error state on dashboard
- [ ] Build Add Client form — name, FYE, service type, PIC — POST to `clients`, redirect to client detail
- [ ] Build `/clients/[id]` detail page — client info + list of document requests
- [ ] Build Add Document Request form on detail page — document name, deadline, status — POST to `document_requests`
- [ ] Inline status dropdown on each document request row — PATCH to `document_requests.status`, UI updates without full reload
- [ ] Edit Client form (pre-filled)
- [ ] Delete Document Request (confirm prompt)
- [ ] Empty/loading/error states on detail page

**Definition of Done:** Seeded demo clients visible on dashboard on first load. Can add a new client, add a document request, and change its status — all changes survive a hard refresh.

---

## Sprint 2 — Dashboard Urgency + Reminder Generator ✅ v1 functional milestone
**Goal:** The one core workflow works end-to-end: track missing docs, set deadline, assign PIC, update status, generate reminder, copy.

- [ ] Deadline urgency badge on dashboard rows: red (overdue), amber (≤7 days), grey (later)
- [ ] Sort dashboard by urgency score then deadline ascending
- [ ] Add follow-up date and client reply fields to document request form + detail view
- [ ] Add internal notes field to client detail page
- [ ] Build "Generate Reminder" button on client detail page → renders message in textarea
- [ ] Message includes: client name, service type, list of non-Completed documents, earliest deadline, polite template wording
- [ ] "Copy to Clipboard" button — browser clipboard API, shows "Copied!" confirmation
- [ ] Save generated message to `reminder_messages` table (with source=`rule_template`, confidence=1.0)
- [ ] Delete Client (confirm modal naming client + doc count)
- [ ] Full end-to-end test per TEST_PLAN.md

**Definition of Done:** Staff can complete the full success scenario (PRD Definition of Done) — add client, add docs, set deadline, assign PIC, update status, generate + copy reminder — all without login, all surviving refresh.

---

## Sprint 3 — Filters, Search & Polish
**Goal:** Team can quickly find any client without scrolling.

- [ ] Filter bar: by service type, by person in charge, by status
- [ ] Search by client name (client-side filter on loaded data)
- [ ] Highlight overdue rows in red on dashboard
- [ ] "Mark all Received" button on client detail → confirm → bulk update status, suggest Completed
- [ ] Mobile-responsive layout (Tailwind breakpoints)
- [ ] Page titles and nav consistent
- [ ] Empty filter state: "No clients match these filters"

**Definition of Done:** Filtering by service type and PIC returns correct subset; empty filter state shows helpful message; layout usable on a phone screen.

---

## Sprint 4 — Lock It Down (Auth + Per-User RLS)
**Goal:** Real client data is safe behind login; each firm sees only its own data.

- [ ] Enable Supabase Auth (email + password)
- [ ] Login page at `/login`; redirect unauthenticated users away from all data pages
- [ ] Replace all v1 open RLS policies with `auth.uid() = user_id` owner-scoped policies
- [ ] All inserts stamp `user_id = auth.uid()`
- [ ] Migrate seed data to a demo user account
- [ ] Confirm no cross-user data leakage (test with two separate accounts)
- [ ] Basic team invite (add team member email, they receive Supabase magic link)

**Definition of Done:** Two separate test accounts cannot see each other's clients. Unauthenticated visit to `/` redirects to `/login`. Data entered by account A is invisible to account B.

---

## Gantt (sprint → feature)
```
Sprint 1  |--DB schema--|--Client CRUD--|--DocRequest CRUD--|--Status update--|
Sprint 2               |--Urgency sort--|--Reminder gen--|--Copy--|--v1 ✅--|
Sprint 3                                                         |--Filters--|--Mobile--|
Sprint 4                                                                       |--Auth--|--RLS lock--|--Team invite--|
```
