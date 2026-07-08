create table if not exists clients (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  name text not null,
  contact_name text,
  contact_whatsapp text,
  contact_email text,
  financial_year_end text,
  service_type text,
  person_in_charge text,
  notes text
);

alter table clients enable row level security;
drop policy if exists "clients_v1_read" on clients;
create policy "clients_v1_read" on clients for select using (true);
drop policy if exists "clients_v1_write" on clients;
create policy "clients_v1_write" on clients for all using (true) with check (true);

create table if not exists document_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  client_id uuid not null references clients(id) on delete cascade,
  service_type text,
  financial_year text,
  missing_documents text not null,
  deadline date,
  follow_up_date date,
  person_in_charge text,
  status text not null default 'Pending',
  client_reply text,
  internal_notes text,
  reminder_message text,
  reminder_message_source text,
  reminder_message_confidence numeric,
  reminder_message_review_status text default 'unreviewed'
);

alter table document_requests enable row level security;
drop policy if exists "document_requests_v1_read" on document_requests;
create policy "document_requests_v1_read" on document_requests for select using (true);
drop policy if exists "document_requests_v1_write" on document_requests;
create policy "document_requests_v1_write" on document_requests for all using (true) with check (true);

create table if not exists activity_logs (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  created_at timestamptz not null default now(),
  entity_type text not null,
  entity_id uuid not null,
  action text not null,
  old_value text,
  new_value text,
  actor_label text
);

alter table activity_logs enable row level security;
drop policy if exists "activity_logs_v1_read" on activity_logs;
create policy "activity_logs_v1_read" on activity_logs for select using (true);
drop policy if exists "activity_logs_v1_write" on activity_logs;
create policy "activity_logs_v1_write" on activity_logs for all using (true) with check (true);

insert into clients (id, name, contact_name, contact_whatsapp, contact_email, financial_year_end, service_type, person_in_charge, notes) values
  ('a1000000-0000-0000-0000-000000000001', 'Bumi Jaya Sdn Bhd', 'Mr Hafiz', '+60123456789', 'hafiz@bumijaya.com', '31 Dec', 'Audit & Tax', 'Sarah Lim', 'Long-standing client, replies promptly on WhatsApp'),
  ('a1000000-0000-0000-0000-000000000002', 'Greenfield Trading Sdn Bhd', 'Ms Priya', '+60198765432', 'priya@greenfield.com', '31 Mar', 'GST & Payroll', 'David Tan', 'New client onboarded Jan 2024'),
  ('a1000000-0000-0000-0000-000000000003', 'Nexus Capital Bhd', 'Mr Kevin Yong', '+60112223344', 'kevin@nexuscap.com', '30 Jun', 'Corporate Secretarial & Audit', 'Sarah Lim', 'Requires formal email correspondence'),
  ('a1000000-0000-0000-0000-000000000004', 'Sunrise Cafe Sdn Bhd', 'Ms Lily Tan', '+60133334444', 'lily@sunrisecafe.com', '31 Dec', 'Accounting & Tax', 'Ahmad Razif', NULL);

insert into document_requests (client_id, service_type, financial_year, missing_documents, deadline, follow_up_date, person_in_charge, status, internal_notes) values
  ('a1000000-0000-0000-0000-000000000001', 'Audit & Tax', 'FY2023', 'Bank statements (Oct–Dec 2023), Fixed asset schedule, Directors'' loan agreement', '2024-07-31', '2024-07-10', 'Sarah Lim', 'Waiting for Client', 'Chased twice via WhatsApp, client said end of month'),
  ('a1000000-0000-0000-0000-000000000002', 'GST', 'FY2024 Q1', 'GST return supporting invoices, Purchase invoices above RM500', '2024-07-15', '2024-07-05', 'David Tan', 'Pending', NULL),
  ('a1000000-0000-0000-0000-000000000003', 'Audit', 'FY2023', 'Signed audited accounts from previous year, Board resolution for FY2023', '2024-08-15', '2024-07-20', 'Sarah Lim', 'Partially Received', 'Board resolution received, still waiting for signed accounts'),
  ('a1000000-0000-0000-0000-000000000004', 'Accounting & Tax', 'FY2023', 'Cash sales records (Jan–Dec 2023), Supplier invoices, EPF & SOCSO receipts', '2024-07-20', '2024-07-08', 'Ahmad Razif', 'Pending', 'Client prefers WhatsApp reminders');