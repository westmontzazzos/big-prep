-- Run once in Supabase SQL Editor — activity log, one thread per order

create table if not exists order_activity_log (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null,
  week_label text not null,
  event_type text not null,
  description text not null,
  actor_name text,
  created_at timestamptz not null default now()
);

create index if not exists order_activity_log_order_idx on order_activity_log (order_id, created_at);

alter table order_activity_log enable row level security;

create policy "anon full access" on order_activity_log
  for all
  using (true)
  with check (true);

grant usage on schema public to anon;
grant select, insert, update, delete on order_activity_log to anon;
