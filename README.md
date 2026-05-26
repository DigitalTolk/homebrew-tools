# DigitalTolk Homebrew Tools

Homebrew tap for DigitalTolk tooling — both Casks (desktop apps) and
Formulae (CLI tools).

## Install ex

```sh
brew install DigitalTolk/tools/ex
```

The `ex` cask installs the Apple Silicon macOS DMG from
[`DigitalTolk/ex-electron`](https://github.com/DigitalTolk/ex-electron).
Upgrades use normal Homebrew cask behavior:

```sh
brew update
brew upgrade DigitalTolk/tools/ex
```

## Install exec-ecs

```sh
brew install DigitalTolk/tools/exec-ecs
```

`exec-ecs` is a Go CLI from [`DigitalTolk/exec-ecs`](https://github.com/DigitalTolk/exec-ecs)
that wraps `aws ecs execute-command` with an interactive picker.

## Maintenance

- `scripts/update-ex-cask.rb` reads the latest `DigitalTolk/ex-electron` release
  and updates `Casks/ex.rb` with the new version and SHA-256 digest. A
  scheduled GitHub Action runs it every six hours and opens a PR when the
  cask changes.
- `Formula/exec-ecs.rb` is maintained automatically by
  [GoReleaser](https://goreleaser.com/) on the upstream repo: each release
  opens a PR here with the new version, URLs, and checksums. No local
  script is needed.

CI runs `brew style` and `brew audit --strict --online` against every
`Casks/*.rb` and `Formula/*.rb` on pull requests and pushes to `main`.
