#!/usr/bin/env zsh

# macOS Web Development Setup Script 2025
# Usage: chmod +x setup.sh && ./setup.sh [--auto-minimal|--auto-full|--interactive]
# Note: This script requires zsh (default on macOS Catalina+)

set -e  # Exit on any error

# Ensure we're running with zsh
if [ -z "$ZSH_VERSION" ]; then
    echo "This script requires zsh. Please run with:"
    echo "  zsh setup.sh $*"
    echo "Or simply: ./setup.sh $*"
    exit 1
fi

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Global variables
MODE="interactive"  # interactive, auto-minimal, auto-full
SELECTED_EDITOR=""
SELECTED_DATABASES=""
CONTINUE_SETUP=false

# Package lists for different modes
MINIMAL_ESSENTIAL="git"
MINIMAL_CASK="google-chrome"

FULL_ESSENTIAL="git python@3.12 postgresql@15 mongodb-community mysql redis bat fzf ripgrep tree htop jq httpie wget"
FULL_CASK="google-chrome firefox@developer-edition docker postman bruno rectangle raycast warp notion github-desktop cleanshot zoom tableplus mongodb-compass"

# Helper functions
log_info() {
    print "${BLUE}[INFO]${NC} $1"
}

log_success() {
    print "${GREEN}[SUCCESS]${NC} $1"
}

log_warning() {
    print "${YELLOW}[WARNING]${NC} $1"
}

log_error() {
    print "${RED}[ERROR]${NC} $1"
}

log_header() {
    print "${PURPLE}[SETUP]${NC} $1"
}

ask_user() {
    if [ "$MODE" != "interactive" ]; then
        return 0
    fi
    
    while true; do
        echo -n "$1 (y/n): "
        read yn
        case $yn in
            [Yy]* ) return 0;;
            [Nn]* ) return 1;;
            * ) echo "Please answer yes or no.";;
        esac
    done
}

check_command() {
    command -v "$1" >/dev/null 2>&1
}

check_app_installed() {
    local app_name="$1"
    # Check common application locations
    [ -d "/Applications/${app_name}.app" ] || [ -d "/System/Applications/${app_name}.app" ] || [ -d "$HOME/Applications/${app_name}.app" ]
}

install_cask_if_needed() {
    local cask_name="$1"
    local app_name="$2"
    
    if check_app_installed "$app_name"; then
        log_success "$app_name already installed"
        return 0
    fi
    
    if [ "$MODE" = "interactive" ]; then
        if ask_user "Install $app_name?"; then
            brew install --cask "$cask_name"
            log_success "$app_name installed successfully"
        fi
    else
        # Auto mode - install without asking
        brew install --cask "$cask_name"
        log_success "$app_name installed successfully"
    fi
}

install_brew_if_needed() {
    local formula_name="$1"
    local display_name="$2"
    
    if check_command "$formula_name" || brew list "$formula_name" &>/dev/null; then
        log_success "$display_name already installed"
        return 0
    fi
    
    if [ "$MODE" = "interactive" ]; then
        if ask_user "Install $display_name?"; then
            brew install "$formula_name"
            log_success "$display_name installed successfully"
        fi
    else
        # Auto mode - install without asking
        brew install "$formula_name"
        log_success "$display_name installed successfully"
    fi
}

# Fix homebrew path if needed
fix_homebrew_path() {
    if ! check_command brew; then
        # Try common homebrew locations
        if [ -x "/opt/homebrew/bin/brew" ]; then
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -x "/usr/local/bin/brew" ]; then
            eval "$(/usr/local/bin/brew shellenv)"
        fi
    fi
}

# Editor selection function
select_editor() {
    if [ "$MODE" = "auto-minimal" ]; then
        SELECTED_EDITOR="visual-studio-code"
        return 0
    elif [ "$MODE" = "auto-full" ]; then
        SELECTED_EDITOR="visual-studio-code cursor"
        return 0
    fi
    
    print ""
    log_header "Code Editor Selection"
    print "Please select your preferred code editor(s):"
    print "1) Visual Studio Code"
    print "2) Visual Studio Code Insiders" 
    print "3) Cursor (AI-powered)"
    print "4) WebStorm (JetBrains)"
    print "5) Multiple editors"
    print "6) Skip editor installation"
    print ""
    
    while true; do
        echo -n "Enter your choice (1-6): "
        read choice
        case $choice in
            1) SELECTED_EDITOR="visual-studio-code"; break;;
            2) SELECTED_EDITOR="visual-studio-code-insiders"; break;;
            3) SELECTED_EDITOR="cursor"; break;;
            4) SELECTED_EDITOR="webstorm"; break;;
            5) select_multiple_editors; break;;
            6) SELECTED_EDITOR=""; break;;
            *) print "Please enter a number between 1-6.";;
        esac
    done
}

select_multiple_editors() {
    local editors=()
    print ""
    print "Select multiple editors (press Enter when done):"
    
    while true; do
        print "Available editors:"
        print "1) Visual Studio Code"
        print "2) Visual Studio Code Insiders"
        print "3) Cursor"
        print "4) WebStorm"
        print "0) Done selecting"
        
        echo -n "Add editor (0-4): "
        read choice
        case $choice in
            0) break;;
            1) editors+=("visual-studio-code");;
            2) editors+=("visual-studio-code-insiders");;
            3) editors+=("cursor");;
            4) editors+=("webstorm");;
            *) print "Invalid choice";;
        esac
    done
    
    SELECTED_EDITOR=$(IFS=' '; echo "${editors[*]}")
}

# Database selection function
select_databases() {
    if [ "$MODE" = "auto-minimal" ]; then
        SELECTED_DATABASES=""
        return 0
    elif [ "$MODE" = "auto-full" ]; then
        SELECTED_DATABASES="postgresql mongodb"
        return 0
    fi
    
    print ""
    log_header "Database Selection"
    print "Please select which databases to install:"
    print "1) PostgreSQL (relational database)"
    print "2) MongoDB (document database)" 
    print "3) MySQL (relational database)"
    print "4) Redis (in-memory cache)"
    print "5) Multiple databases"
    print "6) Skip database installation"
    print ""
    
    while true; do
        echo -n "Enter your choice (1-6): "
        read choice
        case $choice in
            1) SELECTED_DATABASES="postgresql"; break;;
            2) SELECTED_DATABASES="mongodb"; break;;
            3) SELECTED_DATABASES="mysql"; break;;
            4) SELECTED_DATABASES="redis"; break;;
            5) select_multiple_databases; break;;
            6) SELECTED_DATABASES=""; break;;
            *) print "Please enter a number between 1-6.";;
        esac
    done
}

select_multiple_databases() {
    local databases=()
    print ""
    print "Select multiple databases (press Enter when done):"
    
    while true; do
        print "Available databases:"
        print "1) PostgreSQL"
        print "2) MongoDB"
        print "3) MySQL"
        print "4) Redis"
        print "0) Done selecting"
        
        echo -n "Add database (0-4): "
        read choice
        case $choice in
            0) break;;
            1) databases+=("postgresql");;
            2) databases+=("mongodb");;
            3) databases+=("mysql");;
            4) databases+=("redis");;
            *) print "Invalid choice";;
        esac
    done
    
    SELECTED_DATABASES=$(IFS=' '; echo "${databases[*]}")
}

# Preview function
show_installation_preview() {
    print ""
    log_header "Installation Preview"
    print "The following applications will be installed:"
    print ""
    
    case $MODE in
        "auto-minimal")
            show_minimal_preview
            ;;
        "auto-full")
            show_full_preview
            ;;
        "interactive")
            print "📝 In interactive mode, you'll be asked to confirm each installation."
            print "   The following are available for installation:"
            print ""
            print "🖥️  Selected Editor(s):"
            if [ -n "$SELECTED_EDITOR" ]; then
                for editor in $SELECTED_EDITOR; do
                    print "  • $(echo $editor | tr '-' ' ' | sed 's/\b\w/\U&/g')"
                done
            else
                print "  • None selected"
            fi
            print ""
            print "🗄️  Selected Database(s):"
            if [ -n "$SELECTED_DATABASES" ]; then
                for db in $SELECTED_DATABASES; do
                    case $db in
                        "postgresql") print "  • PostgreSQL 15";;
                        "mongodb") print "  • MongoDB";;
                        "mysql") print "  • MySQL";;
                        "redis") print "  • Redis";;
                    esac
                done
                print "  • TablePlus (GUI)"
            else
                print "  • None selected"
            fi
            print ""
            print "   All other tools available for selection..."
            ;;
        esac
    
    print ""
    if [ "$MODE" = "interactive" ]; then
        echo -n "Press Enter to continue with setup..."
        read
    else
        print "Starting installation in 5 seconds... (Ctrl+C to cancel)"
        sleep 5
    fi
    print ""
}

show_minimal_preview() {
    print "🎯 ${CYAN}MINIMAL FRONTEND SETUP:${NC}"
    print ""
    print "📦 Essential Tools:"
    print "  • Xcode Command Line Tools"
    print "  • Homebrew (package manager)"
    print "  • Git (version control)"
    print "  • NVM + Node.js LTS (JavaScript runtime)"
    print "  • npm/yarn (package managers)"
    print ""
    print "🖥️  Code Editor:"
    if [ -n "$SELECTED_EDITOR" ]; then
        print "  • $(echo $SELECTED_EDITOR | tr '-' ' ' | sed 's/\b\w/\U&/g')"
    else
        print "  • Visual Studio Code (default)"
    fi
    print ""
    print "🌐 Browser:"
    print "  • Google Chrome"
    print ""
    print "⚡ Shell Improvements:"
    print "  • Oh My Zsh"
    print "  • Basic aliases and configurations"
    print ""
    print "📝 Note: Minimal mode focuses on core frontend development needs only"
}

show_full_preview() {
    print "🚀 ${CYAN}FULL DEVELOPMENT SETUP:${NC}"
    print ""
    print "📦 Essential Tools:"
    print "  • Xcode Command Line Tools"
    print "  • Homebrew (package manager)"
    print "  • Git (version control)"
    print "  • NVM + Node.js LTS"
    print "  • Python 3.12 + pipenv"
    print "  • Claude Code (AI assistant)"
    print ""
    print "🖥️  Code Editors:"
    if [ -n "$SELECTED_EDITOR" ]; then
        for editor in $SELECTED_EDITOR; do
            print "  • $(echo $editor | tr '-' ' ' | sed 's/\b\w/\U&/g')"
        done
    else
        print "  • Visual Studio Code"
        print "  • Cursor (AI-powered)"
    fi
    print ""
    print "🌐 Browsers:"
    print "  • Google Chrome"
    print "  • Firefox Developer Edition"
    print ""
    print "🗄️  Databases:"
    print "  • PostgreSQL 15 (default)"
    print "  • MongoDB (default)"
    print "  • TablePlus & MongoDB Compass (GUIs)"
    print ""
    print "🐳 Development Tools:"
    print "  • Docker Desktop"
    print "  • Postman (API testing)"
    print "  • Bruno (open-source API client)"
    print "  • GitHub Desktop (Git GUI)"
    print "  • Warp (modern terminal)"
    print ""
    print "🎨 Productivity & UI:"
    print "  • Rectangle (window management)"
    print "  • RayCast (productivity launcher)"
    print "  • CleanShot X (advanced screenshots)"
    print ""
    print "📱 Communication:"
    print "  • Notion (notes & project management)"
    print "  • Zoom (video conferencing)"
    print ""
    print "⚡ Shell Improvements:"
    print "  • Oh My Zsh"
    print "  • bat, fzf, ripgrep, tree, htop, jq"
    print "  • httpie, wget (HTTP tools)"
    print ""
    print "📁 Project Structure:"
    print "  • ~/Projects/{personal,work,opensource,learning}"
    print ""
    print "🔐 Security:"
    print "  • SSH key generation for GitHub"
}

# Main setup functions
setup_xcode_tools() {
    log_header "Setting up Xcode Command Line Tools..."
    
    if xcode-select -p >/dev/null 2>&1; then
        log_success "Xcode Command Line Tools already installed"
        return 0
    fi
    
    if ask_user "Install Xcode Command Line Tools?"; then
        xcode-select --install
        log_success "Xcode Command Line Tools installation initiated"
        echo "Please complete the installation in the popup window and run this script again"
        exit 0
    fi
}

setup_homebrew() {
    log_header "Setting up Homebrew..."
    
    if check_command brew; then
        log_success "Homebrew already installed"
        return 0
    fi
    
    if ask_user "Install Homebrew?"; then
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        
        # Add Homebrew to PATH - detect correct path
        if [ -d "/opt/homebrew" ]; then
            # Apple Silicon Mac
            echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/opt/homebrew/bin/brew shellenv)"
        elif [ -d "/usr/local/Homebrew" ]; then
            # Intel Mac
            echo 'eval "$(/usr/local/bin/brew shellenv)"' >> ~/.zprofile
            eval "$(/usr/local/bin/brew shellenv)"
        fi
        
        log_success "Homebrew installed successfully"
    fi
}

setup_git() {
    log_header "Setting up Git..."
    
    if check_command git; then
        log_success "Git already installed"
    elif ask_user "Install Git?"; then
        brew install git
        log_success "Git installed successfully"
    fi
    
    # Configure Git
    if ask_user "Configure Git with your name and email?"; then
        echo -n "Enter your Git username: "
        read git_username
        echo -n "Enter your Git email: "
        read git_email
        
        git config --global user.name "$git_username"
        git config --global user.email "$git_email"
        git config --global init.defaultBranch main
        git config --global pull.rebase false
        
        log_success "Git configured successfully"
    fi
}

setup_terminal() {
    log_header "Setting up Warp Terminal..."
    
    if [ "$MODE" = "auto-minimal" ]; then
        return 0
    fi
    
    install_cask_if_needed "warp" "Warp"
}

setup_oh_my_zsh() {
    log_header "Setting up Oh My Zsh..."
    
    if [ -d "$HOME/.oh-my-zsh" ]; then
        log_success "Oh My Zsh already installed"
        return 0
    fi
    
    if ask_user "Install Oh My Zsh for better terminal experience?"; then
        RUNZSH=no sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        log_success "Oh My Zsh installed successfully"
    fi
}

setup_nvm_node() {
    log_header "Setting up NVM and Node.js..."
    
    if [ -d "$HOME/.nvm" ]; then
        log_success "NVM already installed"
    elif ask_user "Install NVM (Node Version Manager)?"; then
        curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
        
        # Source nvm
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        log_success "NVM installed successfully"
    fi
    
    # Install Node.js LTS
    if ask_user "Install Node.js LTS?"; then
        # Source nvm if not already sourced
        export NVM_DIR="$HOME/.nvm"
        [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
        
        nvm install --lts
        nvm use --lts
        nvm alias default node
        
        log_success "Node.js LTS installed successfully"
        
        # Install global packages
        if [ "$MODE" != "auto-minimal" ] && ask_user "Install global npm packages (yarn, pnpm)?"; then
            npm install -g yarn pnpm
            log_success "Global npm packages installed"
        elif [ "$MODE" = "auto-minimal" ]; then
            npm install -g yarn
            log_success "Yarn installed"
        fi
    fi
}

setup_python() {
    log_header "Setting up Python..."
    
    if [ "$MODE" = "auto-minimal" ]; then
        return 0
    fi
    
    if brew list python@3.12 &>/dev/null; then
        log_success "Python 3.12 already installed"
    elif [ "$MODE" = "interactive" ] && ask_user "Install Python 3.12?"; then
        brew install python@3.12
        brew link python@3.12
        log_success "Python 3.12 installed successfully"
    elif [ "$MODE" != "interactive" ]; then
        brew install python@3.12
        brew link python@3.12
        log_success "Python 3.12 installed successfully"
    fi
    
    if [ "$MODE" = "interactive" ] && ask_user "Install pipenv for Python virtual environments?"; then
        pip3 install pipenv
        log_success "Pipenv installed successfully"
    elif [ "$MODE" != "interactive" ]; then
        pip3 install pipenv
        log_success "Pipenv installed successfully"
    fi
}

setup_editors() {
    log_header "Setting up code editors..."
    
    if [ -z "$SELECTED_EDITOR" ]; then
        return 0
    fi
    
    for editor in $SELECTED_EDITOR; do
        case $editor in
            "visual-studio-code")
                install_cask_if_needed "visual-studio-code" "Visual Studio Code"
                ;;
            "visual-studio-code-insiders")
                install_cask_if_needed "visual-studio-code-insiders" "Visual Studio Code - Insiders"
                ;;
            "cursor")
                install_cask_if_needed "cursor" "Cursor"
                ;;
            "webstorm")
                install_cask_if_needed "webstorm" "WebStorm"
                ;;
        esac
    done
}

setup_browsers() {
    log_header "Setting up browsers..."
    
    install_cask_if_needed "google-chrome" "Google Chrome"
    
    if [ "$MODE" != "auto-minimal" ]; then
        install_cask_if_needed "firefox@developer-edition" "Firefox Developer Edition"
    fi
}

setup_development_tools() {
    log_header "Setting up development tools..."
    
    if [ "$MODE" = "auto-minimal" ]; then
        return 0
    fi
    
    install_cask_if_needed "docker" "Docker"
    install_cask_if_needed "postman" "Postman"
    install_cask_if_needed "bruno" "Bruno"
    install_cask_if_needed "github-desktop" "GitHub Desktop"
    install_cask_if_needed "rectangle" "Rectangle"
    install_cask_if_needed "raycast" "Raycast"
    install_cask_if_needed "notion" "Notion"
    install_cask_if_needed "cleanshot" "CleanShot X"
    install_cask_if_needed "zoom" "Zoom"
}

setup_claude_code() {
    log_header "Setting up Claude Code..."
    
    if [ "$MODE" = "auto-minimal" ]; then
        return 0
    fi
    
    if check_command claude-code || command -v claude &>/dev/null; then
        log_success "Claude Code already installed"
        return 0
    fi
    
    if [ "$MODE" = "interactive" ] && ask_user "Install Claude Code (AI coding assistant)?"; then
        if check_command npm; then
            npm install -g @anthropic-ai/claude-code
            log_success "Claude Code installed successfully"
        else
            log_warning "npm not found. Please install Node.js first, then run: npm install -g @anthropic-ai/claude-code"
        fi
    elif [ "$MODE" != "interactive" ]; then
        if check_command npm; then
            npm install -g @anthropic-ai/claude-code
            log_success "Claude Code installed successfully"
        else
            log_warning "npm not found. Skipping Claude Code installation"
        fi
    fi
}

setup_shell_improvements() {
    log_header "Setting up shell improvements..."
    
    if [ "$MODE" = "auto-minimal" ]; then
        return 0
    fi
    
    if [ "$MODE" = "interactive" ]; then
        if ask_user "Install modern shell tools (bat,  fzf, ripgrep)?"; then
            install_brew_if_needed "bat" "bat"
            install_brew_if_needed "fzf" "fzf"
            install_brew_if_needed "ripgrep" "ripgrep"
            install_brew_if_needed "tree" "tree"
            install_brew_if_needed "htop" "htop"
            install_brew_if_needed "jq" "jq"
        fi
        
        if ask_user "Install developer utilities (httpie, wget)?"; then
            install_brew_if_needed "httpie" "httpie"
            install_brew_if_needed "wget" "wget"
        fi
    else
        # Auto mode - install all shell improvements
        install_brew_if_needed "bat" "bat"
        install_brew_if_needed "fzf" "fzf"
        install_brew_if_needed "ripgrep" "ripgrep"
        install_brew_if_needed "tree" "tree"
        install_brew_if_needed "htop" "htop"
        install_brew_if_needed "jq" "jq"
        install_brew_if_needed "httpie" "httpie"
        install_brew_if_needed "wget" "wget"
    fi
}

setup_databases() {
    log_header "Setting up databases..."
    
    if [ "$MODE" = "auto-minimal" ] || [ -z "$SELECTED_DATABASES" ]; then
        return 0
    fi
    
    # Always install database GUIs if any database is selected
    if [ -n "$SELECTED_DATABASES" ]; then
        install_cask_if_needed "tableplus" "TablePlus"
        install_cask_if_needed "mongodb-compass" "MongoDB Compass"
    fi
    
    for database in $SELECTED_DATABASES; do
        case $database in
            "postgresql")
                if brew list postgresql@15 &>/dev/null; then
                    log_success "PostgreSQL already installed"
                else
                    brew install postgresql@15
                    brew services start postgresql@15
                    log_success "PostgreSQL installed and started"
                fi
                ;;
            "mongodb")
                if brew list mongodb-community &>/dev/null; then
                    log_success "MongoDB already installed"
                else
                    # Add MongoDB tap
                    brew tap mongodb/brew
                    brew install mongodb-community
                    brew services start mongodb-community
                    log_success "MongoDB installed and started"
                fi
                ;;
            "mysql")
                if brew list mysql &>/dev/null; then
                    log_success "MySQL already installed"
                else
                    brew install mysql
                    brew services start mysql
                    log_success "MySQL installed and started"
                fi
                ;;
            "redis")
                if brew list redis &>/dev/null; then
                    log_success "Redis already installed"
                else
                    brew install redis
                    brew services start redis
                    log_success "Redis installed and started"
                fi
                ;;
        esac
    done
}

create_projects_directory() {
    log_header "Setting up development directories..."
    
    if [ -d "$HOME/Projects" ]; then
        log_success "Projects directory already exists"
        return 0
    fi
    
    if ask_user "Create ~/Projects directory structure?"; then
        mkdir -p ~/Projects/{personal,work,opensource,learning}
        log_success "Project directories created successfully"
    fi
}

setup_ssh_key() {
    log_header "Setting up SSH key for GitHub..."
    
    if [ "$MODE" = "auto-minimal" ]; then
        return 0
    fi
    
    if [ -f "$HOME/.ssh/id_rsa" ] || [ -f "$HOME/.ssh/id_ed25519" ]; then
        log_success "SSH key already exists"
        return 0
    fi
    
    if ask_user "Generate SSH key for GitHub?"; then
        echo -n "Enter your GitHub email: "
        read github_email
        ssh-keygen -t ed25519 -C "$github_email" -f ~/.ssh/id_ed25519 -N ""
        
        # Start ssh-agent and add key
        eval "$(ssh-agent -s)"
        ssh-add ~/.ssh/id_ed25519
        
        # Copy public key to clipboard
        pbcopy < ~/.ssh/id_ed25519.pub
        
        log_success "SSH key generated and copied to clipboard"
        log_info "Add the key to your GitHub account: https://github.com/settings/ssh/new"
    fi
}

cleanup() {
    log_header "Cleaning up..."
    brew cleanup
    log_success "Cleanup completed"
}

# Additional setup after automatic installation
ask_continue_setup() {
    if [ "$MODE" = "interactive" ]; then
        return 0
    fi
    
    print ""
    log_header "Additional Setup Options"
    print "Basic setup completed! Would you like to install additional tools?"
    print "You can now go through optional applications step by step."
    print ""
    print "📱 Available categories:"
    print "  • Additional Code Editors (Sublime Text, Neovim)"
    print "  • More Browsers (Arc, Brave, Safari Tech Preview)"
    print "  • Development Tools (Insomnia, DevToys, SourceTree, Proxyman)"
    print "  • Productivity Apps (Obsidian, Slack)"
    print ""
    
    while true; do
        echo -n "Continue with additional setup? (y/n): "
        read yn
        case $yn in
            [Yy]* ) 
                CONTINUE_SETUP=true
                MODE="interactive"  # Switch to interactive for additional setup
                break;;
            [Nn]* ) 
                CONTINUE_SETUP=false
                break;;
            * ) print "Please answer yes or no.";;
        esac
    done
}

setup_additional_editors() {
    if [ "$CONTINUE_SETUP" = false ]; then
        return 0
    fi
    
    log_header "Additional Code Editors"
    print "You can install additional code editors beyond your current selection:"
    print ""
    
    # Check what's already installed/selected and offer others
    if [[ ! "$SELECTED_EDITOR" == *"visual-studio-code"* ]]; then
        install_cask_if_needed "visual-studio-code" "Visual Studio Code"
    fi
    
    if [[ ! "$SELECTED_EDITOR" == *"visual-studio-code-insiders"* ]]; then
        install_cask_if_needed "visual-studio-code-insiders" "Visual Studio Code - Insiders"
    fi
    
    if [[ ! "$SELECTED_EDITOR" == *"cursor"* ]]; then
        install_cask_if_needed "cursor" "Cursor"
    fi
    
    if [[ ! "$SELECTED_EDITOR" == *"webstorm"* ]]; then
        install_cask_if_needed "webstorm" "WebStorm"
    fi
    
    install_cask_if_needed "sublime-text" "Sublime Text"
    
    if ask_user "Install Neovim (terminal editor)?"; then
        if check_command nvim; then
            log_success "Neovim already installed"
        else
            brew install neovim
            log_success "Neovim installed"
        fi
    fi
}

setup_additional_browsers() {
    if [ "$CONTINUE_SETUP" = false ]; then
        return 0
    fi
    
    log_header "Additional Browsers"
    
    install_cask_if_needed "arc" "Arc"
    install_cask_if_needed "brave-browser" "Brave Browser"
    install_cask_if_needed "safari-technology-preview" "Safari Technology Preview"
}

setup_additional_dev_tools() {
    if [ "$CONTINUE_SETUP" = false ]; then
        return 0
    fi
    
    log_header "Additional Development Tools"
    
    install_cask_if_needed "insomnia" "Insomnia"
    install_cask_if_needed "devtoys" "DevToys"
    install_cask_if_needed "sourcetree" "SourceTree"
    install_cask_if_needed "proxyman" "Proxyman"
}

setup_additional_productivity() {
    if [ "$CONTINUE_SETUP" = false ]; then
        return 0
    fi
    
    log_header "Additional Productivity Tools"
    
    install_cask_if_needed "obsidian" "Obsidian"
    install_cask_if_needed "slack" "Slack"
}

# Main script
main() {
    # Fix homebrew path first
    fix_homebrew_path
    
    print "🚀 macOS Web Development Setup Script 2025"
    print "==========================================="
    print ""
    
    # Parse command line arguments
    while [[ $# -gt 0 ]]; do
        case $1 in
            --auto-minimal)
                MODE="auto-minimal"
                shift
                ;;
            --auto-full)
                MODE="auto-full"
                shift
                ;;
            --interactive)
                MODE="interactive"
                shift
                ;;
            -h|--help)
                print "Usage: $0 [--auto-minimal|--auto-full|--interactive]"
                print ""
                print "Modes:"
                print "  --auto-minimal    Install only essential frontend development tools"
                print "  --auto-full       Install complete development environment"
                print "  --interactive     Ask for each installation (default)"
                print ""
                print "Features:"
                print "  • After automatic modes, option to add more tools step-by-step"
                print "  • Database selection (PostgreSQL, MongoDB, MySQL, Redis)"
                print "  • Editor selection (VSCode, Cursor, WebStorm, etc.)"
                print "  • Modern 2025 developer stack with productivity tools"
                print ""
                print "Minimal includes: Git, Node.js, VSCode, Chrome"
                print "Full includes: All tools, databases, Docker, productivity apps"
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                print "Use --help for usage information"
                exit 1
                ;;
        esac
    done
    
    log_info "Mode: $MODE"
    print ""
    
    # Select editor
    select_editor
    
    # Select databases
    select_databases
    
    # Show preview
    show_installation_preview
    
    # Run setup functions
    setup_xcode_tools
    setup_homebrew
    setup_git
    setup_terminal
    setup_oh_my_zsh
    setup_nvm_node
    setup_python
    setup_editors
    setup_browsers
    setup_development_tools
    setup_claude_code
    setup_shell_improvements
    setup_databases
    create_projects_directory
    setup_ssh_key
    
    # Ask if user wants to continue with additional setup (only for auto modes)
    ask_continue_setup
    
    # Additional setup steps (only if user chose to continue)
    if [ "$CONTINUE_SETUP" = true ]; then
        print ""
        log_success "🔧 Starting additional setup..."
        print "You can now customize your installation with more tools:"
        print ""
        
        setup_additional_editors
        setup_additional_browsers
        setup_additional_dev_tools
        setup_additional_productivity
    fi
    
    cleanup
    
    print ""
    log_success "🎉 Setup completed successfully!"
    print ""
    if [ "$CONTINUE_SETUP" = true ]; then
        print "✨ Additional tools have been installed based on your selections."
        print ""
    fi
    print "Next steps:"
    print "1. Restart your terminal or run: source ~/.zshrc"
    print "2. Configure your code editor with extensions"
    if [ "$MODE" != "auto-minimal" ]; then
        print "3. Add your SSH key to GitHub if generated"
        print "4. Customize your shell theme and aliases"
        if [ "$CONTINUE_SETUP" = true ]; then
            print "5. Explore your new productivity tools and development apps"
        fi
    fi
    print ""
    print "Happy coding! 💻✨"
}

# Run the main function
main "$@"
