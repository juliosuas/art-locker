#!/usr/bin/env bash
set -euo pipefail

repo_name="${1:-monet-locker}"

gh auth status >/dev/null

git status --short
if [ -n "$(git status --porcelain)" ]; then
  echo "Working tree is dirty. Commit changes before publishing." >&2
  exit 1
fi

if ! git remote get-url origin >/dev/null 2>&1; then
  gh repo create "$repo_name" \
    --public \
    --source=. \
    --remote=origin \
    --description "Experimental art-first lock screen for XFCE/X11 multi-monitor desktops"
fi

git push -u origin main

if ! gh issue list --repo "$(gh repo view --json nameWithOwner -q .nameWithOwner)" \
    --search "Harden monitor sleep/wake and fullscreen lock reliability in:title" \
    --json number -q '.[0].number' | grep -q .; then
  gh issue create \
    --title "Harden monitor sleep/wake and fullscreen lock reliability" \
    --body-file docs/initial-issue.md
fi

gh repo view --web
