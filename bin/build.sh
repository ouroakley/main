#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
PUBLIC_DIR="public"

# Print a message
echo "Starting the build process for Our Oakley..."

# Clean up the public directory if it exists
if [ -d "$PUBLIC_DIR" ]; then
  echo "Cleaning up existing public directory..."
  rm -rf $PUBLIC_DIR
fi


# Run Hugo to build the site
echo "Running Hugo..."

hugo mod get -u
hugo

# Print a success message
echo "Build process completed successfully."
