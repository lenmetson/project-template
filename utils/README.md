# WSL-Dropbox Workflow
*Note: This README is AI-generated*

## Overview
When working with Dropbox and WSL, file watching and syncing can be slow. This workflow copies projects to WSL for fast local development, then syncs changes back to Dropbox.

## Initial Setup

### 1. Copy project from Dropbox to WSL
```bash
cp -r /mnt/c/Users/USERNAME/Dropbox/PATH/TO/PROJECT /home/USERNAME/wsl-projs/
```

### 2. Configure sync script
Update the variables in the sync script:
- `WSL_PROJECT_PATH`: Your WSL project location (e.g., `~/wsl-projs/project-name/`)
- `DROPBOX_PATH`: Your Dropbox destination (e.g., `/mnt/c/Users/USERNAME/Dropbox/PATH/TO/PROJECT/`)
- `PROJECT_NAME`: Your project name

### 3. Make script executable
```bash
chmod +x utils/sync.sh
```

## Workflow

1. **Work locally in WSL** - Make all changes in `~/wsl-projs/project-name/`
2. **Sync regularly** - Run `./utils/sync.sh` to push changes to Dropbox
3. **Changes appear in Dropbox** - Files are reflected in the mounted Dropbox folder

## Benefits
- Fast file operations in WSL
- No Dropbox sync delays during development
- R/Python packages cached locally
- Dropbox backup maintained

## Excluded from sync
- `renv/` directories (library, staging, cache, local)
- R project files (.Rproj.user, .Rhistory, .RData, .Ruserdata)
- Add more exclusions in the script arrays as needed

## Git Ignored Files Scanner (`scan.sh`)

### Purpose
Tracks which files are being ignored by git and ensures directory structure is preserved by adding `.gitkeep` files.

### Usage
```bash
./utils/scan.sh
```

### What it does
1. **Logs ignored files** - Creates `ignored_files.log` listing all git-ignored files
2. **Preserves structure** - Adds `.gitkeep` to directories containing ignored files
3. **Forces tracking** - Adds the log file to git (even though it may be ignored)

### When to use
- Before committing to ensure important directories aren't lost
- To audit what's being excluded from version control
- When setting up a new project from template

### Output
- `ignored_files.log` - List of all ignored files (added to git)
- `.gitkeep` files - Empty files ensuring directories are tracked
