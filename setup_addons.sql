-- Run once in Supabase SQL Editor — adds add-on orders + delivery tracking

alter table prep_counts add column if not exists delivered jsonb not null default '{}'::jsonb;

create table if not exists darien_addons (
  id uuid primary key default gen_random_uuid(),
  week_label text not null,
  created_at timestamptz not null default now(),
  requested_by text,
  items jsonb not null default '{}'::jsonb,      -- {item_id: quantity requested}
  delivered jsonb not null default '{}'::jsonb,  -- {item_id: quantity delivered so far}
  status text not null default 'open' check (status in ('open','fulfilled'))
);

alter table darien_addons enable row level security;

create policy "anon full access" on darien_addons
  for all
  using (true)
  with check (true);

grant usage on schema public to anon;
grant select, insert, update, delete on darien_addons to anon;
