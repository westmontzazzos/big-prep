-- Run once in Supabase SQL Editor — tracks WHEN each item was picked up,
-- not just that it was

alter table prep_counts add column if not exists delivered_at jsonb not null default '{}'::jsonb;
alter table darien_addons add column if not exists delivered_at jsonb not null default '{}'::jsonb;
