#!/usr/bin/env bash
set -euo pipefail

tap="digitaltolk/tools"
cask="Casks/ex.rb"

tap_dir="$(brew --repo "$tap" 2>/dev/null || true)"
if [ -z "$tap_dir" ]; then
  brew tap "$tap"
  tap_dir="$(brew --repo "$tap")"
fi

mkdir -p "$tap_dir/Casks"

target="$tap_dir/$cask"
if [ -e "$target" ] && cmp -s "$cask" "$target"; then
  exit 0
fi

cp "$cask" "$target"
