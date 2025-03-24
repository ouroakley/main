#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
PUBLIC_DIR="public"
MODULE_PATH="/opt/buildhome/.cache/hugo_cache/modules/filecache/modules/pkg/mod/github.com/ouroakley/example-group@v0.0.0-20250324230350-ae1a0a371730"

# Print a message
echo "Starting the build process for Our Oakley..."

# Clean up the public directory if it exists
if [ -d "$PUBLIC_DIR" ]; then
  echo "Cleaning up existing public directory..."
  rm -rf $PUBLIC_DIR
fi

echo "Checking module directories BEFORE Hugo build:"
echo "Module content directory:"
ls -la $MODULE_PATH/content/ 2>/dev/null || echo "Directory does not exist"
echo "Module static directory:"
ls -la $MODULE_PATH/static/ 2>/dev/null || echo "Directory does not exist"

# Run Hugo to build the site
echo "Running Hugo..."
hugo mod graph
hugo mod get -u
hugo

echo "Checking module directories AFTER Hugo build:"
echo "Module content directory:"
ls -la $MODULE_PATH/content/ 2>/dev/null || echo "Directory does not exist"
echo "Module static directory:"
ls -la $MODULE_PATH/static/ 2>/dev/null || echo "Directory does not exist"

# Print a success message
echo "Build process completed successfully."