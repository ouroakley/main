# Organiser Hugo modules vs taxonomy terms

Reference for aligning **`main/content/organisers/<slug>/`** (taxonomy terms) with **`module.imports`** in [`hugo.yaml`](../hugo.yaml) and real repos under [`organisers/`](../../organisers/).

## When events live in `organisers/` vs `main`

- **Module-backed organiser:** New events belong under **`organisers/<repo>/content/events/`** so they publish via the mount `content/events/<mount>/` (see [`link-pdf-ingest-rules.md`](link-pdf-ingest-rules.md)).
- **No module:** Keep events under **`main/content/events/`** until a new `github.com/ouroakley/organiser-*` repo exists, **`hugo.yaml`** mounts are added, and (if you want a Decap card) the slug is listed in `params.organiser_cms_slugs` ([`organiser-cms-slugs.md`](organiser-cms-slugs.md)).

## Moving existing events off `main`

Only move **`main/content/events/...`** into an organiser repo when **both** are true:

1. The event’s **`organisers:`** front matter includes a slug that has **`target: content/events/<slug>/`** under `module.imports` in [`hugo.yaml`](../hugo.yaml).
2. There is a matching **git checkout** under [`organisers/`](../../organisers/) (e.g. `go.mod` at `organisers/<repo>/go.mod`) so the change can be committed in the correct repository.

If either is missing, leave the event on **`main`** until the organiser is bootstrapped.

**May 2026 village-hall timetable bundles** where **`organisers:`** is only **`oakley-village-hall`** or **`east-oakley-village-hall`** now live under [`organisers/oakley-village-hall/content/events/`](../../organisers/oakley-village-hall/content/events/) and [`organisers/east-oakley-village-hall/content/events/`](../../organisers/east-oakley-village-hall/content/events/) respectively (same monthly `eventDates` shape and public URLs as before). Events whose organiser is another term (e.g. **`coffee-and-chat`**, **`louise-wesley`**) stay on **`main`** even when the venue is a hall.

**Folder names vs mounts:** The directory under `organisers/` is not always identical to the taxonomy slug. Examples: taxonomy `friends-ois` → repo `organisers/friends-of-oakley-infant-school/`; taxonomy `oakley-fc` → repo `organisers/oakley-football-club/`. Always follow the **`content/events/<mount>/`** segment from `hugo.yaml`, not guesswork from the slug alone.

## Taxonomy slugs with **no** events module yet

These have a page under [`main/content/organisers/`](../content/organisers/) but **no** `module.imports` mount to `content/events/<slug>/` in [`hugo.yaml`](../hugo.yaml). Add a new organiser repo + mounts (and usually `organiser_cms_slugs`) if you want the same authoring model as ODPC, Jolly Olly’s, etc.

| Slug | Notes |
|------|--------|
| `tops` | |
| `oakley-community-care` | |
| `watership-down-health` | Often intentionally **main-only** (e.g. PPG clinics); see [`link-may-2026-ingest-appendix.md`](link-may-2026-ingest-appendix.md). |
| `louise-wesley` | |
| `coffee-and-chat` | |
| `the-fox-inn` | |
| `the-beach-arms` | |
| `oakley-neighbourhood-watch` | |
| `craft-kits-n-bits` | |
| `alex-rowley` | |
| `example-organiser` | Demo taxonomy term. The **organiser-example** module mounts under segment **`example`**, not `example-organiser`; see [`organiser-cms-slugs.md`](organiser-cms-slugs.md). |

## Slugs that **are** module-backed (events mount exists)

These map to `content/events/<slug>/` in [`hugo.yaml`](../hugo.yaml) (plus the **`example`** mount for the template organiser, which uses mount slug `example`):

`oakley-fc`, `oakley-stitchers-cic`, `oakley-wellbeing-forum`, `oca`, `odpc`, `oww`, `ramblers-wellbeing-walks-basingstoke`, `oakley-cc`, `the-barley-mow`, `ojsa`, `friends-ois`, `the-methodist-church`, `oakley-deane-wi`, `oakley-bc`, `oakley-ramblers`, `oakley-gardening-club`, `jolly-ollys`, `oakley-afternoon-wi`, `oakley-woodlands-group`, `oakley-mens-shed`, `east-oakley-village-hall`, `oakley-village-hall`, `example`.

## What always stays on `main` regardless of modules

- **[`main/content/organisers/<slug>/_index.md`](../content/organisers/)** — Organiser **taxonomy term** pages for the aggregate site (title, `allowed_editors`, etc.). Do not “move” these into organiser repos only; the public `/organisers/<slug>/` term still lives here.
- **[`main/content/venues/<key>/_index.md`](../content/venues/)** — **Venue taxonomy** terms used by `venues:` in event front matter across the whole site.

Optional organiser-specific supplements use **`content/venues-info/`** inside the organiser repo (mounted as `content/venues-info/<slug>/`); see [`link-pdf-ingest-rules.md`](link-pdf-ingest-rules.md) and ODPC’s `venues-info` examples.

## See also

- [`organiser-bootstrap-backlog.md`](organiser-bootstrap-backlog.md) — main-only / pending repo slugs (working checklist).
- [`link-pdf-ingest-rules.md`](link-pdf-ingest-rules.md) — filing rules and `MISSING_ORGANISER_MODULE` comment.
- [`organiser-cms-slugs.md`](organiser-cms-slugs.md) — `/admin/` hub list vs `module.imports`.
- [`README.md`](../README.md) — Hugo modules / adding an organiser.
