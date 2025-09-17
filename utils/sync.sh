#!/bin/bash
# When using dropbox & wsl. Copy to wsl and work directly then regularly sync over to a mnt file so changes are reflected in DB.
# You need to set paths correctly first

# Configuration - UPDATE THESE PATHS BEFORE RUNNING
WSL_PROJECT_PATH="~/wsl-projs/PROJECT_NAME/"  # UPDATE: Set your WSL project path
DROPBOX_PATH="/mnt/c/Users/USERNAME/Dropbox/PATH/TO/PROJECT/"  # UPDATE: Set your Dropbox path
PROJECT_NAME="PROJECT_NAME"  # UPDATE: Set your project name

# Exclusions
EXCLUDE_DIRS=(
    'renv/library/'
    'renv/staging/'
    'renv/cache/'
    'renv/local/'
    '.Rproj.user/'
    '.Ruserdata/'
)

EXCLUDE_FILES=(
    '.Rhistory'
    '.RData'
)

# Build exclude arguments
EXCLUDE_ARGS=""
for dir in "${EXCLUDE_DIRS[@]}"; do
    EXCLUDE_ARGS="$EXCLUDE_ARGS --exclude='$dir'"
done
for file in "${EXCLUDE_FILES[@]}"; do
    EXCLUDE_ARGS="$EXCLUDE_ARGS --exclude='$file'"
done

# Check if paths have been updated
if [[ "$WSL_PROJECT_PATH" == *"PROJECT_NAME"* ]] || [[ "$DROPBOX_PATH" == *"USERNAME"* ]] || [[ "$PROJECT_NAME" == "PROJECT_NAME" ]]; then
    echo "========================================="
    echo "ERROR: Template paths not updated!"
    echo "Please update the following variables:"
    echo "  - WSL_PROJECT_PATH"
    echo "  - DROPBOX_PATH"
    echo "  - PROJECT_NAME"
    echo "========================================="
    exit 1
fi

# Sync function
echo "========================================="
echo "Syncing $PROJECT_NAME to Dropbox..."
echo "From: $WSL_PROJECT_PATH"
echo "To:   $DROPBOX_PATH"
echo "========================================="

eval rsync -ah --progress $EXCLUDE_ARGS "$WSL_PROJECT_PATH" "$DROPBOX_PATH"

echo "========================================="
echo "✓ Sync completed successfully!"
echo "========================================="
