# Security

## Secret Handling
- Supabase URL and anon key are exposed to the browser (public by design); service role key is **never** in frontend code or committed to the repo.
- All secrets loaded via environment variables (`NEXT_PUBLIC_SUPABASE_URL`, `NEXT_PUBLIC_SUPABASE_ANON_KEY`); service role key in server-only env var, never prefixed `NEXT_PUBLIC_`.

## Permission Model (v1 — demo phase)
- Open RLS policies allow all reads and writes without login (intentional for demo).
- No sensitive client financial data in production until lock-down sprint is complete.

## Permission Model (post lock-down sprint)
- Every insert sets `user_id = auth.uid()`.
- RLS policies: `using (auth.uid() = user_id)` on all tables.
- Agents and server actions inherit the authenticated user's Supabase session — they cannot exceed what that user can read or write.

## Approved Tools Rule
- Only named functions (`generate_reminder_message`, `update_request_status`, `create_document_request`) are callable. No raw `run_any` or `exec_sql` exposed to any agent or UI action.

## Audit Principle
- Every status change, creation, and deletion writes a row to `activity_logs`.
- Logs are append-only (no update/delete policy on activity_logs post lock-down).
- If a security concern arises around auth, payments, or data-loss risk: stop and involve a qualified human before proceeding.
