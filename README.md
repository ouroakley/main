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