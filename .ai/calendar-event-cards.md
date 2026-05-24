# Calendar event presentation

The community calendar (`layouts/_default/calendar.html`) renders each event as a **`.calendar-event`** block: bordered chip with a left accent (**`#137752`**, same as Tachyons `bg-dark-green` / site header), title on the first line and time (when present) on a second line. The event list uses flex `gap` so items stay visually separate on the month grid and on mobile day stacks.

If you add organiser-based colours later, prefer a `data-organiser` attribute on `.calendar-event` and CSS variables or modifier classes rather than inline styles.

**Local preview:** from `main/`, run `hugo server` (default `http://localhost:1313/`). Calendar route: `/calendar/`.
