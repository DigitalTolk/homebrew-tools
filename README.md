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

## Install keel

```sh
brew install DigitalTolk/tools/keel
```

`keel` is a Go CLI from [`DigitalTolk/keel`](https://github.com/DigitalTolk/keel) —
the first step in server setup: it prepares a fresh host and runs the recurring
ops around it (backups, security-group updates, VM creation).

## Maintenance

- `scripts/update-ex-cask.rb` reads the latest `DigitalTolk/ex-electron` release
  and updates `Casks/ex.rb` with the new version and SHA-256 digest. A
  scheduled GitHub Action runs it every six hours and opens a PR when the
  cask changes.
- `scripts/update-exec-ecs-formula.rb` reads the latest `DigitalTolk/exec-ecs`
  release and updates `Formula/exec-ecs.rb` with the new version and SHA-256
  digests. A scheduled GitHub Action runs it every six hours and opens a PR
  when the formula changes.
- `scripts/update-keel-formula.rb` reads the latest `DigitalTolk/keel` release
  and updates `Formula/keel.rb` with the new version and SHA-256 digests. A
  scheduled GitHub Action runs it every six hours and opens a PR when the
  formula changes.

CI runs `brew style` and `brew audit --strict --online` against every
`Casks/*.rb` and `Formula/*.rb` on pull requests and pushes to `main`.
