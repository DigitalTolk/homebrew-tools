#!/usr/bin/env bash
set -euo pipefail

# Mirror the repo's Casks/ and Formula/ trees into the local Homebrew clone
# of digitaltolk/tools. `brew` only sees taps it has on disk under
# $(brew --repo), so CI runners (and any contributor who has never tapped
# this repo) need this seed step before `brew style` / `brew audit` /
# `brew install` will find our files.
#
# Idempotent: re-running with no changes is a no-op.

tap="digitaltolk/tools"

tap_dir="$(brew --repo "$tap" 2>/dev/null || true)"
if [ -z "$tap_dir" ]; then
  brew tap "$tap"
  tap_dir="$(brew --repo "$tap")"
fi

sync_tree() {
  local subdir="$1"
  if [ ! -d "$subdir" ]; then
    return 0
  fi
  mkdir -p "$tap_dir/$subdir"
  shopt -s nullglob
  for src in "$subdir"/*.rb; do
    target="$tap_dir/$src"
    if [ -e "$target" ] && cmp -s "$src" "$target"; then
      continue
    fi
    cp "$src" "$target"
  done
}

sync_tree Casks
sync_tree Formula
