-- Migration for existing databases: adds the email_summary field and the
-- 'no_response' stage. Run once in the Supabase SQL editor. Fresh installs
-- just run schema.sql and skip this file.

alter table leads add column if not exists email_summary text;

-- The stage check constraint must be recreated to allow the new value.
alter table leads drop constraint if exists leads_stage_check;
alter table leads add constraint leads_stage_check
  check (stage in ('reached_out', 'responded', 'follow_up', 'no_response', 'closed'));
