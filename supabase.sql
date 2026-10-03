-- Days: cumpleaños, citas, eventos y recordatorios (mismo proyecto de Supabase que las otras apps).
create table if not exists public.dy_events (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references auth.users(id) on delete cascade,
  kind text not null check (kind in ('birthday','appointment','event','reminder')),
  title text not null,
  notes text,
  date date not null,
  time text,                                  -- 'HH:MM' o null (todo el día)
  repeat text not null default 'none' check (repeat in ('none','yearly','monthly','weekly')),
  born_year int,                              -- cumpleaños: para saber cuántos cumple
  alerts jsonb not null default '[]',         -- [{d:1,t:'20:00'} = 1 día antes a las 8 pm, {m:120} = 2 horas antes]
  sent jsonb not null default '{}',           -- avisos ya enviados (lo usa el servidor)
  done boolean not null default false,
  created_at timestamptz not null default now()
);
create index if not exists dy_events_user on public.dy_events(user_id);
alter table public.dy_events enable row level security;
drop policy if exists dy_events_own on public.dy_events;
create policy dy_events_own on public.dy_events for all using (auth.uid() = user_id) with check (auth.uid() = user_id);
