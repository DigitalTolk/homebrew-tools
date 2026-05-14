# DigitalTolk Homebrew Tools

Homebrew tap for DigitalTolk desktop tooling.

## Install ex

```sh
brew install DigitalTolk/tools/ex
```

The current `ex` cask installs the Apple Silicon macOS DMG from
[`DigitalTolk/ex-electron`](https://github.com/DigitalTolk/ex-electron).
Upgrades use normal Homebrew cask behavior:

```sh
brew update
brew upgrade DigitalTolk/tools/ex
```

## Maintenance

`scripts/update-ex-cask.rb` reads the latest `DigitalTolk/ex-electron` release
from the GitHub API, finds the `ex-<version>-mac-arm64.dmg` asset, and updates
`Casks/ex.rb` with the release version and SHA-256 digest.

GitHub Actions run Homebrew linting on pull requests and `main`. A scheduled
workflow checks for new `ex-electron` releases every six hours and opens a pull
request when the cask changes.
