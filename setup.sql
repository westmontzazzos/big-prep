-- Run once in Supabase SQL Editor for the Big Prep app

create table if not exists prep_counts (
  id uuid primary key default gen_random_uuid(),
  location text not null check (location in ('westmont','darien')),
  week_label text not null,
  counter_name text not null,
  counts jsonb not null default '{}'::jsonb,
  status text not null default 'in_progress' check (status in ('in_progress','completed')),
  started_at timestamptz not null default now(),
  completed_at timestamptz
);

create index if not exists prep_counts_location_status_idx
  on prep_counts (location, status, started_at desc);

alter table prep_counts enable row level security;

create policy "anon full access" on prep_counts
  for all
  using (true)
  with check (true);

grant usage on schema public to anon;
grant select, insert, update, delete on prep_counts to anon;
