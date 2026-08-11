-- Run once in Supabase SQL Editor — Daily On-Hand, completely separate from
-- the weekly Sunday order system (prep_counts). One row per calendar day.

create table if not exists darien_daily_onhand (
  id uuid primary key default gen_random_uuid(),
  date date not null unique,
  counts jsonb not null default '{}'::jsonb,
  updated_by text,
  updated_at timestamptz not null default now()
);

alter table darien_daily_onhand enable row level security;

create policy "anon full access" on darien_daily_onhand
  for all
  using (true)
  with check (true);

grant usage on schema public to anon;
grant select, insert, update, delete on darien_daily_onhand to anon;
