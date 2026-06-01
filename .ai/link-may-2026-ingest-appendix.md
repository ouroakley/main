# Link May 2026 — ingest appendix

Events were extracted from **`LinkMay2026_optimised.pdf`** (Oakley-linked items only).

## Excluded non-Oakley (or not calendar-publishable here)

| Item | PDF page | Reason |
|------|----------|--------|
| Coeliac UK meet‑up Waitrose Café Basing View | 13–14 | Venue outside Oakley |
| Bees! Willis Museum Basingstoke + related dates | 15 | Venue outside Oakley |
| Age Concern “Living Well in Later Life” launch | 10 | Hampshire-wide programme notice, no Oakley-fixed session dated here |
| GP Triage go‑live headline | 13 | Operational change notice (not pinned as clinic event); Link copy only |
| Spring booster vaccination / 119 booking window | 13 | Guidance window |
| Deadline for June 2026 submissions / freeads cutoff | contents,34 | Editorial deadline |
| Basingstoke Choral Odiham; BMVC Basingstoke; Overton Choral Overton | 31 | Venue outside Oakley |
| Cranbourne Careers Fair **23 Jun** etc. | 19–20 | School premises outside Oakley |
| Jubiloaks / Wildlife Trust prose | 20–21 | No dated Oakley-hosted event stated |
| Whitchurch Silk Mill workshops/festival | 33 | Location outside Oakley |
| Citizens Advice bulk article | 34 | Advice article (no parish calendar item) |
| Oakley Bowling Club barn dance Malshanger **9 May** | 37 | Malshanger venue (outside Oakley village scope) |
| Murder Mystery Night / John Pinkerton canal trip | 37 | No dates quoted |
| HCC ward report prose | 8 | Editorial |
| Jolly Olly’s “bank holidays closed / promotions” | 22 | Opening hours / promotions (not singled as events here) |

## Ambiguous / follow-up later

| Item | Notes |
|------|--------|
| Parish Council AGM **14 May venue** | Not named in snippet — flagged `venues: [tbc]` with HTML comment |
| Tier B hall timetable rows | Initially filed with **estimated clock times**; policy is now **date-only** `eventDates` (`T00:00:00`) with **Morning / Afternoon / Evening** in the body for **organiser-repo** hall rows — see [link-pdf-ingest-rules.md § Recurring village hall bookings](link-pdf-ingest-rules.md#recurring-village-hall-bookings-link-timetables). Retrofit those May bundles before cloning. **Green Hut Coffee & Chat** on `main` keeps **Wed 10:00–12:00** — see § Green Hut Coffee & Chat in same doc. |
| Andover WI-or-Yoga Tuesday slot | Listing alternates WI vs Yoga — consolidated as one timetable row per Link naming |

## Filing notes

Hall timetable rows where the **hirer organiser is unknown** are attributed to the **hall organiser taxonomy** matching the venue (**`oakley-village-hall`** or **`east-oakley-village-hall`**), with event Markdown under **`organisers/oakley-village-hall/content/events/`** or **`organisers/east-oakley-village-hall/content/events/`** (see [organiser-modules-and-taxonomy.md](organiser-modules-and-taxonomy.md)).

Events with **no Hugo organiser submodule** stay on **`main/content/events`** (e.g. PPG clinics with **watership-down-health**, Green Hut Coffee & Chat with **coffee-and-chat**, Wednesdays **10:00–12:00** at `east-oakley-village-hall`).
