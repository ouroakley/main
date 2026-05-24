# Link magazine PDF → Our Oakley events (extract rules)

Operational notes for translating *Link* issues into Hugo event pages.

**Which organisers have Hugo modules:** see [`organiser-modules-and-taxonomy.md`](organiser-modules-and-taxonomy.md) (taxonomy slugs vs `hugo.yaml` mounts, and when to keep events on `main`).

## Where events are authored (filing under `/organisers`)

**Primary rule:** Save new event markdown under **the organising group’s Hugo module tree** in this workspace:

`organisers/<organiser-folder>/content/events/<event-slug>/index.md`

Examples of real paths:

- `organisers/the-methodist-church/content/events/coffee-morning-april-28-2026/index.md`
- `organisers/odpc/content/events/coffee-and-chat-march-5-2026/index.md`

**How to pick `<organiser-folder>`:** Match the **`module.imports` mount segment** used in [`main/hugo.yaml`](../hugo.yaml) (e.g. mount target `content/events/oakley-deane-wi` → folder `organisers/oakley-deane-wi`). The **`organisers:`** taxonomy in front matter should include that organiser **at minimum** so ownership matches the filesystem.

**Naming `<event-slug>`:** Prefer **existing patterns** beside other events in the same organiser folder (typically kebab-case, sometimes with a calendar fragment for one-offs). Tier B (**multi-`eventDates`**) uses **one** directory + **one** `index.md` for that repeating activity—not one folder per recurrence.

**When there is no organiser module:** If the logical host appears only as a taxonomy term on the main site (**no** repo under [`organisers/`](../../organisers/) and **no** matching `module.imports` mount), fall back temporarily to **`main/content/events/<slug>/<date>/index.md`** (same pattern already used site-wide). Call this out explicitly as **`<!-- MISSING_ORGANISER_MODULE: … -->`** so we can split it into the right submodule later.

**Village halls — unclear hirer:** If *Link* only lists an Andover Road or Green Hut **timetable slot** and no named group, assign the **`organisers:`** taxonomy to the venue’s **hall organiser** term (**`oakley-village-hall`** or **`east-oakley-village-hall`**) with a matching taxonomy page under [`main/content/organisers/`](../content/organisers/). Publish the Markdown under **`main/content/events/`** (there is typically no Hugo module per hall).

> **Event titles:** use a **short activity `title`** when **`venues`** and **`eventDates`** carry place and schedule. **Do not** repeat venue, day-of-week, or clock times in the Markdown **body**—use body only for booking contacts, caveats not expressible in front matter, or links.

> **Green Hut (East Oakley Village Hall):** In event `body`, point readers to **[http://www.oakleygreenhut.co.uk/](http://www.oakleygreenhut.co.uk/)** for bookings and current hall information rather than duplicating phone/email from *Link*.

**Built site reminder:** Modules are mounted under `main` as `content/events/<mount>/`; authoring in `organisers/<name>/content/events/` maps to unified `/events/…` URLs after `hugo`.

## Link page numbers in front matter (`params`)

Include **printed magazine PDF page numbers** in **metadata**, not only in comments.

Use nested **`params.link`**:

```yaml
params:
  link:
    issue: May 2026
    pdfPages:
      - 10
```

- **`issue`:** Issue label from the magazine (e.g. **May 2026**).
- **`pdfPages`:** Sorted list of **1-based page numbers** as in the footer (`-- N of 40 --`). Use **multiple** entries when prose spans pages or when fragments on different pages support the same event. **Tier B** items from one column: normally the starting page unless additional pages materially extend it—then list **all** pages used.

`**# source:** …` markdown comments remain optional for copy-pasta in chat; **`params.link`** is authoritative for the repo.

**CMS note:** [`static/admin/main/config.yml`](../static/admin/main/config.yml) does not declare these widgets today; Hugo still reads YAML from markdown. Editors can add CMS fields later or rely on manual front matter.

## Datetimes — omit timezones

Use naive `YYYY-MM-DDTHH:mm:ss` (no `Z`, no offsets, no TZ field). Match existing published events (`organisers/**/content/events/**/index.md` or [`main/content/events`](../content/events/) fallback).

## Geography

**Oakley only** unless scope is revised: emit YAML only for happenings at Oakley venues / Oakley-hosted instances; retain a separate audit list for excluded non‑Oakley items.

## Tier A vs Tier B

- **Tier A:** Separate events for unrelated happenings (do not merge).
- **Tier B:** Same repeating activity → **one** Hugo event with **multiple** `eventDates` entries.

## Three-pass review

1. Obvious dated lines  
2. Implicit / recurring (“Nth weekday”, bank holidays, “see page …”)  
3. Coverage audit vs contents + every PDF page numbered 1–40  

## Missing taxonomy

Flag `MISSING_VENUE` / `MISSING_ORGANISER` in notes when no [`content/venues`](../content/venues/) or [`content/organisers`](../content/organisers/) slug exists.

## Runs

- **[link-may-2026-ingest-appendix.md](link-may-2026-ingest-appendix.md)** — Oakley-only exclusions and filing notes after the May 2026 *Link* pass.
