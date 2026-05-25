# Decap CMS (organiser repos)

Each organiser repo ships `static/admin/config.yml` for Decap.

- **`editor.preview`**: When `true`, Decap shows the split editor **preview pane** while editing entries. The OCA organiser (`organiser-oca`) sets this to `true`. The shared organiser template and most other repos still use `false` until they opt in.

- **OCA custom `events` preview**: The OCA repo registers a preview template so the pane resembles the live Hugo event single (Our Oakley `main` theme). Files live next to the admin entrypoint: `static/admin/preview-events.js` (React `createClass` + `CMS.registerPreviewTemplate('events', …)` + `CMS.registerPreviewStyle` for `preview-events.css`) and `static/admin/index.html` loads `./preview-events.js` after the Decap bundle. Other organisers can copy this pair of files and the extra script tag if they enable preview and want the same layout. The preview fetches `https://www.ouroakley.uk/venues/index.json` and `…/organisers/index.json` to show human-readable venue and organiser titles (requires those JSON outputs to include `slug` / `baseName`, as in the main site `layouts/*/taxonomy.json` templates). A banner at the top builds the expected live event URL from `main/hugo.yaml` `permalinks.events` (`/:sections/:year/:month/:day/:slug/`), the front matter `date`, a fixed `events/oca` section prefix, and the entry path slug—keep that logic in sync if permalinks or the module mount change. In `render`, any `map`/`forEach` callback that calls instance methods must bind `this` (e.g. `arr.map(function (...) { ... }, this)`) or use `var self = this`; otherwise `this` is not the component and previews throw at runtime. Two-column layout and the aside poster use **`@container` on the root `.decap-event-preview` element** (`container-name: event-preview`; see `preview-events.css`) so breakpoints follow the Decap preview iframe width; plain `@media (min-width: …)` tied to the outer viewport often leaves the aside poster hidden in a narrow split pane. CSS class prefix is organiser-agnostic (`decap-event-preview__…`) for reuse across repos; each copy still sets its own Hugo events mount slug in JS (e.g. `EVENTS_MOUNT_SLUG`) to match `main` module mounts.

See [Decap configuration options](https://decapcms.org/docs/configuration-options/) (`editor`).

## Local `hugo server` and `public/admin/…/config.yml` (permission denied)

`hugo` (a normal build) writes `public/admin/<slug>/config.yml` (and `index.html`, etc.) as mode **`444`** (read-only). A default **`hugo server`** still publishes into `public/` and periodically tries to **replace** those files; opening them for write then fails with **`open …/public/admin/…/config.yml: permission denied`**, and the in-app browser shows Hugo’s error page instead of Decap.

**Reliable fix for local CMS dev:** run from `main/`:

```bash
hugo server --renderToMemory
```

(short flag **`-M`**) so Hugo serves from memory and does not fight read-only files under `public/`.

**Alternatives:** after every `hugo` build, `chmod -R u+w public/admin`; or delete `public/` and only use `hugo server` (not a separate `hugo` then server on the same tree); or restart `hugo server` after chmod (chmod alone does not help if the next build re-applies `444`).
