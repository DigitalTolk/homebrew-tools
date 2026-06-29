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

# Safety guard: seeding copies the working tree over the tap's checkout, which
# is exactly what we want on an ephemeral CI runner but destructive on a real
# workstation — it leaves your consumer tap serving uncommitted/stale casks, so
# `brew upgrade` stops tracking GitHub's main (this is how the local clone ended
# up pinned to a "test" branch serving 0.0.7). Refuse to clobber a tap whose
# origin is a real GitHub remote unless we're in CI (GITHUB_ACTIONS=true) or the
# caller explicitly opts in with FORCE=1.
origin_url="$(git -C "$tap_dir" remote get-url origin 2>/dev/null || true)"
if [[ "$origin_url" == *github.com* ]] \
  && [ "${GITHUB_ACTIONS:-}" != "true" ] \
  && [ "${FORCE:-}" != "1" ]; then
  echo "refusing to seed $tap: its origin is a GitHub remote ($origin_url)." >&2
  echo "this looks like a real consumer tap, not an ephemeral CI checkout." >&2
  echo "run in CI, or set FORCE=1 to override (it will overwrite your tap)." >&2
  exit 1
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
