-- Run once in Supabase SQL Editor — adds the Notes feature

create table if not exists prep_notes (
  id uuid primary key default gen_random_uuid(),
  location text not null check (location in ('westmont','darien')),
  note text not null,
  created_by text,
  created_at timestamptz not null default now()
);

alter table prep_notes enable row level security;

create policy "anon full access" on prep_notes
  for all
  using (true)
  with check (true);

grant usage on schema public to anon;
grant select, insert, update, delete on prep_notes to anon;
