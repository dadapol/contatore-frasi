# Contatore frasi

Sito con login per contare le frasi di P e A.
I conteggi di "Oggi" ripartono da zero a mezzanotte, ma ogni inserimento resta salvato su Supabase.
Nella scheda "Report" ci sono grafico e storico.

File:
- `index.html`: il sito
- `config.js`: indirizzo e chiave del tuo progetto Supabase
- `schema.sql`: tabella e regole di accesso

## 1. Database (Supabase)

Il progetto `contatore-frasi` (regione eu-central-1) è già creato, con la tabella e le regole di `schema.sql`.
`config.js` contiene già indirizzo e chiave pubblica.

Da fare nella dashboard di Supabase:
1. **Authentication** > **Sign In / Providers**: **disattiva** "Allow new users to sign up".
2. **Authentication** > **Users** > **Add user** > **Create new user**: email e password per ogni collega, con "Auto Confirm User".

Non mettere mai la chiave `service_role` nel sito: quella resta segreta.

## 2. Pubblica su GitHub Pages

1. Crea un nuovo repository su GitHub, per esempio `contatore-frasi`.
2. Carica i file `index.html`, `config.js`, `schema.sql`, `README.md`
   (**Add file** > **Upload files**).
3. Apri **Settings** > **Pages**. In "Source" scegli **Deploy from a branch**, branch `main`, cartella `/ (root)`, poi **Save**.
4. Dopo un minuto il sito è su `https://<tuo-utente>.github.io/contatore-frasi/`.
5. In Supabase, **Authentication** > **URL Configuration**: metti questo indirizzo in "Site URL".

Su iPhone: apri il sito in Safari, Condividi > "Aggiungi alla schermata Home".

## Note

- Il sito è pubblico, ma senza login non si vede nessun dato.
- Ogni utente con login può aggiungere e togliere conteggi. Il `−` toglie l'ultimo inserimento di oggi per quella frase.
- Il "giorno" è quello del telefono di chi inserisce.
- Il report mostra fino a 90 giorni. I dati più vecchi restano nel database (Supabase > Table Editor > `events`).
- Un progetto Supabase gratuito va in pausa dopo 7 giorni senza uso. Si riattiva dalla dashboard di Supabase.
