# Applications & Tools

Everything installed by this setup. All **free / open-source**. Apps are defined in
the [`Brewfile`](Brewfile); the toolchain steps run from [`setup.sh`](setup.sh).

## Core CLI

| Tool | What | Why |
|------|------|-----|
| git | version control | base of everything |
| git-delta | pretty diffs | configured as git pager by `setup.sh` |
| gh | GitHub CLI | PRs/issues/auth + GitHub Actions (`gh run`, `gh workflow`) |
| act | GitHub Actions runner | run workflows locally; needs a container runtime (OrbStack/Docker) |
| lazygit | git TUI | fast staging/branching |
| mas | Mac App Store CLI | for installing Xcode |

## Languages & runtimes

| Tool | What | Notes |
|------|------|-------|
| nvm | Node version manager | `setup.sh` installs Node LTS + runs `corepack enable` (yarn/pnpm) |
| bun | JS runtime + pkg manager | fast all-in-one runtime/bundler/test runner; Node-compatible |
| uv | Python toolchain | installer + venv + version manager (Astral); replaces pyenv/pipenv/pip-tools |
| go | Go toolchain | `~/go/bin` added to PATH |

## Shell

| Tool | What |
|------|------|
| starship | fast, minimal prompt (replaces Oh My Zsh) |
| zsh-autosuggestions | fish-style command suggestions |
| zsh-syntax-highlighting | inline command highlighting |

## Modern CLI utilities

| Tool | Replaces | What |
|------|----------|------|
| bat | cat | syntax-highlighted cat |
| eza | ls / exa | modern ls (maintained exa fork) |
| fd | find | fast, ergonomic find |
| fzf | — | fuzzy finder (keybindings wired into zsh) |
| ripgrep | grep | fast recursive search |
| jq | — | JSON processor |
| httpie | — | human-friendly HTTP client |
| wget | — | downloader |
| btop | htop/top | system monitor |

## Editor & browsers

- **Visual Studio Code** — primary editor. (Cursor optional in Brewfile.)
- **Google Chrome** — primary dev browser + DevTools.
- **Firefox Developer Edition** — cross-browser testing.

## AI (Anthropic)

- **Claude** (desktop app) — `brew install --cask claude`.
- **Claude Code** (CLI) — installed via the official native installer
  (`curl -fsSL https://claude.ai/install.sh | bash`); auto-updating. Needs a paid
  Claude plan or API access. brew cask `claude-code` is a commented alternative.

## Terminal

- **Ghostty** — fast, GPU-accelerated, free, no account (replaces Warp).

## API client & database

- **Bruno** — local, git-friendly API client; no account (replaces Postman).
- **DBeaver Community** — free multi-DB GUI (replaces TablePlus).
- **PostgreSQL 17** — lean default DB engine. Not auto-started; run
  `brew services start postgresql@17` when needed.

## Cloud / Backend

- **firebase-cli** — Firebase + Cloud Firestore: local emulators (`firebase emulators:start`),
  deploys, and project management. Provides the `firebase` command. Needs a Google
  account/project; remove from the Brewfile if you don't use Firebase.

## Mobile (Flutter / React Native / iOS + Android)

| Tool | For |
|------|-----|
| Xcode¹ | iOS SDK + **iOS Simulator** + signing |
| watchman | React Native file watching |
| cocoapods | iOS native dependencies |
| Flutter | Flutter SDK (Dart included) |
| Android Studio | Android SDK + emulator |
| temurin@17 | JDK 17 for Android/Gradle |

¹ App Store–only (free). `setup.sh` accepts the license + runs first launch, and
prints the install link if missing. Verify the whole chain with `flutter doctor`.

## Productivity (free)

- **Rectangle** — keyboard window management.
- **Raycast** — launcher / command palette (replaces Spotlight).
- **Shottr** — screenshots + annotation (replaces CleanShot X).

## Optional (commented in Brewfile)

OrbStack (Docker, lighter) · Docker Desktop · MongoDB · MySQL · Redis ·
MongoDB Compass · Cursor · Obsidian · Slack · Zoom.

## Shell config (`~/.zshrc`)

`setup.sh` appends a single guarded block (`# >>> macos-dev-setup >>>`) that sets up
Homebrew, starship, nvm, Go/Android PATH, fzf, eza aliases, and zsh plugins. Re-running
is safe — it won't duplicate the block.

## Folder structure (work + life)

`setup.sh` offers to scaffold:

```
~/Developer/   work, personal, oss, learning, sandbox, archive   (local + git, hammer icon)
~/Documents/   00-Inbox 01-Projects 02-Areas 03-Resources 04-Archive  (PARA, iCloud)
```

Code is kept out of iCloud (sync + node_modules); docs use the PARA method (organize
by actionability). See **[FOLDERS.md](FOLDERS.md)** for the full guide.
