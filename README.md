# Our Oakley - Main

The main repo for Our Oakley.


# Technical Notes

The site is built using the static site generator Hugo - https://gohugo.io/

Hugo provide a quick start guide: https://gohugo.io/getting-started/quick-start/

## Hugo modules and go.mod

Organiser content is pulled in via Hugo’s module system; dependencies are declared in [go.mod](go.mod).

**Convention:** every `require` for `github.com/ouroakley/organiser-*` must **track the `main` branch** on that repo. The **committed** [`go.mod`](go.mod) keeps the version column as the branch token **`main`** (`… main // indirect`). Go and Hugo still need a concrete pseudo-version at build time; **[`bin/resolve-organiser-requires-to-tip-of-main.sh`](bin/resolve-organiser-requires-to-tip-of-main.sh)** rewrites those lines to the current tip of each repo’s `main` before **`hugo`** runs, and restores the committed form afterward (used from **[`bin/build.sh`](bin/build.sh)** and **[`bin/hugo-with-local-workspace.sh`](bin/hugo-with-local-workspace.sh)**).

**Avoid:** committing pseudo-version churn from ad-hoc `go get` / `hugo mod get`. If plain **`hugo`** rewrites `go.mod` on your machine, restore the `main` lines before committing, or use **`./bin/hugo-with-local-workspace.sh`** in the monorepo layout so `go.mod` stays stable.

**Note:** In the **local monorepo** layout (`main/` next to `organisers/`), prefer **`./bin/hugo-with-local-workspace.sh`** (gitignored **`go.work`** via **`./bin/go-work-local.sh`**) so Hugo does not keep pinning modules in the committed file; see [Local monorepo dev](#local-monorepo-dev-main--organisers) below.

**Adding a new organiser:** add the import mounts in `hugo.yaml`, add the same admin mount slug (the `static/admin/<slug>/` segment) to `params.organiser_cms_slugs` in `hugo.yaml` so the organiser appears on `/admin/`, then add a sorted line `github.com/ouroakley/organiser-<name> main // indirect` in the `require` block in `go.mod`. Do not pin to arbitrary commits unless the project explicitly decides otherwise. The [`scripts/new-organiser.sh`](../scripts/new-organiser.sh) bootstrap script updates `hugo.yaml`, `organiser_cms_slugs`, and refreshes `go.work` when run from the expected monorepo layout.

**`go.sum`:** listed in [.gitignore](.gitignore); do not commit it. Tooling may recreate it locally; that file stays untracked.

#### Local monorepo dev (`main` + `organisers/`)

When **`main/`** sits next to sibling **`organisers/*`** checkouts, maintain a **gitignored** `go.work` under `main/` so Go resolves `github.com/ouroakley/organiser-*` from those directories instead of the module proxy (avoids Hugo rewriting every `require` to `v0.0.0-…` locally).

1. **Refresh `go.work`:** `./bin/go-work-local.sh` (no-op if `../organisers` is missing, e.g. a `main`-only clone).
2. **Run Hugo (recommended):** `./bin/hugo-with-local-workspace.sh` with normal Hugo arguments, for example **`./bin/hugo-with-local-workspace.sh server`**. The script runs `go-work-local.sh`, then sets **`HUGO_MODULE_WORKSPACE`** to the absolute path of `main/go.work` when that file exists.
3. **Alternative:** from `main`, `export HUGO_MODULE_WORKSPACE=go.work` then run **`hugo`** as usual.

**Verify:** stop any running dev server, start again with **`./bin/hugo-with-local-workspace.sh server`**, then check **`git diff go.mod`** — organiser lines should stay on **`main`**.

**CI / production:** [bin/build.sh](bin/build.sh) runs **`resolve-organiser-requires-to-tip-of-main.sh apply`**, then plain **`hugo`**, then restores committed **`main`** `require` lines on exit. Do not set `module.workspace` in `hugo.yaml` to a path that only exists on developer machines. **`go.work`** and **`go.work.sum`** are gitignored; do not commit them.

## How this repo was created

Assumes hugo and git are installed locally and GitHub repo is already created

```
cd main
hugo new site . --force
git init
git add .
git commit -m 'Initial commit'
git remote add origin git@github.com:ouroakley/main.git
git push -u origin main
```

Add the theme, commit and push (git operations no longer shown)

```
git submodule add https://github.com/theNewDynamic/gohugo-theme-ananke.git themes/ananke
echo "theme = 'ananke'" >> hugo.toml
```

## Local Development Setup

When cloning this repository for local development, you need to initialize the git submodules (which include the Hugo theme):

**Option 1: Clone with submodules (recommended)**
```bash
git clone --recursive <repo-url>
cd main
```

**Option 2: Initialize submodules after cloning**
```bash
git clone <repo-url>
cd main
git submodule update --init --recursive
```

After initializing submodules, you can start the Hugo development server:

```bash
hugo server
```

The site will be available at `http://localhost:1313/`

If you use **Decap admin** under `/admin/<organiser>/` and see Hugo’s **permission denied** page for `public/admin/.../config.yml`, run **`hugo server --renderToMemory`** (`-M`) instead. A plain `hugo` build writes those files as read-only (`444`); the default server then cannot replace them when syncing into `public/`. See [`.ai/decap-cms-organiser.md`](.ai/decap-cms-organiser.md).

> **Note:** If you see a blank page, it's likely because the theme submodule wasn't initialized. Run `git submodule update --init --recursive` to fix this.

## Cloudflare Setup

1. Go to Compute (Workers)
1. Create a new application
1. Go to pages tab
1. Connect to git
1. Select repository
1. Set build options command: hugo, buildoutput: public

1. Add redirect rule for bare domain to www
1. Setup bar domain and www as custom domain for pages worker

# Our Oakley CMS

This project uses Decap CMS with GitHub App authentication for content management.

## Setup Instructions

### 1. Create a GitHub App

1. Create a GitHub app and generate a private key and client secret.

### 2. Configure Cloudflare Pages Environment Variables

1. Go to your Cloudflare Pages project settings
2. Navigate to the "Environment variables" section
3. Add the following variables:
   - `GITHUB_CLIENT_ID`: Your GitHub App's client ID
   - `GITHUB_CLIENT_SECRET`: Your GitHub App's client secret

Not currently used:
   - `GITHUB_APP_ID`: Your GitHub App ID
   - `GITHUB_PRIVATE_KEY`: Your GitHub App's private key (PEM format)
   - `GITHUB_WEBHOOK_SECRET`: The webhook secret you generated

### 3. Update Decap CMS Configuration

Make sure your `config.yml` file has the correct GitHub App authentication settings:

```yaml
backend:
  name: github
  repo: your-username/your-repo
  branch: main
  base_url: yourdomain.uk
```

## Security Considerations

1. Never commit your environment variables to version control
2. Keep your GitHub App's private key secure
3. Regularly rotate your webhook secret
4. Use HTTPS for all endpoints
5. Monitor GitHub App activity in the GitHub Developer Settings

## Troubleshooting

1. Check Cloudflare Pages deployment logs for authentication errors
2. Verify webhook deliveries in GitHub App settings
3. Ensure all environment variables are correctly set in Cloudflare Pages
4. Check GitHub App permissions are properly configured
5. Verify the GitHub App is installed on your repository
