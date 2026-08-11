-- Run once in Supabase SQL Editor — edit history so nothing is ever
-- permanently overwritten without a way back

create table if not exists prep_edit_history (
  id uuid primary key default gen_random_uuid(),
  table_name text not null,
  record_id text not null,
  snapshot jsonb not null,
  label text,
  snapshot_at timestamptz not null default now()
);

create index if not exists prep_edit_history_lookup_idx on prep_edit_history (table_name, record_id, snapshot_at desc);

alter table prep_edit_history enable row level security;

create policy "anon full access" on prep_edit_history
  for all
  using (true)
  with check (true);

grant usage on schema public to anon;
grant select, insert, update, delete on prep_edit_history to anon;
