create table if not exists team_members (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  email text,
  created_at timestamptz not null default now()
);

alter table team_members enable row level security;
drop policy if exists "team_members_v1_read" on team_members;
create policy "team_members_v1_read" on team_members for select using (true);
drop policy if exists "team_members_v1_write" on team_members;
create policy "team_members_v1_write" on team_members for all using (true) with check (true);

create table if not exists clients (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  name text not null,
  financial_year_end date,
  service_type text not null,
  person_in_charge text,
  internal_notes text,
  created_at timestamptz not null default now()
);

alter table clients enable row level security;
drop policy if exists "clients_v1_read" on clients;
create policy "clients_v1_read" on clients for select using (true);
drop policy if exists "clients_v1_write" on clients;
create policy "clients_v1_write" on clients for all using (true) with check (true);

create table if not exists document_requests (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  client_id uuid references clients(id) on delete cascade,
  document_name text not null,
  deadline date,
  status text not null default 'Pending',
  follow_up_date date,
  client_reply text,
  created_at timestamptz not null default now()
);

alter table document_requests enable row level security;
drop policy if exists "document_requests_v1_read" on document_requests;
create policy "document_requests_v1_read" on document_requests for select using (true);
drop policy if exists "document_requests_v1_write" on document_requests;
create policy "document_requests_v1_write" on document_requests for all using (true) with check (true);

create table if not exists reminder_messages (
  id uuid primary key default gen_random_uuid(),
  user_id uuid,
  client_id uuid references clients(id) on delete cascade,
  message_text text not null,
  generated_at timestamptz not null default now(),
  message_text_source text default 'rule_template',
  message_text_confidence numeric default 1.0,
  message_text_review_status text default 'unreviewed',
  created_at timestamptz not null default now()
);

alter table reminder_messages enable row level security;
drop policy if exists "reminder_messages_v1_read" on reminder_messages;
create policy "reminder_messages_v1_read" on reminder_messages for select using (true);
drop policy if exists "reminder_messages_v1_write" on reminder_messages;
create policy "reminder_messages_v1_write" on reminder_messages for all using (true) with check (true);

insert into team_members (id, name, email) values
  ('a1000000-0000-0000-0000-000000000001', 'Sarah Tan', 'sarah@firm.com'),
  ('a1000000-0000-0000-0000-000000000002', 'James Lim', 'james@firm.com'),
  ('a1000000-0000-0000-0000-000000000003', 'Priya Nair', 'priya@firm.com');

insert into clients (id, name, financial_year_end, service_type, person_in_charge, internal_notes) values
  ('b1000000-0000-0000-0000-000000000001', 'Maple Trading Pte Ltd', '2024-12-31', 'Accounting & GST', 'Sarah Tan', 'Client prefers WhatsApp. Contact Mr. Tan directly.'),
  ('b1000000-0000-0000-0000-000000000002', 'Bright Star Sdn Bhd', '2024-03-31', 'Audit', 'James Lim', 'Documents usually delayed. Send reminder 2 weeks early.'),
  ('b1000000-0000-0000-0000-000000000003', 'Horizon Logistics Pte Ltd', '2024-06-30', 'Payroll & Tax', 'Priya Nair', 'New client from March 2024.'),
  ('b1000000-0000-0000-0000-000000000004', 'Summit Capital Partners', '2024-12-31', 'Corporate Secretarial', 'Sarah Tan', null);

insert into document_requests (client_id, document_name, deadline, status, follow_up_date, client_reply) values
  ('b1000000-0000-0000-0000-000000000001', 'Bank statements Jan–Dec 2024', '2025-02-15', 'Waiting for Client', '2025-01-28', null),
  ('b1000000-0000-0000-0000-000000000001', 'Sales invoices Q4 2024', '2025-02-15', 'Pending', null, null),
  ('b1000000-0000-0000-0000-000000000001', 'GST F5 supporting schedules', '2025-02-15', 'Partially Received', '2025-01-20', 'Sent partial docs on 18 Jan'),
  ('b1000000-0000-0000-0000-000000000002', 'Audited financial statements FY2024', '2025-01-31', 'Waiting for Client', '2025-01-22', null),
  ('b1000000-0000-0000-0000-000000000002', 'Fixed asset register', '2025-01-31', 'Pending', null, null),
  ('b1000000-0000-0000-0000-000000000003', 'CPF contribution records Jul–Dec 2024', '2025-02-10', 'Received', null, 'Submitted via email 15 Jan'),
  ('b1000000-0000-0000-0000-000000000003', 'Employee payslips Jul–Dec 2024', '2025-02-10', 'In Review', null, null),
  ('b1000000-0000-0000-0000-000000000004', 'Signed director resolutions 2024', '2025-03-01', 'Pending', null, null),
  ('b1000000-0000-0000-0000-000000000004', 'Shareholding register update', '2025-03-01', 'Pending', null, null);