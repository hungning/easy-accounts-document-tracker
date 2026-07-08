# Security

## Secrets
- Supabase URL and anon key stored in `.env.local` / Vercel environment variables only.
- Service role key never exposed to the browser or committed to the repo.
- All DB access from the frontend uses the anon key + RLS — the service role key is used only in server-side migration scripts.

## Permission Model
- **v1 (demo):** Open RLS policies — any visitor can read and write. Acceptable because no real client data lives here yet.
- **Lock-down sprint:** Replace all policies with `auth.uid() = user_id`. Every insert stamps `user_id = auth.uid()`. Users see only their own firm's data.
- Agent actions inherit the session user's permissions — no privilege escalation.

## Approved Tools Rule
- Only named, scoped tools are called: `generate_reminder_message`, `copy_to_clipboard`, `update_document_status`.
- No `run_any` / `eval` / `send_any` patterns allowed.
- Reminder message generation reads data only — it never writes or sends without explicit user action.

## Audit Principle
- Every status change, client deletion, and reminder generation writes a row to `audit_logs`.
- Logs are append-only (no update/delete policy on `audit_logs`).
- Until auth is live, `actor_user_id` is null — acceptable for internal demo phase only.

## Data-Loss Risk
- Client delete is the only destructive action. It must show a confirmation modal naming the client and stating how many document requests will be removed.
- If in doubt about security or RLS correctness before real client data is loaded: stop and get a human to review.
