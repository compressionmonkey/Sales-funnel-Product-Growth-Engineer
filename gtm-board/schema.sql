-- GTM board schema — run this once in the Supabase SQL editor.

create table if not exists leads (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  email text,
  linkedin text,
  email_summary text,
  tag text,
  stage text not null default 'reached_out'
    check (stage in ('reached_out', 'responded', 'follow_up', 'no_response', 'closed')),
  owner text not null,
  next_action date,
  outcome text check (outcome in ('won', 'lost')),
  lost_reason text,
  created_at timestamptz not null default now(),
  last_activity timestamptz not null default now()
);

create table if not exists notes (
  id uuid primary key default gen_random_uuid(),
  lead_id uuid not null references leads(id) on delete cascade,
  author text not null,
  body text not null,
  created_at timestamptz not null default now()
);

-- Any logged-in user (i.e. the two of you) can do everything.
alter table leads enable row level security;
alter table notes enable row level security;

create policy "authenticated_all_leads" on leads
  for all to authenticated using (true) with check (true);

create policy "authenticated_all_notes" on notes
  for all to authenticated using (true) with check (true);

-- Live updates: when one of you moves a card, the other sees it without refreshing.
alter publication supabase_realtime add table leads;
alter publication supabase_realtime add table notes;
