# GTM Board

A lightweight, single-file sales pipeline board for small teams. Track leads through five stages, collaborate in real time, and never lose touch with a prospect — no build step, no framework, just `index.html` plus Supabase.

- **Live demo / app**: `index.html`
- **Stack**: Vanilla HTML/JS/CSS + [Supabase](https://supabase.com)
- **Deployment**: Any static host (Netlify, Vercel, or your own server)

---

## Features

- **Kanban pipeline**: `Reached out → Responded → Follow-up → No response → Closed`.
- **Drag-and-drop** cards between stages.
- **Live sync** across users via Supabase real-time subscriptions.
- **Today strip**: a work queue of overdue, due-today, and stale leads.
- **Smart quick-add**: paste a multi-line list to bulk-create leads, or paste an email / LinkedIn URL to auto-fill those fields.
- **Per-lead drawer**: company, email, LinkedIn, email summary, next-action date, tier, notes.
- **Forced close reasons**: closing a deal requires Won/Lost and a lost reason, so pipeline data stays clean.
- **Staleness & overdue warnings**: configurable stale threshold (`STALE_DAYS`), red overdue dates.
- **Filters & search**: owner filter, Bangkok trip tag, live name search.
- **Badges**: business closed, not relevant, tier, and 🌴 Bangkok trip.
- **Append-only notes** with automatic author timestamps.

---

## Quick start (~10 minutes)

1. **Create a Supabase project** at https://supabase.com (free tier works fine).
2. **Run the schema**: open the Supabase SQL Editor, paste `gtm-board/schema.sql`, and run it.
3. **Create users**: go to *Authentication → Users → Add user → Create new user*. Add each team member, tick **Auto confirm user**, and optionally disable public sign-ups under *Authentication → Sign In / Up*.
4. **Add your keys**: under *Project settings → API*, copy the **Project URL** and **anon public** key into the top of the `<script>` block in `index.html`:

   ```js
   const SUPABASE_URL = "https://xxxx.supabase.co";
   const SUPABASE_ANON_KEY = "eyJ...";
   ```

   The anon key is safe to ship in HTML because Row Level Security restricts access to logged-in users only.
5. **Open `index.html`** in a browser and sign in.

---

## Deployment

Any static host works:

| Host | What to upload |
|------|----------------|
| **Netlify** | Drag the `gtm-board` folder onto [Netlify Drop](https://app.netlify.com/drop). `_redirects` handles SPA routing. |
| **Vercel** | Deploy `index.html` and `vercel.json` together; `vercel.json` rewrites all paths to `index.html`. |
| **Other** | Upload `index.html` and add a catch-all rewrite rule so `/login` and `/pipeline` resolve to `index.html`. |

The app uses two client-side routes:

- `/login` — sign-in screen
- `/pipeline` — the board

---

## Using the board

- **Quick-add** at the top of *Reached out*: type a name and press Enter; the input stays focused for rapid entry.
- **Today strip** above the board lists overdue, due-today, and stale leads — work it left to right.
- **"N added today"** badge in *Reached out* counts every lead created today, regardless of current stage or owner.
- **Drag cards** between columns; after each drop or note edit, a one-tap prompt sets the next touch date.
- **Click a card** to open the drawer and edit fields, add notes, change stage, set tier, or flag closed / not relevant / Bangkok trip.
- **Email summaries** pop open first when a lead has one; close it to reach the drawer. The drawer’s *Read ↗* link reopens the summary.
- **Top-bar counters** (overdue / stale / won this month) are tappable filters.
- **Search** matches anywhere in the lead name, case-insensitively, live against Supabase.

---

## Upgrading an existing database

New fields are added through migration files in `gtm-board/migrate-*.sql`. Run only the files you have not run yet, in filename order, once each in the Supabase SQL editor.

---

## File layout

```
.
├── index.html          # The entire app (no build step)
├── vercel.json         # Vercel SPA rewrite rule
├── _redirects          # Netlify SPA rewrite rule
├── README.md           # This file
└── gtm-board/
    ├── schema.sql      # Initial Supabase schema
    └── migrate-*.sql   # Incremental migrations
```

---

## Customizing

- `STALE_DAYS` in the script controls when a card is flagged as stale.
- The "Bangkok trip" tag and tier dropdown can be extended with additional migrations and matching UI in `index.html`.
