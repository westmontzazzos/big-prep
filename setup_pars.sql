-- Run once in Supabase SQL Editor (same place as before) for Big Prep's par levels

create table if not exists item_pars (
  location text not null check (location in ('westmont','darien')),
  item_id text not null,
  par numeric not null default 0,
  updated_at timestamptz not null default now(),
  primary key (location, item_id)
);

alter table item_pars enable row level security;

create policy "anon full access" on item_pars
  for all
  using (true)
  with check (true);

grant usage on schema public to anon;
grant select, insert, update, delete on item_pars to anon;
