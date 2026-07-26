-- Run once in Supabase SQL Editor — adds Darien order acknowledgment tracking

alter table prep_counts add column if not exists acknowledged boolean not null default false;
alter table prep_counts add column if not exists acknowledged_at timestamptz;
