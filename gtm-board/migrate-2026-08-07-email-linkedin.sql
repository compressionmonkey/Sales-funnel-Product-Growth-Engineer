-- Migration for existing databases: contact/wanted -> email/linkedin.
-- Run once in the Supabase SQL editor. Fresh installs just run schema.sql
-- and skip this file.

alter table leads add column if not exists email text;
alter table leads add column if not exists linkedin text;

-- Carry over old contact values into whichever new field they look like.
update leads set email = contact
  where email is null and contact like '%@%' and contact not ilike '%linkedin%';
update leads set linkedin = contact
  where linkedin is null and contact ilike '%linkedin%';

alter table leads drop column if exists contact;
alter table leads drop column if exists wanted;
