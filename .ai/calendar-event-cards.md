# Calendar event presentation

The community calendar (`layouts/_default/calendar.html`) renders each event as a **`.calendar-event`** block: bordered chip with a left accent (**`#137752`**, same as Tachyons `bg-dark-green` / site header), title on the first line and time (when present) on a second line. The event list uses flex `gap` so items stay visually separate on the month grid and on mobile day stacks.

If you add organiser-based colours later, prefer a `data-organiser` attribute on `.calendar-event` and CSS variables or modifier classes rather than inline styles.

**Local preview:** from `main/`, run `hugo server` (default `http://localhost:1313/`). Calendar route: `/calendar/`.

## Intra-day order

Within each day cell, events are sorted by a `sortKey` computed in `calendar.html`: entries with prefix `0-` (no clock time for that day — start at `00:00`, end-only day with `00:00` end, or a middle day of a multi-day range) appear first, ordered by `RelPermalink`. Entries with prefix `1-` follow, ordered by local `YYYYMMDDHHmmss` from the start time on the start day or the end time on the last day only, then `RelPermalink` for ties.

**Monthly bundles:** One event page with several `eventDates` in the same month still produces **one calendar chip per affected day** (the template expands ranges); verify ordering after large merges.
