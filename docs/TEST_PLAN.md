# Test Plan

## Core Success Scenario (manual)
1. Open app at `/` — dashboard loads with seeded demo clients. No login required.
2. Click "Add Client" — fill in Name: "ABC Sdn Bhd", Contact: "Ms Wong", FYE: "31 Dec", Service: "Tax", PIC: "David Tan". Submit.
3. **Pass:** "ABC Sdn Bhd" appears in the client list. Hard refresh — still there.
4. Click "Add Document Request" for ABC Sdn Bhd — enter Missing Documents: "Form C 2023\nCP204 instalment schedule", Deadline: next Friday, Status: "Pending".
5. **Pass:** Request appears on dashboard at correct deadline-sorted position.
6. Click "Generate Reminder" — modal appears with message including "ABC Sdn Bhd", both missing documents, and the deadline.
7. Click "Copy" — button shows "Copied!". Paste into a text editor — message is complete and correct.
8. **Pass:** `reminder_message` field in Supabase now contains the generated text.
9. Change status to "Waiting for Client" from dashboard dropdown.
10. **Pass:** Badge updates immediately; activity_logs gains a new row with action = 'status_changed'.

## Empty State Tests
- Delete all document requests → dashboard shows "No open document requests. Add a client to get started."
- No clients → client list shows "No clients yet — add your first one."

## Error State Tests
- Submit Add Client with blank Name → form shows validation error, no insert fires.
- Simulate Supabase offline (disable network) → dashboard shows error banner "Could not load requests. Please check your connection."
- Simulate failed status update → status badge reverts, error toast shown.

## Overdue Highlighting Test
- Edit a document request deadline to yesterday, status = "Pending".
- **Pass:** Row appears with red highlight on dashboard.

## Reminder Message Content Test
- Generated message must contain: client name, each missing document on its own line, deadline formatted as "DD Month YYYY", and at least one polite sentence.
- **Fail condition:** Any of those four elements is missing from the output.

## Data Persistence Test
- Add a client and a request. Clear browser cache and hard reload (`Ctrl+Shift+R`).
- **Pass:** Both rows still present — data comes from Supabase, not local storage.
