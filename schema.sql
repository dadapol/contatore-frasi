-- Contatore frasi: tabella e regole di accesso.
-- Incolla tutto in Supabase > SQL Editor > New query, poi premi Run.

create table if not exists public.events (
  id          bigint generated always as identity primary key,
  person      text not null check (person in ('Patrizia', 'Annalisa')),
  phrase      text not null,
  day         date not null,                          -- giorno locale (Europe/Rome) in cui è stata detta
  created_at  timestamptz not null default now(),
  created_by  uuid not null default auth.uid() references auth.users(id),
  created_by_email text default (auth.jwt() ->> 'email')
);

create index if not exists events_day_idx on public.events (day);

alter table public.events enable row level security;

-- Solo utenti con login possono leggere, aggiungere e togliere conteggi.
drop policy if exists "leggi se loggato" on public.events;
create policy "leggi se loggato" on public.events
  for select to authenticated using (true);

drop policy if exists "aggiungi se loggato" on public.events;
create policy "aggiungi se loggato" on public.events
  for insert to authenticated with check (created_by = (select auth.uid()));

drop policy if exists "togli se loggato" on public.events;
create policy "togli se loggato" on public.events
  for delete to authenticated using (true);

-- Aggiornamenti in tempo reale tra colleghi.
alter table public.events replica identity full;
do $$ begin
  alter publication supabase_realtime add table public.events;
exception when duplicate_object then null; end $$;
