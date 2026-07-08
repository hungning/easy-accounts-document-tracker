# PRD — Easy Accounts Document Tracker

## Problem
Accounting teams juggle missing client documents across multiple services (accounting, GST, payroll, tax, audit, corporate secretarial) using Excel, WhatsApp, and email — leading to missed deadlines, unclear ownership, and wasted time composing follow-up messages manually.

## Target User
Accounting firm staff (accountants, managers) tracking document requests from multiple clients day-to-day.

## Core Objects
- **Client** — name, financial year-end, service type, person in charge, internal notes
- **Document Request** — document name, deadline, status, follow-up date, client reply
- **Reminder Message** — generated message text ready to copy into WhatsApp or email
- **Team Member** — name, email (for assigning person in charge)

## MVP Must-Haves (v1)
- [ ] Add and edit a client with FYE, service type, and person in charge
- [ ] Add missing document requests to a client with a deadline
- [ ] Update document request status (Pending / Waiting for Client / Partially Received / Received / In Review / Completed)
- [ ] Dashboard listing all clients with outstanding documents, sorted by nearest deadline
- [ ] Deadline urgency indicator (overdue, due soon, on track)
- [ ] Generate a reminder message (client name + missing docs + deadline + polite wording) with one-click copy
- [ ] App renders with demo data without requiring login

## Non-Goals (v1)
No auto email/WhatsApp sending, no Xero integration, no file uploads, no complex permissions, no AI document reading, no payment features.

## Definition of Done
**Pass:** A staff member opens the app, adds "Maple Trading" with two missing documents and a deadline of next Friday, assigns it to themselves, updates one document to "Partially Received", generates a reminder message, and copies it to clipboard — all changes persist after a page refresh, the dashboard shows the client sorted by deadline, and no step requires a login.

**Fail:** Any button does nothing, any save does not survive a refresh, or the reminder message does not include the correct document names and deadline.
