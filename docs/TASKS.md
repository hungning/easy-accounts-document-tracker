# Tasks & Sprints

## Sprint 1 — Database + Core CRUD Engine
**Goal:** The fundamental data layer and all create/edit/delete actions work and persist. App is viewable without login.

- [ ] Apply migration SQL to Supabase project (clients, document_requests, activity_logs, RLS v1 policies, seed data)
- [ ] Client list page: displays all clients; empty state ("No clients yet — add your first one")
- [ ] Add Client form: name, contact, FYE, service type, PIC — validates required fields, persists, list refreshes
- [ ] Edit Client: pre-filled form, updates row
- [ ] Delete Client: confirmation prompt, cascades to document_requests
- [ ] Add Document Request form: client select, missing documents (textarea), deadline, service type, PIC, status dropdown
- [ ] Edit Document Request: pre-filled, updates row
- [ ] All forms: loading state on submit, error state on failure, success redirect
- [ ] Page refresh shows persisted data (not just local state)

**Definition of Done:** Add a client, add a document request for that client with a deadline, refresh the page — both rows still exist and all fields are correct.

---

## Sprint 2 — Dashboard + Reminder Message Generator ✦ v1 functional milestone
**Goal:** The one core workflow works end-to-end. This is the success scenario from the PRD.

- [ ] Dashboard page is the app homepage (`/`): lists all document_requests joined with clients, sorted by `deadline ASC`
- [ ] Status badge with colour per status value
- [ ] Overdue rows highlighted in red (deadline < today AND status ≠ Completed)
- [ ] Inline status update dropdown on dashboard row — persists on change, logs to activity_logs
- [ ] "Generate Reminder" button per row: builds plain-text message (Dear [contact], missing docs list, deadline, polite closing), stores in `reminder_message` field, displays in modal
- [ ] "Copy to clipboard" button inside modal; shows "Copied!" confirmation
- [ ] Empty state: "No open document requests. Add a client to get started."
- [ ] Loading skeleton while data fetches
- [ ] Error state if Supabase fetch fails

**Definition of Done (= PRD success scenario):** Team member adds "ABC Sdn Bhd" with two missing documents and next-Friday deadline, generates reminder message, copies it, sees client at top of dashboard sorted by deadline — all without logging in, data survives hard refresh.

---

## Sprint 3 — Follow-up Details + Filters
**Goal:** Richer tracking and navigation for a team managing many clients.

- [ ] Follow-up date field on document request form; shown on dashboard
- [ ] Client reply field and internal notes field on edit form
- [ ] Filter bar: filter dashboard by service type, person in charge, status
- [ ] Search by client name (client-side filter)
- [ ] Activity log panel per document request (shows status change history)
- [ ] "Partially received" checklist: mark individual documents as received within a request

**Definition of Done:** Filter by PIC "Sarah Lim" shows only her requests; activity log shows at least the creation event and any status changes.

---

## Sprint 4 — Lock It Down (Auth + Per-User Isolation)
**Goal:** Real team members log in; data is isolated per account; open demo policies are closed.

- [ ] Supabase Auth: email/password sign-up, login, logout
- [ ] Login page at `/login`; unauthenticated users redirected there
- [ ] All inserts set `user_id = auth.uid()`
- [ ] Replace v1 open RLS policies with `using (auth.uid() = user_id)` on all tables
- [ ] Verify no data leaks between accounts in Supabase Studio
- [ ] Team invite: owner can invite additional email addresses (same user_id scope or team scope TBD)

**Definition of Done:** Two separate accounts cannot see each other's clients or requests. Unauthenticated GET to `/` redirects to `/login`.

---

## Gantt (sprint → feature)
```
Sprint 1 │ DB schema · Client CRUD · Document Request CRUD
Sprint 2 │ Dashboard · Deadline sort · Status update · Reminder generator · Copy-to-clipboard
Sprint 3 │ Follow-up dates · Notes · Filters · Search · Activity log
Sprint 4 │ Auth · Login/logout · Owner RLS · Team invite
```
