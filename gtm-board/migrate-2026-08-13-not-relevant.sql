-- Flags a lead that is not relevant, set from a checkbox in the drawer.
-- Run once in the Supabase SQL editor.

alter table leads add column if not exists not_relevant boolean not null default false;
