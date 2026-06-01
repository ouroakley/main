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

**Naming `<event-slug>`:** Prefer **existing patterns** beside other events in the same organiser folder (typically kebab-case, sometimes with a calendar fragment for one-offs).

**Tier B — recurring in the same calendar month:** Use **one** outer content directory per activity per month (e.g. `…-april-2026` or `…-may-2026`) with a **single** `index.md` under the **first occurrence’s** inner date folder (`<yyyy-mm-dd>/index.md`). Put **every** instance that month in one `eventDates` list (sorted chronologically). **Do not** create parallel sibling folders `content/events/<short-slug>/<weekly-date>/` for the same recurring activity in the same month—that pattern is deprecated on `main` (use one monthly bundle + `aliases` if replacing old weekly URLs). **Hall timetable rows:** see [§ Recurring village hall bookings](#recurring-village-hall-bookings-link-timetables) below.

**Hugo `permalink` slug:** For events, the URL’s final segment (`:slug`) comes from the page **`title`** (slugified), not the outer folder name—see hall examples (long folder, short slug). Keep `title` stable when merging weekly files so the canonical URL on the first of the month stays predictable; add `aliases` for superseded weekly paths only.

**When there is no organiser module:** If the logical host appears only as a taxonomy term on the main site (**no** repo under [`organisers/`](../../organisers/) and **no** matching `module.imports` mount), fall back temporarily to **`main/content/events/<slug>/<date>/index.md`** (path shape for the **leaf** file). That does **not** mean “one `<date>` folder per week for the same activity”—for weekly regulars on `main`, use the Tier B monthly bundle above. Call out missing modules explicitly as **`<!-- MISSING_ORGANISER_MODULE: … -->`** so we can split into the right submodule later.

> **Event titles:** use a **short activity `title`** when **`venues`** and **`eventDates`** carry place and schedule. **Do not** repeat venue or day-of-week in the **body**. For hall timetable rows with date-only `eventDates`, put **Morning / Afternoon / Evening** in the body (see hall § below). Otherwise use body only for booking contacts, caveats not expressible in front matter, or links.

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

**Hall timetable exception:** When *Link* lists a slot by **weekday + period** (morning / afternoon / evening) without a reliable clock time, use **date-only** starts (`YYYY-MM-DDT00:00:00`, no `end`) and put the period in the **body**. Do **not** invent clock times for **hirer-unknown** hall rows in organiser repos. Events with **explicit clock times** keep real `start` / `end` in front matter — e.g. meetings/AGMs with “10:30” in prose, woodland walks “10 am”, and **Green Hut Coffee & Chat** (Wednesdays **10:00–12:00** at `east-oakley-village-hall`, organiser **`coffee-and-chat`** on `main` — see below). The calendar treats `T00:00:00` as “no time on chip” ([`calendar-event-cards.md`](calendar-event-cards.md)).

## Geography

**Oakley only** unless scope is revised: emit YAML only for happenings at Oakley venues / Oakley-hosted instances; retain a separate audit list for excluded non‑Oakley items.

## Tier A vs Tier B

- **Tier A:** Separate events for unrelated happenings (do not merge).
- **Tier B:** Same repeating activity → **one** Hugo event with **multiple** `eventDates` entries.

## Recurring village hall bookings (Link timetables)

*Link* often prints a **weekly timetable** for each hall (historically around page 10). Each row is a **Tier B** event: one markdown file per **activity** per **calendar month**, not one file per week.

### Which halls and repos

| Hall | Venue slug | Organiser slug (unknown hirer) | Author in |
|------|------------|-------------------------------|-----------|
| Andover Road Village Hall | `oakley-village-hall` | `oakley-village-hall` | [`organisers/oakley-village-hall/content/events/`](../../organisers/oakley-village-hall/content/events/) |
| East Oakley Village Hall (Green Hut) | `east-oakley-village-hall` | `east-oakley-village-hall` | [`organisers/east-oakley-village-hall/content/events/`](../../organisers/east-oakley-village-hall/content/events/) |

Hall contact numbers from *Link* belong in organiser/venue taxonomy pages or `venues-info`, not duplicated in every event body.

### When the hirer **is** named

If *Link* names the group (e.g. Green Hut **Coffee & Chat** run by **`coffee-and-chat`**), file under **`main/content/events/`** with that organiser slug—even when the venue is a hall. Do not attribute to `oakley-village-hall` / `east-oakley-village-hall` unless the timetable row has no identifiable group.

### Green Hut Coffee & Chat (`coffee-and-chat`)

Named on the Green Hut timetable but filed on **`main`**, not under `organisers/east-oakley-village-hall/`.

| Field | Value |
|-------|--------|
| Path | `main/content/events/coffee-chat-east-oakley-green-hut-wednesdays-morning-<month>-<year>/<first-wednesday-yyyy-mm-dd>/index.md` |
| `title` | `Coffee & Chat` |
| `venues` | `east-oakley-village-hall` |
| `organisers` | `coffee-and-chat` |
| Weekday | All **Wednesdays** in the calendar month |
| `eventDates` | Each Wednesday: `start: …T10:00:00`, `end: …T12:00:00` (naive; **not** date-only) |
| `params.link` | Timetable page (e.g. May/June 2026 **p.10**) |

**Body (required):** two lines — `Wednesdays 10:00–12:00 at East Oakley Village Hall (Green Hut).` then blank line then `See [oakleygreenhut.co.uk](http://www.oakleygreenhut.co.uk/) for bookings and up-to-date hall information.`

**Reference:** [`content/events/coffee-and-chat-april-2026/2026-04-01/index.md`](../content/events/coffee-and-chat-april-2026/2026-04-01/index.md).

**Do not** apply date-only retrofit or “Morning session (Green Hut timetable).” to this series.

### Folder and file shape

Outer directory encodes hall, activity, weekday band, and month:

`organisers/<hall-repo>/content/events/<hall>-<activity>-<weekday>-<month>-<year>/<first-yyyy-mm-dd>/index.md`

Examples:

- `organisers/oakley-village-hall/content/events/oakley-village-hall-pilates-morning-mondays-june-2026/2026-06-01/index.md`
- `organisers/east-oakley-village-hall/content/events/east-oakley-village-hall-chair-yoga-fridays-morning-june-2026/2026-06-05/index.md`
- `main/content/events/coffee-chat-east-oakley-green-hut-wednesdays-morning-june-2026/2026-06-03/index.md`

- **`date`:** first occurrence in that month.
- **`title`:** short activity name only (`Pilates`, `Badminton`, `WI or yoga`)—not the hall name or weekday.
- **`eventDates`:** every instance that month. For **hirer-unknown** hall rows in organiser repos: **date-only** (`start: YYYY-MM-DDT00:00:00`, no `end`) when *Link* gives only a day band; put **Morning / Afternoon / Evening** in the body. **Exception:** Green Hut **Coffee & Chat** on `main` — always **10:00–12:00** each Wednesday (see § Green Hut Coffee & Chat).
- **`venues`** and **`organisers`:** hall slug (see table above) when hirer unknown; named hirers use their organiser slug on `main`.

Date-only pattern reference: [`organisers/oakley-ramblers/content/events/planned-walks-may-2026/index.md`](../../organisers/oakley-ramblers/content/events/planned-walks-may-2026/index.md).

### Shifting dates to a new month

1. Clone the previous month’s bundle (path, title, organiser/venue).
2. Replace `-may-2026` (or similar) with `-june-2026` in the path.
3. Recompute each `eventDates` entry for the target month’s weekdays (e.g. all Mondays in June).
4. **Do not** carry forward clock times from the prior month unless *Link* reprints them—use date-only + period in body. **Exception:** `coffee-chat-east-oakley-green-hut-*` — always carry forward **10:00–12:00** on each Wednesday.
5. Set `params.link.issue` to the **new** issue; use `pdfPages` from the issue that printed the timetable, or the prior issue if carried forward.

**Carry-forward rule (Pass 4):** If the new *Link* issue omits hall timetables but slots are unchanged, still create the new month’s bundles. Add an HTML comment: `<!-- source: carried forward from Link May 2026 p.10 -->`.

**Retrofit:** May 2026 **hirer-unknown** hall bundles in organiser repos were initially filed with estimated clock times. Strip those to date-only + period in body before cloning to later months (see [`link-may-2026-ingest-appendix.md`](link-may-2026-ingest-appendix.md)). **Do not** retrofit `coffee-chat-east-oakley-green-hut-*` on `main` — keep **10:00–12:00**.

### Front matter example

```yaml
---
draft: false
title: Pilates
date: 2026-06-01
eventDates:
  - start: 2026-06-01T00:00:00
  - start: 2026-06-08T00:00:00
  # …remaining Mondays in June
venues:
  - oakley-village-hall
organisers:
  - oakley-village-hall
params:
  link:
    issue: June 2026
    pdfPages:
      - 10
---
```

### Body text

- **Period (required for timetable rows):** `Morning session`, `Afternoon session`, or `Evening session` — e.g. `Morning session (Andover Road village hall timetable).`
- **Green Hut events:** footer link to [oakleygreenhut.co.uk](http://www.oakleygreenhut.co.uk/) for bookings (do not paste hall phone from *Link*).
- **Coffee & Chat (`coffee-and-chat`):** use the Wed 10:00–12:00 body line above, not “Morning session (Green Hut timetable).”
- **WI or yoga (Andover Road Tuesday evening):** note that the slot alternates—confirm with hall (**781229**).
- Do **not** invent clock times in front matter when *Link* only names a day band.

Derive period from the folder slug / *Link* row label (`-morning-`, `-mornings-`, `-afternoon-`, `-afternoons-`, `-evening-`, `-evenings-`).

### Not hall timetable rows

- One-off AGMs, open days, named group meetings → **Tier A**, correct organiser (not hall organiser unless truly unknown).
- **Deprecated:** one `index.md` per week for the same activity (`content/events/foo/2026-06-08/`, `…/2026-06-15/`, …). Merge into monthly Tier B bundles; add `aliases` only when replacing old weekly URLs.

### Andover Road vs Green Hut activity lists (May 2026 reference)

**Andover Road (`oakley-village-hall`):** pilates, workout-to-music, badminton, table-tennis, marching, kickboxing, trinity-baby-class, yoga, WI-or-yoga (check *Link* each month).

**Green Hut (`east-oakley-village-hall` organiser repo):** chair-yoga, art-class, air-rifle-pistol-club, speedy-yoga (check *Link* each month).

**Green Hut Coffee & Chat (`main`, `coffee-and-chat`):** Wednesdays 10:00–12:00 — not in the east-oakley organiser repo.

Re-verify against the PDF each ingest; groups and slots can change.

## Review passes

1. **Pass 1:** Obvious dated lines  
2. **Pass 2:** Implicit / recurring (“Nth weekday”, bank holidays, “see page …”)  
3. **Pass 3:** Coverage audit vs contents + every PDF page numbered 1–40  
4. **Pass 4 (monthly carry-forward):** Any recurring event filed from the **prior month’s Link ingest** gets a sibling file for the new calendar month when the slot continues—even if the new issue does not reprint hall timetables. Clone prior structure; shift **dates**; set `params.link.issue` to the current issue; add `# source:` when the new issue is silent. Hall rows: date-only + period in body (see hall § above).

## Missing taxonomy

Flag `MISSING_VENUE` / `MISSING_ORGANISER` in notes when no [`content/venues`](../content/venues/) or [`content/organisers`](../content/organisers/) slug exists.

## Runs

- **[link-may-2026-ingest-appendix.md](link-may-2026-ingest-appendix.md)** — Oakley-only exclusions and filing notes after the May 2026 *Link* pass.
- **[link-june-2026-ingest-appendix.md](link-june-2026-ingest-appendix.md)** — Oakley-only exclusions and filing notes after the June 2026 *Link* pass.
