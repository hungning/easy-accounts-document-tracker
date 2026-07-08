# Test Plan

## Success Scenario (manual, end-to-end)

1. Open app at `/` (no login). **Pass:** Dashboard loads with seeded demo clients sorted by deadline. **Fail:** Login wall, blank page, or JS error.
2. Click "Add Client". Fill in name = "Test Corp Pte Ltd", FYE = 31 Dec 2024, service type = "Accounting & GST", PIC = "Sarah Tan". Submit. **Pass:** Client appears on dashboard. **Fail:** Form submits but client not visible; refresh loses it.
3. Click into "Test Corp Pte Ltd". Click "Add Document Request". Fill document name = "Bank statements 2024", deadline = next Friday, status = "Pending". Submit. **Pass:** Document appears in list. **Fail:** Document missing after submit or refresh.
4. Add a second document request: "Sales invoices Q4 2024", same deadline, status = "Pending". **Pass:** Both documents listed.
5. Change first document status to "Partially Received" via dropdown. **Pass:** Badge updates immediately. Refresh — still shows "Partially Received". **Fail:** Reverts to Pending on refresh.
6. Click "Generate Reminder". **Pass:** Textarea shows message containing "Test Corp Pte Ltd", "Bank statements 2024", "Sales invoices Q4 2024", and the deadline date. **Fail:** Any of those missing.
7. Click "Copy to Clipboard". **Pass:** "Copied!" confirmation shown; pasting elsewhere yields full message text. **Fail:** Button does nothing or copies empty string.
8. Return to dashboard. **Pass:** "Test Corp Pte Ltd" appears with urgency badge and correct open document count. **Fail:** Client missing or count wrong.

## Empty State Tests
- Dashboard with no clients: shows "No clients yet — add your first one" with Add Client CTA.
- Client detail with no document requests: shows "No documents requested yet — add the first one".
- Filtered view with no matches: shows "No clients match these filters — clear filters to see all".

## Error State Tests
- Submit Add Client form with empty name: inline validation error, no DB call.
- Submit Add Document Request with no document name: inline error, no DB call.
- Simulate network failure on status update: show toast "Failed to update status — please try again"; revert dropdown to previous value.
- Delete client: confirm modal shows client name and count of document requests to be removed. Cancel leaves data intact. Confirm removes client and all requests.

## Deadline Urgency Tests
- Document with deadline yesterday and status Pending: red badge, sorted to top.
- Document with deadline in 5 days: amber badge.
- Document with deadline in 30 days: no urgency badge.
- Document with status Completed: excluded from missing documents list and reminder message.
