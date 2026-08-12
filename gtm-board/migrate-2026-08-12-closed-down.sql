-- Flags a lead whose business has shut down, set from a checkbox in the drawer.
-- Run once in the Supabase SQL editor.

alter table leads add column if not exists is_closed_down boolean not null default false;
