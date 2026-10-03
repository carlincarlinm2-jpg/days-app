# Days

Calendario personal (PWA): cumpleaños, citas, eventos y recordatorios, con captura por voz y avisos al celular.

- Datos: Supabase, tabla `dy_events` (ver `supabase.sql`), misma cuenta que Nutri, Ritmo y North.
- Avisos: servidor de Ritmo (`hola-ritmo.vercel.app/api/tick`).
- Voz: `speech-parser.js` (sin IA de pago). Sonidos: `sounds.js`.
