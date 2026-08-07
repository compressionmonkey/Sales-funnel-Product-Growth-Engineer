# Sales-funnel-Product-Growth-Engineer
# GTM board

A single-file sales pipeline board for a small team. Five columns
(Reached out → Responded → Follow-up → No response → Closed),
drag-and-drop, notes per lead, staleness warnings, and live sync
between users via Supabase.

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

The app routes the login screen to `/login` and the board to `/pipeline`.
For those URLs to survive a page refresh, the host must rewrite all paths
to `index.html` — the included `_redirects` file does this on Netlify and
`vercel.json` does it on Vercel (deploy them alongside `index.html`). On
other servers, add an equivalent catch-all rewrite rule.

## How the flow works

- **Quick-add** at the top of *Reached out*: type a name and press
  Enter — the input stays focused so you can add several in a row.
  Paste a multi-line list to create one card per line; pasting an email
  or LinkedIn URL fills that field automatically.
- The **Today strip** above the board is the work queue: every card
  that is overdue, due today, or stale, worked left to right. When it's
  empty, you're done for the day.
- **Drag cards** between columns as the deal progresses. After every
  drag (and every note), a **next-action prompt** offers one-tap dates
  (tomorrow / 3 days / next week) so no card is left without a next touch.
- Dropping a card into **Closed** forces a Won/Lost choice; a lost deal
  asks for the reason (price, timing, not a fit…). This is deliberate —
  it's the only way to close a card, so the data always gets captured.
- **Click a card** to open the drawer: change its stage, edit company,
  contact email, LinkedIn, what your email said, next action date, and
  add timestamped notes. Notes are append-only and stamped with the
  author automatically.
- **No response** is a parking lot for leads that went quiet — cards
  there skip the staleness warning and only resurface through their
  next action date.
- **Counters** in the top bar (overdue / stale / won this month) —
  tap one to spotlight those cards on the board.
- Cards with **no activity for 3 days** get an amber border and a
  "no touch in N days" warning (change `STALE_DAYS` in the script).
- Cards whose **next action date** has passed show it in red as overdue.
- Everyone sees the whole board; the **owner filter** narrows it to one
  person's cards when needed.
- Changes sync live — when one of you moves a card, the other sees it
  without refreshing.

Upgrading an existing database? Run the `gtm-board/migrate-*.sql` files
you haven't run yet, in filename order, once each in the Supabase SQL
editor.
