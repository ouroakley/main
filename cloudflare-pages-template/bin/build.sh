#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Define variables
PUBLIC_DIR="public"

# Print a message
echo "Starting the build process..."

# Clean up the public directory if it exists
if [ -d "$PUBLIC_DIR" ]; then
  echo "Cleaning up existing public directory..."
  rm -rf $PUBLIC_DIR
fi


# Run Hugo to build the site
echo "Running Hugo..."

echo "Output of hugo:"
hugo build --buildFuture --logLevel debug

echo "--------------------------------"

echo "Output of hugo list published:"
hugo list published

echo "--------------------------------"

echo "Output of hugo list drafts:"
hugo list drafts

echo "--------------------------------"

echo "Output of hugo list future:"
hugo list future

echo "--------------------------------"

echo "Output of ls -rla $PUBLIC_DIR:"
ls -rla $PUBLIC_DIR

echo "--------------------------------"

# Print a success message
echo "Build process completed successfully."
