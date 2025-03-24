# Content Editing Guide

This document explains how content editing works in the Our Area community website ecosystem, particularly focusing on the group-based editing system for venues and organisers.

## Overview

The website uses a group-based system to manage who can edit different types of content. Each group (like example-group) has its own content directory and can manage specific types of content based on permissions.

## Directory Structure

```
main/
├── content/              # Main site content
│   ├── venues/          # Venue taxonomy terms
│   └── organisers/      # Organiser taxonomy terms
└── EDITING.md           # This file

example-group/
├── content/
│   ├── events/          # Events organised by organiser choosing
│   ├── organisers-info/ # Additional organiser information
│   └── venues-info/     # Additional venue information
└── README.md
```

## Group Permissions

### Venues and Organisers

1. The main site maintains the primary venue and organiser taxonomy terms in `content/venues/` and `content/organisers/`
2. Each venue and organiser can specify which groups are allowed to add additional information
3. This is done through the `allowed_groups` field in the front matter:
   ```yaml
   ---
   title: "Example Venue"
   allowed_groups: ["example-group", "group-two"]
   ---
   ```

### Additional Information

1. Groups that are allowed to edit a venue or organiser can add additional information in their own content directory
2. The additional information is stored in:
   - `content/example-group/venues-info/` for venue information
   - `content/example-group/organisers-info/` for organiser information
3. The content is loaded based on the group name specified in the venue/organiser's `allowed_groups` field

## How It Works

1. When a venue or organiser is created in the main site:
   - Select which groups can add additional information using the `allowed_groups` field
   - This can be multiple groups if needed

2. When a group wants to add information:
   - They create a new entry in their `venues-info` or `organisers-info` directory
   - The entry must match the taxonomy term name exactly
   - The content will only be displayed if the group is listed in the `allowed_groups` field

3. The site loads additional information by:
   - Checking the venue/organiser's `allowed_groups` field
   - Looking for matching content in each allowed group's info directory
   - Displaying all matching content from allowed groups

## Example

1. Main site creates a venue:
   ```yaml
   ---
   title: "Community Center"
   allowed_groups: ["example-group"]
   ---
   ```

2. Example group adds information:
   ```yaml
   ---
   title: "Community Center"
   ---
   Additional information about the venue...
   ```

3. The site will display both the main venue information and the additional information from example-group. The names much match

## Best Practices

1. Always check the `allowed_groups` field before adding information
2. Keep additional information focused and relevant
3. Use consistent naming between taxonomy terms and info pages
4. Coordinate with other groups if multiple groups are allowed to edit
5. Keep the main venue/organiser information up to date in the main site

## Technical Details

1. The group system is implemented through Hugo's mount system
2. Each group's content is mounted in its own directory
3. The site checks permissions by comparing the current group against the `allowed_groups` list
4. Additional information is only loaded for `allowed_groups`
