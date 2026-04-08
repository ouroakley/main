# `organiser_cms_slugs` (admin hub)

When you add a new organiser **Hugo module** in [`hugo.yaml`](../hugo.yaml) (`module.imports` and `static/admin/<slug>/` mounts), you must also add that **same `<slug>`** to `params.organiser_cms_slugs` in the same file.

Reason: the `/admin/` listing ([`layouts/_default/admin.html`](../layouts/_default/admin.html)) cannot read `module.imports` from templates—Hugo’s `site.Config` does not expose module config—so the hub uses this explicit list to decide which taxonomy terms get a “Manage content” card.

If you use [`scripts/new-organiser.sh`](../../scripts/new-organiser.sh) from the expected monorepo layout, it appends the slug for you. If you wire a module by hand, edit `organiser_cms_slugs` in the same change as the new import block.

See also [`README.md`](../README.md) (Hugo modules / adding an organiser).
