#!/usr/bin/env bash
# repo_structure_and_ignored_logger.sh
# Logs ignored files and ensures folder structure is preserved with .gitkeep.

set -euo pipefail

LOG_FILE="ignored_files.log"

# Ensure we're in a Git repo
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    echo "Error: This is not a Git repository." >&2
    exit 1
fi

echo "=== Step 1: Logging ignored files ==="
git ls-files --ignored --exclude-standard --others > "$LOG_FILE"

if [[ -s "$LOG_FILE" ]]; then
    echo "Ignored files logged to: $LOG_FILE"
else
    echo "No ignored files found."
    rm "$LOG_FILE"
fi

echo
echo "=== Step 2: Ensuring folder structure is preserved ==="

# Find all directories except .git
find . -type d ! -path './.git*' | while IFS= read -r dir; do
    # Skip the root "."
    [[ "$dir" == "." ]] && continue

    # Check if directory or its subfolders have tracked files
    if git ls-files --error-unmatch "$dir"/* >/dev/null 2>&1 || \
       git ls-files --error-unmatch "$dir"/**/* >/dev/null 2>&1; then
        continue
    fi

    # Add a .gitkeep if none exists
    gitkeep_path="$dir/.gitkeep"
    if [[ ! -f "$gitkeep_path" ]]; then
        echo "Adding .gitkeep to $dir"
        touch "$gitkeep_path"
        git add "$gitkeep_path"
    fi
done

echo
echo "Done. Commit and push to sync folder structure."
