# GitHub Actions Deployment System

This directory contains the GitHub Actions workflows for the main repository's deployment system. The system supports:
- Scheduled builds
- Push-triggered builds
- Deployment-triggered builds from other repositories

## Documentation Structure

1. [GitHub App Trust Model](github-app-trust-model.md) - Technical details about the security model
2. [Organiser Repository Setup](../organisers/example-group/.github/workflows/README.md) - Guide for setting up deployment triggers

## Workflows

### 1. Scheduled Builds (`scheduled-build.yml`)
- Runs daily at 00:00 UTC and 12:00 UTC
- Triggers a Cloudflare Pages build
- Uses the official Cloudflare Pages GitHub Action

### 2. Deployment Builds (`deploy.yml`)
- Triggers on:
  - Pushes to the main branch
  - Deployment events from other repositories
- Builds and deploys to Cloudflare Pages
- Uses the official Cloudflare Pages GitHub Action

## Prerequisites

1. Cloudflare setup:
   - Account ID
   - Project ID
   - API token with Pages deployment permissions

2. GitHub secrets:
   - `CLOUDFLARE_ACCOUNT_ID`
   - `CLOUDFLARE_PROJECT_ID`
   - `CLOUDFLARE_API_TOKEN`

## Security

The system uses GitHub Apps for secure cross-repository deployments. See the [GitHub App Trust Model](github-app-trust-model.md) for details.

## Related Documentation

- [GitHub App Trust Model](github-app-trust-model.md)
- [Organiser Repository Setup](../organisers/example-group/.github/workflows/README.md)
- [Cloudflare Pages Documentation](https://developers.cloudflare.com/pages/)
