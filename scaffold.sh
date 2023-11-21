#!/bin/bash

# Get absolute path of directory of this script
SCRIPT_DIR="$(dirname "$(readlink -f "$0")")"

# Set the default template directory
base="$SCRIPT_DIR/templates/"
default_template_dir="cpp"

# Check if a custom template directory path is provided as an argument
if [ $# -ge 1 ]; then
    template_dir="$base$1" #"$1"
else
    template_dir="$base$default_template_dir"
fi

target_dir=$(pwd) 

# Check if a custom target path is provided as an argument
if [ $# -ge 2 ]; then
    # Set the target path
    target_dir="$target_dir/$2"
fi

# Create a new project directory with the provided name
mkdir -p "$target_dir"

# Copy the contents of the template directory to the new project directory
cp -r "$template_dir"/* "$target_dir"

echo "Project scaffolding complete. Your project is ready at: $target_dir"

code $target_dir