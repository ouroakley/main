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

## Hugo module pin vs `organisers/` checkout

The Our Oakley Hugo build resolves organiser content from **`go.mod`** / **`hugo mod`** only (there is no `replace` pointing at [`../../organisers/`](../../organisers/)). **Committed** [`go.mod`](../go.mod) keeps each organiser on version **`main`** (`… main // indirect`). **[`bin/resolve-organiser-requires-to-tip-of-main.sh`](../bin/resolve-organiser-requires-to-tip-of-main.sh)** expands those lines to pseudo-versions for the current tip of each repo’s **`main`** only while **`hugo`** runs (see **[`bin/build.sh`](../bin/build.sh)** and **[`bin/hugo-with-local-workspace.sh`](../bin/hugo-with-local-workspace.sh)**). Running plain **`hugo`** without that wrapper can still rewrite `go.mod` when fetching; in the full monorepo layout use a gitignored **`go.work`**, **[`bin/go-work-local.sh`](../bin/go-work-local.sh)** to refresh it, and **[`bin/hugo-with-local-workspace.sh`](../bin/hugo-with-local-workspace.sh)** (or **`HUGO_MODULE_WORKSPACE`**) so local dev does not keep churning the committed file. See [README — Local monorepo dev](../README.md#local-monorepo-dev-main--organisers). [`scripts/new-organiser.sh`](../../scripts/new-organiser.sh) runs `go-work-local.sh` after updating `hugo.yaml` when `../organisers` exists.

Files you edit under **`organisers/<repo>/`** appear on **www.ouroakley.uk** only after they are **pushed** to the matching `github.com/ouroakley/organiser-*` repo so that **`main`** on that repo includes them (no separate `go.mod` bump is required for routine content pushes when the aggregate repo keeps **`main`** tokens). If `organisers/` is ahead of what is on GitHub, events can exist locally but not in CI or production builds.

## Git: `public` branch vs `public/` directory

The site output directory is named **`public/`**, which makes **`git log public`** ambiguous (Git treats it as a path). Use explicit refs, e.g. **`git log refs/remotes/origin/public`** for the deployment branch history (typically “Build: … UTC” commits). Local **`refs/heads/public`** may be unrelated or stale if it was never fast-forwarded from **`origin/public`**.

## `go.mod` organiser `require` lines

In the committed [`go.mod`](../go.mod), every `github.com/ouroakley/organiser-*` dependency uses version **`main`** (`… main // indirect`). **`go mod tidy`**, **`go mod download`**, and plain **`hugo`** may still rewrite those lines locally to pseudo-versions; restore the **`main`** lines before committing, or use **[`bin/hugo-with-local-workspace.sh`](../bin/hugo-with-local-workspace.sh)** (which runs **[`bin/resolve-organiser-requires-to-tip-of-main.sh`](../bin/resolve-organiser-requires-to-tip-of-main.sh)** around Hugo) in the monorepo layout. Convention and rationale: [README — Hugo modules and go.mod](../README.md#hugo-modules-and-gomod).

If a **git pre-commit hook** reformats `go.mod` and drops the **`main`** version field (invalid `require` lines), fix and amend or follow up with a small commit before pushing; **`git show HEAD:go.mod`** should show **`main // indirect`** on every organiser line.

## See also

- [`organiser-bootstrap-backlog.md`](organiser-bootstrap-backlog.md) — main-only / pending repo slugs (working checklist).
- [`link-pdf-ingest-rules.md`](link-pdf-ingest-rules.md) — filing rules and `MISSING_ORGANISER_MODULE` comment.
- [`organiser-cms-slugs.md`](organiser-cms-slugs.md) — `/admin/` hub list vs `module.imports`.
- [`README.md`](../README.md) — Hugo modules / adding an organiser.
