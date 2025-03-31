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

cat go.mod

hugo mod graph
hugo mod get -u
hugo

ls -rla $PUBLIC_DIR

# Print a success message
echo "Build process completed successfully."
