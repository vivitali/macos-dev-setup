#!/usr/bin/env bash
# macOS dev setup — thin bootstrap around ./Brewfile
# Apps live in the Brewfile (edit it to choose). This script just installs
# Homebrew, runs `brew bundle`, and wires up shell + languages + mobile.
#
# Usage: ./setup.sh [-y|--yes] [--skip-bundle] [-h|--help]
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BREWFILE="$SCRIPT_DIR/Brewfile"
ASSUME_YES=false
SKIP_BUNDLE=false

# ---- args -------------------------------------------------------------------
while [ $# -gt 0 ]; do
  case "$1" in
    -y|--yes) ASSUME_YES=true ;;
    --skip-bundle) SKIP_BUNDLE=true ;;
    -h|--help)
      cat <<'EOF'
macOS dev setup
  ./setup.sh            install everything in ./Brewfile + configure shell/langs
  -y, --yes             assume yes (skips interactive name/email/ssh prompts)
      --skip-bundle     skip 'brew bundle' (run only config steps)
  -h, --help            this help

Choose apps by editing ./Brewfile (comment/uncomment lines).
EOF
      exit 0 ;;
    *) echo "Unknown option: $1 (try --help)"; exit 1 ;;
  esac
  shift
done

# ---- ui ---------------------------------------------------------------------
c_blue=$'\033[0;34m'; c_green=$'\033[0;32m'; c_yellow=$'\033[1;33m'; c_red=$'\033[0;31m'; c_nc=$'\033[0m'
info(){ printf "%s[*]%s %s\n" "$c_blue"  "$c_nc" "$1"; }
ok(){   printf "%s[ok]%s %s\n" "$c_green" "$c_nc" "$1"; }
warn(){ printf "%s[!]%s %s\n"  "$c_yellow" "$c_nc" "$1"; }
err(){  printf "%s[x]%s %s\n"  "$c_red"  "$c_nc" "$1" >&2; }
confirm(){ # $1 = prompt
  $ASSUME_YES && return 0
  local a=""
  printf "%s [y/N] " "$1"; read -r a || true
  [ "$a" = y ] || [ "$a" = Y ] || [ "$a" = yes ]
}

# ---- guards -----------------------------------------------------------------
[ "$(uname)" = Darwin ] || { err "macOS only."; exit 1; }
[ "$(id -u)" -ne 0 ]   || { err "Do not run as root."; exit 1; }

# ---- xcode command line tools ----------------------------------------------
install_clt(){
  if xcode-select -p >/dev/null 2>&1; then ok "Xcode Command Line Tools"; return; fi
  info "Installing Xcode Command Line Tools..."
  xcode-select --install 2>/dev/null || true
  warn "Finish the popup install, then re-run this script."
  exit 0
}

# ---- homebrew ---------------------------------------------------------------
install_brew(){
  if ! command -v brew >/dev/null 2>&1; then
    confirm "Install Homebrew?" || { err "Homebrew required."; exit 1; }
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  fi
  if   [ -x /opt/homebrew/bin/brew ]; then eval "$(/opt/homebrew/bin/brew shellenv)"
  elif [ -x /usr/local/bin/brew ];   then eval "$(/usr/local/bin/brew shellenv)"; fi
  ok "Homebrew ready"
}

# ---- brew bundle (the apps) -------------------------------------------------
run_bundle(){
  $SKIP_BUNDLE && { warn "Skipping brew bundle"; return; }
  [ -f "$BREWFILE" ] || { err "Brewfile not found at $BREWFILE"; exit 1; }
  info "Installing from Brewfile (large casks: Android Studio, Flutter)..."
  brew update || true
  brew bundle --file="$BREWFILE" || warn "Some Brewfile items failed; continuing."
  ok "Brewfile processed"
}

# ---- git --------------------------------------------------------------------
setup_git(){
  if ! $ASSUME_YES && ! git config --global user.name >/dev/null 2>&1; then
    if confirm "Configure git name/email?"; then
      local n="" e=""
      printf "  name:  "; read -r n || true
      printf "  email: "; read -r e || true
      [ -n "$n" ] && git config --global user.name  "$n"
      [ -n "$e" ] && git config --global user.email "$e"
    fi
  fi
  git config --global init.defaultBranch main
  git config --global pull.rebase false
  if command -v delta >/dev/null 2>&1; then
    git config --global core.pager delta
    git config --global interactive.diffFilter "delta --color-only"
    git config --global delta.navigate true
  fi
  ok "git configured"
}

# ---- node via nvm -----------------------------------------------------------
setup_node(){
  command -v brew >/dev/null 2>&1 || return
  export NVM_DIR="$HOME/.nvm"; mkdir -p "$NVM_DIR"
  if [ ! -s "$(brew --prefix)/opt/nvm/nvm.sh" ]; then warn "nvm not installed (check Brewfile)"; return; fi
  # shellcheck disable=SC1091
  . "$(brew --prefix)/opt/nvm/nvm.sh"
  if confirm "Install Node.js LTS via nvm?"; then
    nvm install --lts
    nvm alias default 'lts/*' >/dev/null
    corepack enable 2>/dev/null || true   # yarn/pnpm without global installs
    ok "Node $(node -v) + corepack (yarn/pnpm)"
  fi
}

# ---- python via uv ----------------------------------------------------------
setup_python(){
  command -v uv >/dev/null 2>&1 || { warn "uv not installed (check Brewfile)"; return; }
  if confirm "Install latest Python via uv?"; then
    uv python install
    ok "Python ready via uv"
  fi
}

# ---- claude code (official native installer, auto-updating) -----------------
setup_claude_code(){
  if command -v claude >/dev/null 2>&1; then ok "Claude Code already installed"; return; fi
  if confirm "Install Claude Code CLI (native installer)?"; then
    curl -fsSL https://claude.ai/install.sh | bash \
      || warn "Claude Code install failed; alt: brew install --cask claude-code"
  fi
}

# ---- serena MCP server (optional, for Claude Code) -------------------------
# Serena = semantic code tools (LSP-based) exposed to Claude Code over MCP.
# Installed as a uv tool; registered with `claude mcp add`.
setup_serena(){
  command -v uv >/dev/null 2>&1 || { warn "uv needed for Serena; skipping"; return; }
  export PATH="$HOME/.local/bin:$PATH"   # uv tools + claude live here
  command -v claude >/dev/null 2>&1 || { warn "Claude Code needed for Serena; skipping"; return; }
  confirm "Add Serena MCP (semantic code tools) to Claude Code?" || return
  info "Installing serena-agent via uv..."
  uv tool install -p 3.13 serena-agent || { warn "serena install failed"; return; }
  if claude mcp list 2>/dev/null | grep -qi serena; then
    ok "Serena already registered in Claude Code"
  else
    claude mcp add --scope user serena -- serena start-mcp-server --context claude-code --project-from-cwd \
      && ok "Serena MCP added to Claude Code (user scope)" \
      || warn "Could not register Serena; run later: serena setup claude-code"
  fi
}

# ---- shell config (~/.zshrc managed block) ---------------------------------
ZSHRC="$HOME/.zshrc"
write_shell_config(){
  local marker="# >>> macos-dev-setup >>>"
  if [ -f "$ZSHRC" ] && grep -qF "$marker" "$ZSHRC"; then ok "~/.zshrc already configured"; return; fi
  info "Adding shell config to ~/.zshrc"
  cat >> "$ZSHRC" <<'EOF'

# >>> macos-dev-setup >>>
# Homebrew (safe if already in PATH)
command -v brew >/dev/null || eval "$(/opt/homebrew/bin/brew shellenv 2>/dev/null || /usr/local/bin/brew shellenv 2>/dev/null)"

# User-local bins (uv tools, Claude Code, Serena)
export PATH="$HOME/.local/bin:$PATH"

# Starship prompt (replaces Oh My Zsh)
command -v starship >/dev/null && eval "$(starship init zsh)"

# nvm
export NVM_DIR="$HOME/.nvm"
[ -s "$(brew --prefix)/opt/nvm/nvm.sh" ] && . "$(brew --prefix)/opt/nvm/nvm.sh"
[ -s "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm" ] && . "$(brew --prefix)/opt/nvm/etc/bash_completion.d/nvm"

# Go
export PATH="$HOME/go/bin:$PATH"

# Android SDK (populated after Android Studio first-run)
export ANDROID_HOME="$HOME/Library/Android/sdk"
export PATH="$ANDROID_HOME/platform-tools:$ANDROID_HOME/emulator:$PATH"

# fzf keybindings + completion
command -v fzf >/dev/null && source <(fzf --zsh)

# Aliases
alias ls='eza --icons --git'
alias ll='eza -la --icons --git'
alias la='eza -a --icons'
alias lt='eza --tree --level=2 --icons'
# alias cat='bat'   # uncomment for syntax-highlighted cat

# zsh plugins (syntax-highlighting MUST be sourced last)
source "$(brew --prefix)/share/zsh-autosuggestions/zsh-autosuggestions.zsh" 2>/dev/null
source "$(brew --prefix)/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" 2>/dev/null
# <<< macos-dev-setup <<<
EOF
  ok "~/.zshrc updated"
}

# ---- folder structure (code + life via PARA) -------------------------------
print_folder_recommendations(){
  cat <<'EOF'

  -- How to use your folders --------------------------------------------------
  CODE  (~/Developer)  keep code OUT of iCloud/Documents (sync + node_modules pain)
    clone into work/ personal/ oss/ learning/ ; spikes -> sandbox/ ; dead -> archive/
  DOCS  (~/Documents, PARA)  organize by ACTIONABILITY, not topic
    00-Inbox     default dump; process to empty weekly
    01-Projects  has a deadline/goal -> when done, move to 04-Archive
    02-Areas     life you maintain (Finances, Health, Home, Career, Personal)
    03-Resources reference you consult (templates, docs, inspiration)
    04-Archive   cold storage; still searchable
  HABITS
    ~/Downloads = inbox, not storage -- clear it weekly
    name dated files: YYYY-MM-DD_name_vN
    use Finder Tags (Current/Waiting) + Smart Folders to cut across PARA
    back up: Time Machine (docs) + git remotes (code)
  Full guide: FOLDERS.md in this repo
  ----------------------------------------------------------------------------
EOF
}

make_folders(){
  confirm "Create folder structure (~/Developer + ~/Documents PARA)?" || return
  local code="$HOME/Developer" docs="$HOME/Documents"

  # Code (local only, never iCloud-synced)
  mkdir -p "$code"/{work,personal,oss,learning,sandbox,archive}

  # Life + work docs (iCloud-syncable): PARA + Inbox, numbered for auto-sort
  mkdir -p "$docs"/00-Inbox "$docs"/01-Projects \
           "$docs"/02-Areas/{Career,Finances,Health,Home,Personal} \
           "$docs"/03-Resources "$docs"/04-Archive

  # Self-documenting READMEs (never clobber existing files)
  [ -e "$code/README.md" ] || cat > "$code/README.md" <<'EOF'
# ~/Developer — source code only (keep OUT of iCloud)

- work/      employer & client repos
- personal/  your own projects
- oss/       open-source clones & forks
- learning/  courses, tutorials, katas
- sandbox/   throwaway spikes (delete freely)
- archive/   dormant repos you might revisit

Conventions: kebab-case repo names, one repo = one folder.
Back up via git remotes, not Time Machine alone.
EOF
  [ -e "$docs/README.md" ] || cat > "$docs/README.md" <<'EOF'
# ~/Documents — PARA (organize by actionability)

- 00-Inbox/     drop anything here; sort weekly to empty
- 01-Projects/  active efforts WITH a finish line (work + life)
- 02-Areas/     ongoing responsibilities, NO end date
                (Career, Finances, Health, Home, Personal)
- 03-Resources/ reference material & topics of interest
- 04-Archive/   finished/inactive items from the three above

Move a Project to 04-Archive when done.
Dated files: YYYY-MM-DD_name_vN.
EOF

  ok "Folders created (~/Developer, ~/Documents PARA)"
  print_folder_recommendations
}

# ---- ssh key ----------------------------------------------------------------
setup_ssh(){
  if [ -f "$HOME/.ssh/id_ed25519" ]; then ok "SSH key exists"; return; fi
  if ! $ASSUME_YES && confirm "Generate SSH key (ed25519) for GitHub?"; then
    local ge=""
    printf "  github email: "; read -r ge || true
    ssh-keygen -t ed25519 -C "${ge:-$USER@$(hostname)}" -f "$HOME/.ssh/id_ed25519" -N ""
    eval "$(ssh-agent -s)" >/dev/null
    ssh-add "$HOME/.ssh/id_ed25519" 2>/dev/null || true
    pbcopy < "$HOME/.ssh/id_ed25519.pub"
    ok "SSH public key copied to clipboard"
    info "Add it:  gh ssh-key add ~/.ssh/id_ed25519.pub   (or https://github.com/settings/ssh/new)"
  fi
}

# ---- mobile post-install ----------------------------------------------------
mobile_postinstall(){
  if [ -d /Applications/Xcode.app ]; then
    if confirm "Xcode: accept license + first launch (needs sudo)?"; then
      sudo xcodebuild -license accept || true
      sudo xcode-select -s /Applications/Xcode.app/Contents/Developer || true
      sudo xcodebuild -runFirstLaunch || true
    fi
  else
    warn "Xcode not found — required for iOS builds + simulator (App Store only, free)."
    info "Install it, then:  open 'macappstore://apps.apple.com/app/id497799835'"
  fi
  if command -v flutter >/dev/null 2>&1; then
    info "Android: open Android Studio once -> install SDK + create an emulator."
    info "Then:  flutter doctor --android-licenses"
    info "Checking toolchain (flutter doctor)..."; flutter doctor || true
  fi
}

# ---- main -------------------------------------------------------------------
main(){
  printf "\n%s== macOS dev setup ==%s\n\n" "$c_blue" "$c_nc"
  install_clt
  install_brew
  run_bundle
  setup_git
  setup_node
  setup_python
  setup_claude_code
  setup_serena
  write_shell_config
  make_folders
  setup_ssh
  mobile_postinstall
  printf "\n"; ok "Done."
  cat <<'EOF'

Next steps:
  1. Restart terminal      (or: source ~/.zshrc)
  2. Postgres when needed:  brew services start postgresql@17
  3. Mobile:  install Xcode from App Store; open Android Studio -> SDK
  4. Sign in:  claude            (Claude Code CLI)
              open -a Claude     (Claude desktop app)
EOF
}
main
