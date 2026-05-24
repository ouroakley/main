# Organiser bootstrap backlog (no Hugo module yet)

These [`main/content/organisers/<slug>/`](/Users/Alex/Development/wt/community/ouroakley/main/content/organisers/) taxonomy terms have **no** `content/events/<slug>/` mount in [`main/hugo.yaml`](/Users/Alex/Development/wt/community/ouroakley/main/hugo.yaml). Events that use them stay on **`main/content/events/`** until each group gets a repo and import block.

Canonical slug list and rules: [`organiser-modules-and-taxonomy.md`](organiser-modules-and-taxonomy.md).

| Slug | Status |
|------|--------|
| `tops` | Pending new `organiser-*` repo + mounts if desired. |
| `oakley-community-care` | Pending. |
| `watership-down-health` | **Intentionally main-only** (e.g. PPG clinics); see [`link-may-2026-ingest-appendix.md`](link-may-2026-ingest-appendix.md). |
| `louise-wesley` | Pending. |
| `coffee-and-chat` | Pending. |
| `the-fox-inn` | Pending. |
| `the-beach-arms` | Pending. |
| `oakley-neighbourhood-watch` | Pending (e.g. co-listed on **Community Market** events, which are kept on **`main/content/events/commmunity-market/`** alongside `the-barley-mow` and `craft-kits-n-bits`). |
| `craft-kits-n-bits` | Pending. |
| `alex-rowley` | Pending. |
| `example-organiser` | Demo taxonomy; template module uses mount slug `example`, not `example-organiser`. |

When adding a module: follow [`README.md`](../README.md) (Hugo modules), [`organiser-cms-slugs.md`](organiser-cms-slugs.md) for `/admin/`, and optionally [`../../scripts/new-organiser.sh`](../../scripts/new-organiser.sh) from the monorepo layout.

After bootstrap, move any **`main/content/events/`** owned by that organiser into `organisers/<repo>/content/events/` per [`organiser-modules-and-taxonomy.md`](organiser-modules-and-taxonomy.md).
