# Sales-funnel-Product-Growth-Engineer
# GTM board

A single-file sales pipeline board for a small team. Four columns
(Reached out → Responded → Follow-up → Closed), drag-and-drop, notes
per lead, staleness warnings, and live sync between users via Supabase.

No build step, no framework — `index.html` is the whole app.

## Setup (one time, ~10 minutes)

1. **Create a Supabase project** at https://supabase.com (free tier is fine).

2. **Run the schema**: in the Supabase dashboard, open *SQL Editor*,
   paste the contents of `schema.sql`, and run it.

3. **Create the two users**: go to *Authentication → Users → Add user →
   Create new user*. Enter each person's email and a password, and tick
   **Auto confirm user** so no confirmation email is needed.
   (Optional hardening: under *Authentication → Sign In / Up*, disable
   public sign-ups so only accounts you create can log in.)

4. **Paste your keys**: in the dashboard under *Project settings → API*,
   copy the *Project URL* and the *anon public* key, and paste them into
   the two constants at the top of the `<script>` block in `index.html`:

   ```js
   const SUPABASE_URL = "https://xxxx.supabase.co";
   const SUPABASE_ANON_KEY = "eyJ...";
   ```

   The anon key is safe to ship in the HTML — it only grants what the
   row-level security policies allow, which is "logged-in users only".

5. **Open `index.html`** in a browser and sign in. That's it.

## Sharing it with your salesman

Any static hosting works. Easiest options:

- **Netlify Drop** (https://app.netlify.com/drop): drag the `gtm-board`
  folder onto the page, get a URL, share it.
- Or upload `index.html` to any web server you already have.

## How the flow works

- **+ Add lead** creates a card in *Reached out*, owned by whoever is
  logged in.
- **Drag cards** between columns as the deal progresses.
- Dropping a card into **Closed** forces a Won/Lost choice; a lost deal
  asks for the reason (price, timing, not a fit…). This is deliberate —
  it's the only way to close a card, so the data always gets captured.
- **Click a card** to open the drawer: edit what they want, contact,
  next action date, and add timestamped notes. Notes are append-only
  and stamped with the author automatically.
- Cards with **no activity for 3 days** get an amber border and a
  "no touch in N days" warning (change `STALE_DAYS` in the script).
- Cards whose **next action date** has passed show it in red as overdue.
- The **owner filter** in the top bar shows one person's cards.
- Changes sync live — when one of you moves a card, the other sees it
  without refreshing.
