-- Run once in Supabase SQL Editor — tracks when Darien's on-hand was last updated

alter table prep_counts add column if not exists onhand_updated_at timestamptz;
