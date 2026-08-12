-- Adds a lead tier (Tier 1 / Tier 2 / Tier 3), set from a dropdown in the drawer.
-- Run once in the Supabase SQL editor.

alter table leads add column if not exists tier text
  check (tier in ('tier_1', 'tier_2', 'tier_3'));
