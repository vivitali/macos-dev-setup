# macOS Dev Setup

Minimal, declarative macOS setup for **web + mobile** development. Apps live in
a [`Brewfile`](Brewfile); [`setup.sh`](setup.sh) is a thin bootstrap that installs
Homebrew, runs `brew bundle`, and wires up shell + languages + mobile toolchains.

Free/open-source apps only. No paid tools, no accounts required.

## Quick start

```bash
git clone <this-repo> && cd macos-dev-setup
chmod +x setup.sh
./setup.sh            # interactive
./setup.sh --yes      # non-interactive (skips name/email/ssh prompts)
```

Choose what gets installed by **editing the `Brewfile`** — comment a line to skip,
uncomment items under `OPTIONAL` to add. That replaces the old `--minimal/--full` modes.

## What you get

| Area | Tools |
|------|-------|
| Core CLI | git, git-delta, **gh**, **lazygit**, mas |
| Languages | **nvm** → Node LTS (+corepack), **uv** → Python, **go** |
| Shell | starship + zsh-autosuggestions + zsh-syntax-highlighting |
| Modern CLI | bat, eza, fd, fzf, ripgrep, jq, httpie, wget, btop |
| Editor / Browsers | VS Code, Chrome, Firefox Dev Edition |
| AI | **Claude desktop** + **Claude Code** (CLI) |
| Terminal | **Ghostty** (free, no account) |
| API / DB | **Bruno**, **DBeaver**, PostgreSQL 17 |
| Mobile | watchman, cocoapods, **Flutter**, **Android Studio**, JDK 17, Xcode¹ |
| Productivity | Rectangle, Raycast, **Shottr** |

¹ Xcode is App Store–only (free); `setup.sh` guides you. It provides the iOS Simulator.

## Why these choices

Minimal = no redundancy, free, low maintenance.

- **Brewfile, not a 1000-line menu** — declarative, idempotent, easy to diff/edit.
- **nvm + uv kept** (your call) — battle-tested for RN/web; uv is best-in-class for
  Python. nvm's only cost is shell-startup latency. *Alternative:* `mise` manages
  node+python+go in one tool, but adds a tool to learn — not worth switching if you
  like nvm/uv.
- **corepack** instead of `npm i -g yarn pnpm` — no global installs.
- **starship + plugins** instead of Oh My Zsh — faster shell, less framework.
- **gh + lazygit** instead of GitHub Desktop — free, scriptable.
- **Claude Code via native installer** — auto-updating; npm method is deprecated,
  brew cask lags ~1 week.

### Paid → free swaps

| Was (paid/account) | Now (free) |
|--------------------|------------|
| CleanShot X | Shottr |
| TablePlus | DBeaver Community |
| Warp | Ghostty |
| Postman | Bruno |
| WebStorm | VS Code (+ Cursor optional) |
| GitHub Desktop | gh + lazygit |
| Docker Desktop | OrbStack (optional) |

## Customizing

- **Web only?** Comment out the `MOBILE` block in the `Brewfile`.
- **Need Mongo/MySQL/Redis/Docker?** Uncomment under `OPTIONAL`.
- **Postgres** isn't auto-started (saves battery). Start it when needed:
  `brew services start postgresql@17`.

## Post-install

```bash
source ~/.zshrc                       # load shell config
flutter doctor --android-licenses     # after opening Android Studio once
claude                                # sign in to Claude Code
```

`setup.sh` also offers to add the **Serena** MCP server (semantic code tools) to
Claude Code via uv. To do it later:

```bash
uv tool install -p 3.13 serena-agent
serena setup claude-code              # or: claude mcp add --scope user serena -- serena start-mcp-server --context claude-code --project-from-cwd
```

## Update everything

```bash
brew update && brew upgrade && brew bundle --file=./Brewfile
nvm install --lts                     # newer Node LTS
```

## Troubleshooting

- **`brew` not found after install:** `source ~/.zprofile` or restart terminal.
- **Xcode CLT popup hangs:** finish the GUI install, re-run `./setup.sh`.
- **Mobile checks failing:** `flutter doctor` lists exactly what's missing.

## License

MIT — see [LICENSE](LICENSE).
