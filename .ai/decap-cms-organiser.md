# Decap CMS (organiser repos)

Each organiser repo ships `static/admin/config.yml` for Decap.

- **`editor.preview`**: When `true`, Decap shows the split editor **preview pane** while editing entries. The OCA organiser (`organiser-oca`) sets this to `true`. The shared organiser template and most other repos still use `false` until they opt in.

- **OCA custom `events` preview**: The OCA repo registers a preview template so the pane resembles the live Hugo event single (Our Oakley `main` theme). Files live next to the admin entrypoint: `static/admin/preview-events.js` (React `createClass` + `CMS.registerPreviewTemplate('events', …)` + `CMS.registerPreviewStyle` for `preview-events.css`) and `static/admin/index.html` loads `./preview-events.js` after the Decap bundle. Other organisers can copy this pair of files and the extra script tag if they enable preview and want the same layout.

See [Decap configuration options](https://decapcms.org/docs/configuration-options/) (`editor`).

## Local `hugo server` and `public/admin/…/config.yml` (permission denied)

`hugo` (a normal build) writes `public/admin/<slug>/config.yml` (and `index.html`, etc.) as mode **`444`** (read-only). A default **`hugo server`** still publishes into `public/` and periodically tries to **replace** those files; opening them for write then fails with **`open …/public/admin/…/config.yml: permission denied`**, and the in-app browser shows Hugo’s error page instead of Decap.

**Reliable fix for local CMS dev:** run from `main/`:

```bash
hugo server --renderToMemory
```

(short flag **`-M`**) so Hugo serves from memory and does not fight read-only files under `public/`.

**Alternatives:** after every `hugo` build, `chmod -R u+w public/admin`; or delete `public/` and only use `hugo server` (not a separate `hugo` then server on the same tree); or restart `hugo server` after chmod (chmod alone does not help if the next build re-applies `444`).
