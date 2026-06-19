# Brewfile — macOS dev setup (web + mobile + Go + Python)
# Declarative install list. Run:  brew bundle --file=./Brewfile
# Edit freely: comment a line to skip, uncomment OPTIONAL items to add.

# ----------------------------------------------------------------------------
# Core CLI
# ----------------------------------------------------------------------------
brew "git"
brew "git-delta"          # better git diffs (configured by setup.sh)
brew "gh"                 # GitHub CLI (replaces GitHub Desktop)
brew "lazygit"            # fast git TUI
brew "mas"                # Mac App Store CLI (for Xcode, see MOBILE)

# Language runtimes / version managers
brew "nvm"                # Node version manager (Node installed by setup.sh)
brew "uv"                 # Python: installer + venv + version manager (Astral)
brew "go"                 # Go toolchain

# ----------------------------------------------------------------------------
# Shell (lightweight; replaces Oh My Zsh)
# ----------------------------------------------------------------------------
brew "starship"                 # prompt
brew "zsh-autosuggestions"
brew "zsh-syntax-highlighting"

# ----------------------------------------------------------------------------
# Modern CLI tools
# ----------------------------------------------------------------------------
brew "bat"                # cat + syntax highlight
brew "eza"               # modern ls (maintained exa fork)
brew "fd"                 # modern find
brew "fzf"                # fuzzy finder
brew "ripgrep"            # fast grep
brew "jq"                 # JSON processor
brew "httpie"             # human-friendly HTTP client
brew "wget"
brew "btop"               # system monitor (replaces htop)

# ----------------------------------------------------------------------------
# Editor + Browsers
# ----------------------------------------------------------------------------
cask "visual-studio-code"
# cask "cursor"                       # OPTIONAL: AI editor (free tier)
cask "google-chrome"
cask "firefox@developer-edition"

# ----------------------------------------------------------------------------
# AI (Anthropic)
# ----------------------------------------------------------------------------
cask "claude"                       # Claude desktop app
# Claude Code (CLI) is installed by setup.sh via the official native installer
# (auto-updating, recommended). To manage it with brew instead, uncomment:
# cask "claude-code"

# ----------------------------------------------------------------------------
# Terminal (free, no account — replaces Warp)
# ----------------------------------------------------------------------------
cask "ghostty"

# ----------------------------------------------------------------------------
# API client + Database (lean: Postgres only by default)
# ----------------------------------------------------------------------------
cask "bruno"                        # local, git-friendly (replaces Postman)
cask "dbeaver-community"            # free DB GUI (replaces TablePlus)
brew "postgresql@17"                # not auto-started; see setup.sh notes

# ----------------------------------------------------------------------------
# MOBILE — Flutter / React Native / iOS + Android
# (comment this whole block if you only do web)
# ----------------------------------------------------------------------------
brew "watchman"                     # React Native file watcher
brew "cocoapods"                    # iOS native deps
cask "flutter"                      # Flutter SDK (dart included)
cask "android-studio"               # Android SDK + emulator
cask "temurin@17"                   # JDK 17 for Android/Gradle
# Xcode: install from App Store (free). setup.sh guides you.
# mas "Xcode", id: 497799835        # uncomment if signed into App Store

# ----------------------------------------------------------------------------
# Productivity (free only)
# ----------------------------------------------------------------------------
cask "rectangle"                    # window manager
cask "raycast"                      # launcher / command palette
cask "shottr"                       # screenshots (replaces CleanShot X)

# ----------------------------------------------------------------------------
# OPTIONAL — uncomment what you need
# ----------------------------------------------------------------------------
# cask "orbstack"                   # Docker/Linux, free personal, lighter than Docker Desktop
# cask "docker"                     # Docker Desktop (heavier; license cost for big orgs)
# brew "mongodb-community"          # needs: brew tap mongodb/brew
# brew "mysql"
# brew "redis"
# cask "mongodb-compass"            # Mongo GUI
# cask "obsidian"                   # notes
# cask "slack"                      # team chat
# cask "zoom"                       # video calls
