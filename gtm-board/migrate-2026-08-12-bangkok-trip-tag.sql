-- Adds a free-text tag to leads, used for the "Bangkok trip" filter button.
-- Run once in the Supabase SQL editor.

alter table leads add column if not exists tag text;
