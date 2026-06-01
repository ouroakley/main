# Link June 2026 — ingest appendix

Events were extracted from **Link June 2026** (`LinkJune2026_compressed.pdf`, 40 pages). Oakley-linked items only. Ingest rules: [link-pdf-ingest-rules.md](link-pdf-ingest-rules.md) (including [§ Recurring village hall bookings](link-pdf-ingest-rules.md#recurring-village-hall-bookings-link-timetables)).

## Filing summary

| Source | New/updated files |
|--------|-------------------|
| June Link prose (Tier A + B) | 17 |
| May carry-forward (Pass 4) | 25 (16 hall + 1 Green Hut coffee + 2 OWW + 1 stitchers + 1 councillor chat + 4 container collections) |
| Methodist anniversary patches + coffee mornings | 3 |
| May hall timetable retrofits (date-only times) | 17 patches |
| Main taxonomy creates | Scout organiser + venue |

**Hall timetables:** June issue did not reprint p.10 timetables; slots carried forward from May 2026 with date-only `eventDates` and Morning/Afternoon/Evening in body. **Exception:** Green Hut Coffee & Chat on `main` uses **Wed 10:00–12:00** clock times (organiser `coffee-and-chat`).

### May → June hall carry-forward (16 + Green Hut coffee)

| May template | June path |
|--------------|-----------|
| `oakley-village-hall-pilates-morning-mondays-may-2026` | `…-pilates-morning-mondays-june-2026` |
| `…-workout-to-music-mornings-mondays-may-2026` | `…-june-2026` |
| `…-badminton-mondays-afternoon-may-2026` | `…-june-2026` |
| `…-table-tennis-evenings-monday-may-2026` | `…-june-2026` |
| `…-marching-tuesdays-may-2026` | `…-june-2026` |
| `…-badminton-tuesday-afternoons-may-2026` | `…-june-2026` |
| `…-evening-wi-or-yoga-tuesdays-may-2026` | `…-june-2026` |
| `…-workout-to-music-wednesdays-may-2026` | `…-june-2026` |
| `…-kick-boxing-wednesdays-may-2026` | `…-june-2026` |
| `…-badminton-thursday-evenings-may-2026` | `…-june-2026` |
| `…-trinity-baby-class-fridays-may-2026` | `…-june-2026` |
| `…-yoga-evenings-friday-may-2026` | `…-june-2026` |
| `east-oakley-village-hall-chair-yoga-fridays-morning-may-2026` | `…-june-2026` |
| `…-art-class-tuesdays-afternoon-may-2026` | `…-june-2026` |
| `…-air-rifle-pistol-club-tuesday-evenings-may-2026` | `…-june-2026` |
| `…-speedy-yoga-wednesdays-afternoon-may-2026` | `…-june-2026` |
| `main/…/coffee-chat-east-oakley-green-hut-wednesdays-morning-may-2026` | `…-june-2026` |

All under `organisers/oakley-village-hall/`, `organisers/east-oakley-village-hall/`, or `main/content/events/` as appropriate. Green Hut coffee: `main/…/coffee-chat-east-oakley-green-hut-wednesdays-morning-*`, **10:00–12:00** Wednesdays.

## Excluded non-Oakley (or not calendar-publishable here)

| Item | PDF page | Reason |
|------|----------|--------|
| Summerdown farm tours / Supper at Summerdown 19–20 Jun | 5 | North Hampshire farm, not Oakley |
| GP Triage go-live; Covid booster window; NHS App testing | 8 | Operational / guidance |
| PPG NHS App drop-in Kingsclere 30 Jun | 8 | Venue outside Oakley |
| Friends of Watership Down Health AGM Overton 29 Jun | 8 | Overton Surgery (accounts **inspection at Oakley** is included) |
| Friends nominations/resolutions deadline 15 Jun | 8 | Administrative deadline, not a public session |
| Coeliac UK meet-up Waitrose Basing View 20 Jun | 8 | Outside Oakley |
| Paul Weston JOGLE sponsored ride 29 May–10 Jun | 13 | Fundraising journey, not parish calendar slot |
| Citizens Advice Renters' Rights article | 14 | Article only |
| Jolly Olly's cyclist promo / Fathers' Day / cash plea | 14 | Promotions |
| Jolly Olly's Saturday knitting club | 14 | No June times in Link |
| Cranbourne / Testbourne school news | 15–16 | No Oakley-fixed dated events |
| Willis Museum bee exhibition to 28 Jun | 20 | Basingstoke venue |
| Overton Art Group exhibition 22–23 Aug | 21 | Overton |
| Andover Chamber Choir 18 Jul; Overton Choral 20 Jun; BCB jazz 5 Jul Sherfield | 28, 31 | Non-Oakley venues |
| Hampshire Harmony concerts (Andover / Basingstoke); St Bede's fair 5 Jun | 28 | Non-Oakley |
| Whitchurch Silk Mill programme | 33 | Whitchurch |
| Freeads / July issue deadline 15 Jun; Action Hampshire article | 3, 34 | Editorial / awareness |
| HCC ward report; woodlands recess; bowling news | 10, 20, 36 | No dated Oakley events |
| Councillors' Chat **26 May** at Jolly Olly's | 7 | Past date when June issue publishes; Jun 9 & 23 via carry-forward |
| Malshanger barn dance (prior month report) | 36 | Outside Oakley |

## Ambiguous / follow-up later

| Item | Notes |
|------|--------|
| Scout AGM | Main-only organiser **`oakley-scout-guide-premises-committee`** + venue **`oakley-scout-guide-premises`** created on main |
| Woodland wellbeing walks | Per-walk start points in body; `venues: tbc` |
| Afternoon WI Barley Mow coffee / Deane WI walk | Times not in Link — estimated from group norms |
| Friends accounts inspection | Multi-site notice; only **Oakley surgery** leg calendarled |
| Village Show submission deadlines | Included as all-day deadline rows on public calendar |
| Hall timetable clock times | Date-only + period in body for organiser-repo hall rows; see [link-pdf-ingest-rules.md § Recurring village hall bookings](link-pdf-ingest-rules.md#recurring-village-hall-bookings-link-timetables) |
| Green Hut Coffee & Chat | `main`, organiser `coffee-and-chat`, Wed **10:00–12:00**, venue `east-oakley-village-hall` |

## New taxonomy on main

| Slug | Type | Title |
|------|------|-------|
| `oakley-scout-guide-premises-committee` | organiser | Oakley Scout & Guide Premises Committee |
| `oakley-scout-guide-premises` | venue | Oakley Scout & Guide Premises (St John's Piece, RG23 7JQ) |
