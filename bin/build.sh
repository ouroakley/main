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

echo "Output of hugo mod graph:"
hugo mod graph

echo "Output of hugo:"
hugo build --buildFuture

echo "Output of hugo list published:"
hugo list published

echo "Output of hugo list drafts:"
hugo list drafts

echo "Output of hugo list future:"
hugo list future

echo "Output of ls -rla $PUBLIC_DIR:"
ls -rla $PUBLIC_DIR

# Print a success message
echo "Build process completed successfully."
