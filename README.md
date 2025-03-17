# Our Oakley - Main

The main repo for Our Oakley.


# Technical Notes

The site is built using the static site generator Hugo - https://gohugo.io/

Hugo provide a quick start guide: https://gohugo.io/getting-started/quick-start/


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
