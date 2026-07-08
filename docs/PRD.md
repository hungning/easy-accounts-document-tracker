# PRD — Easy Accounts Document Tracker

## Problem
Accounting teams chase missing client documents across Excel, WhatsApp, and email with no single source of truth. It is hard to see who owes what, by when, and who is responsible.

## Target User
Accountants and their team members at a small-to-mid accounting firm, using this internally every workday.

## Core Objects
- **Client** — name, contact, financial year-end, service type, person in charge
- **Document Request** — missing documents, deadline, follow-up date, status, client reply, internal notes
- **Reminder Message** — generated plain-text message ready to copy into WhatsApp or email
- **Activity Log** — who changed what and when

## MVP Must-Haves (v1)
- [ ] Add / edit / delete a client
- [ ] Add a document request with missing documents, deadline, service type, person in charge
- [ ] Set and update status: Pending, Waiting for Client, Partially Received, Received, In Review, Completed
- [ ] Dashboard listing all clients with open requests, sorted by deadline ascending
- [ ] Overdue rows visually highlighted
- [ ] Generate a plain-text follow-up message (client name, missing docs, deadline, polite wording) and copy to clipboard
- [ ] All data persists to database; survives page refresh

## Non-Goals (v1)
No automatic sending (WhatsApp or email), no Xero integration, no AI document reading, no payments, no complex user permissions, no public client portal.

## Definition of Done
**Pass:** A team member opens the app, adds a new client "ABC Sdn Bhd" with two missing documents and a deadline of next Friday, sets status to "Pending", clicks Generate Reminder, reads a correct plain-text message, copies it, and sees the client appear at the top of the dashboard sorted by deadline — all without logging in, and with data still present after a hard refresh.

**Fail:** Any button does not persist to the database, the dashboard shows only seed data, or the generated message is blank.
