-- Run once in Supabase SQL Editor — Darien's order verification, separate
-- from Westmont's "picked up" tracking, so mismatches between the two are
-- visible as real discrepancies.

create table if not exists darien_verifications (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null,
  week_label text not null,
  is_correct boolean not null,
  missing_items jsonb not null default '{}'::jsonb,
  verified_by text,
  verified_at timestamptz not null default now()
);

create index if not exists darien_verifications_order_idx on darien_verifications (order_id, verified_at desc);

alter table darien_verifications enable row level security;

create policy "anon full access" on darien_verifications
  for all
  using (true)
  with check (true);

grant usage on schema public to anon;
grant select, insert, update, delete on darien_verifications to anon;
