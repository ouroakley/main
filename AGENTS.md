# Directory Guide

This workspace contains multiple independent projects related to Our Oakley.

At the workspace root, `AGENTS.md` is a symlink to this file (`main/AGENTS.md`). Edit **`main/AGENTS.md`** only. Longer operational notes (for example [`.ai/organiser-cms-slugs.md`](.ai/organiser-cms-slugs.md)) live under [`.ai/`](.ai/) so this guide stays short.

## Top-level directories

- `main/`
  - Primary Our Oakley website.
  - Hugo static site project (main production content/site code).
  - In `go.mod`, Hugo organiser modules (`github.com/ouroakley/organiser-*`) must use the branch name `main` as the version, not pseudo-version pins (e.g. `v0.0.0-20…`). See [README.md](README.md#hugo-modules-and-gomod).
  - `go.sum` is gitignored in [.gitignore](.gitignore); do not commit it. Branch-based `go.mod` only, matching the pre–`30c1d35` pattern.

- `organisers/`
  - Per-organiser repositories and content.
  - Each subdirectory (for example `jolly-ollys/`, `oakley-afternoon-wi/`) is its own organiser-specific project.

- `pages-cms/`
  - Pages CMS application (Next.js-based CMS codebase).
  - Used to manage content through GitHub app-based workflows.

- `decap-cms/`
  - Decap CMS codebase/monorepo.
  - Separate project used for CMS capabilities and related packages.

- `netlify-cms-cloudflare-pages/`
  - Cloudflare Pages Functions integration for Decap/Netlify CMS GitHub OAuth flows.
  - Includes function endpoints and static admin starter assets.

- `concepts/`
  - Experimental/prototype work.
  - Contains alternate calendar builds and layout/theme explorations.

- `terraform/`
  - Infrastructure-as-code for GitHub org/repository/team management.
  - Includes Terraform config under `terraform/projects/github/`.

- `scripts/`
  - Utility scripts for recurring maintenance tasks.
  - Includes organiser bootstrap and CMS config update scripts.

- `meta/`
  - Notes and setup documentation.
  - Treat as operational reference; do not commit secrets.

- `.cursor/`
  - Editor/tooling metadata.

## Working conventions

- Many subdirectories are independent git repositories.
- Run commands from the relevant project directory, not always from this root.
- Keep project-specific env vars/config local to each project.
