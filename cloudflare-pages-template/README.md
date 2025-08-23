# Cloudflare Pages Template

This folder is a minimal example for deploying a static site (built with [Hugo](https://gohugo.io/)) to [Cloudflare Pages](https://pages.cloudflare.com) using GitHub Actions.

## Repository Layout

```
.
├── bin/
│   └── build.sh                 # Builds the site into the public/ directory
├── functions/
│   └── api/                     # Cloudflare Functions used for Decap CMS auth
│       ├── auth.js
│       └── callback.js
├── static/
│   └── admin/
│       └── main/
│           ├── config.yml       # Decap CMS configuration
│           └── index.html       # Decap CMS entry point
└── .github/
    └── workflows/
        └── scheduled-build.yml  # GitHub Actions workflow for deployment
```

## Prerequisites

* A Cloudflare account with Pages enabled
* A GitHub repository containing your static site source
* A GitHub OAuth application for Decap CMS (callback URL: `/api/callback`)
* Hugo installed locally if you wish to build and test before pushing

## Setup Instructions

1. **Copy the template**
   * Copy the contents of this folder into the root of your new repository.
2. **Configure Cloudflare Pages project**
   * Create a new Pages project in Cloudflare and connect it to your GitHub repository.
   * Set the build command to `./bin/build.sh` (or `hugo` if using the default Hugo build) and the build output directory to `public`.
3. **Generate a Cloudflare API token**
   * Go to **My Profile → API Tokens → Create Token**.
   * Use the **"Edit Cloudflare Workers"** template and grant access to your account.
4. **Add GitHub repository secrets**
   * In your repository settings, add the following secrets used by the workflow:
     * `CLOUDFLARE_API_TOKEN` – the token created above
     * `CLOUDFLARE_ACCOUNT_ID` – your Cloudflare account ID
     * `CLOUDFLARE_PROJECT_NAME` – the Pages project name
5. **Configure Decap CMS environment variables**
   * In the Cloudflare Pages project settings, add the environment variables:
     * `GITHUB_CLIENT_ID` – from your GitHub OAuth application
     * `GITHUB_CLIENT_SECRET` – from your GitHub OAuth application
6. **Customize build script (optional)**
   * The `bin/build.sh` script runs `hugo build` and prints some diagnostic output. Modify it if your site uses a different build process.
7. **Enable GitHub Actions**
   * The workflow in `.github/workflows/scheduled-build.yml` runs on a schedule and on manual dispatch. Adjust the cron schedule or triggers as needed.

## Deployment

After pushing changes to your repository, you can either wait for the scheduled workflow to run or manually trigger it in the GitHub Actions tab. The workflow builds the site and deploys it to Cloudflare Pages using [`cloudflare/wrangler-action`](https://github.com/cloudflare/wrangler-action).

## Troubleshooting

* Ensure the build output is written to the `public` directory.
* Verify the required secrets are present in your GitHub repository settings.
* Check the workflow logs in GitHub Actions for detailed error messages.
