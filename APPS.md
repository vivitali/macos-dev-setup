# 📦 Applications & Tools Reference

This document provides detailed information about every application, tool, and package included in the macOS Development Setup Script.

## 📋 Table of Contents

- [Core Development Tools](#-core-development-tools)
- [Code Editors](#-code-editors)
- [Databases & Database Tools](#-databases--database-tools)
- [Web Browsers](#-web-browsers)
- [Development & API Tools](#-development--api-tools)
- [Productivity & Utilities](#-productivity--utilities)
- [Shell & Terminal Tools](#-shell--terminal-tools)
- [Version Control & Git Tools](#-version-control--git-tools)
- [Additional Applications](#-additional-applications)

---

## 🛠 Core Development Tools

### Xcode Command Line Tools
**Installed in:** All modes  
**Purpose:** Essential build tools and compilers for macOS development

Apple's command line developer tools including:
- `clang` and `gcc` compilers
- `make` build tool
- Git version control
- Various UNIX development utilities

Required for building most open-source software on macOS.

### Homebrew
**Installed in:** All modes  
**Purpose:** Package manager for macOS  
**Website:** [brew.sh](https://brew.sh/)

The missing package manager for macOS. Installs and manages thousands of open-source packages and applications. Essential for any development environment.

### Git
**Installed in:** All modes  
**Purpose:** Distributed version control system  
**Website:** [git-scm.com](https://git-scm.com/)

Industry-standard version control system. The script also configures:
- Global username and email
- Default branch name (main)
- Pull strategy (merge)

### NVM (Node Version Manager)
**Installed in:** All modes  
**Purpose:** Manage multiple Node.js versions  
**Website:** [github.com/nvm-sh/nvm](https://github.com/nvm-sh/nvm)

Allows you to install and switch between different Node.js versions. The script installs:
- Latest LTS version of Node.js
- npm (comes with Node.js)
- yarn (global package)
- pnpm (full mode only)

### Python 3.12
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Python programming language runtime  
**Website:** [python.org](https://python.org/)

Latest stable Python version with:
- pip package manager
- pipenv for virtual environment management

### Claude Code
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** AI coding assistant for terminal  
**Website:** [docs.claude.com](https://docs.claude.com/)

Anthropic's AI assistant for developers, accessible directly from the command line for coding assistance, code reviews, and development questions.

---

## 💻 Code Editors

### Visual Studio Code
**Package:** `visual-studio-code`  
**Installed in:** All modes (default)  
**Purpose:** Lightweight, extensible code editor  
**Website:** [code.visualstudio.com](https://code.visualstudio.com/)

Microsoft's free, open-source editor with:
- Extensive extension marketplace
- Integrated terminal
- Git integration
- IntelliSense code completion
- Debugging support

### Visual Studio Code Insiders
**Package:** `visual-studio-code-insiders`  
**Installed in:** Interactive (optional)  
**Purpose:** Preview version of VS Code  
**Website:** [code.visualstudio.com/insiders](https://code.visualstudio.com/insiders)

Early access version with newest features and updates. Good for testing bleeding-edge VS Code features.

### Cursor
**Package:** `cursor`  
**Installed in:** Full mode (default), Interactive (optional)  
**Purpose:** AI-powered code editor  
**Website:** [cursor.sh](https://cursor.sh/)

VS Code fork with built-in AI assistance:
- AI code completion
- Natural language code editing
- AI chat for coding questions
- Built on VS Code foundation

### WebStorm
**Package:** `webstorm`  
**Installed in:** Interactive (optional)  
**Purpose:** Professional IDE for web development  
**Website:** [jetbrains.com/webstorm](https://www.jetbrains.com/webstorm/)

JetBrains' powerful IDE with:
- Advanced refactoring tools
- Built-in debugger
- Testing framework integration
- Code quality analysis
- Requires paid license after trial

### Sublime Text
**Package:** `sublime-text`  
**Installed in:** Additional setup only  
**Purpose:** Sophisticated text editor  
**Website:** [sublimetext.com](https://www.sublimetext.com/)

Fast, lightweight editor with:
- Multiple selections
- Command palette
- Package ecosystem
- Goto anything feature

### Neovim
**Package:** `neovim`  
**Installed in:** Additional setup only  
**Purpose:** Modern Vim editor  
**Website:** [neovim.io](https://neovim.io/)

Modernized version of Vim with:
- Improved architecture
- Better plugin support
- Built-in LSP support
- Lua scripting

---

## 🗄 Databases & Database Tools

### PostgreSQL 15
**Package:** `postgresql@15`  
**Installed in:** Full mode (default), Interactive (optional)  
**Purpose:** Advanced open-source relational database  
**Website:** [postgresql.org](https://www.postgresql.org/)

World's most advanced open-source relational database:
- ACID compliance
- Advanced SQL features
- JSON support
- Extensible architecture
- Automatically started as service

### MongoDB
**Package:** `mongodb-community`  
**Installed in:** Full mode (default), Interactive (optional)  
**Purpose:** Document-oriented NoSQL database  
**Website:** [mongodb.com](https://www.mongodb.com/)

Popular NoSQL database:
- Flexible document model
- Horizontal scaling
- Rich query language
- GridFS for file storage
- Automatically started as service

### MySQL
**Package:** `mysql`  
**Installed in:** Interactive (optional)  
**Purpose:** Popular relational database  
**Website:** [mysql.com](https://www.mysql.com/)

Widely-used open-source relational database:
- High performance
- Reliability and ease of use
- Cross-platform support
- Automatically started as service

### Redis
**Package:** `redis`  
**Installed in:** Interactive (optional)  
**Purpose:** In-memory data structure store  
**Website:** [redis.io](https://redis.io/)

Advanced key-value store used for:
- Caching
- Session storage
- Real-time analytics
- Message broker
- Automatically started as service

### TablePlus
**Package:** `tableplus`  
**Installed in:** When any database is selected  
**Purpose:** Modern database GUI client  
**Website:** [tableplus.com](https://tableplus.com/)

Native database client supporting:
- PostgreSQL, MySQL, Redis, and more
- Beautiful, intuitive interface
- Query editor with syntax highlighting
- Data visualization tools

### MongoDB Compass
**Package:** `mongodb-compass`  
**Installed in:** When any database is selected  
**Purpose:** Official MongoDB GUI  
**Website:** [mongodb.com/products/compass](https://www.mongodb.com/products/compass)

Official MongoDB graphical interface:
- Visual query builder
- Performance optimization
- Schema analysis
- Real-time server stats

---

## 🌐 Web Browsers

### Google Chrome
**Package:** `google-chrome`  
**Installed in:** All modes  
**Purpose:** Web browser and development platform  
**Website:** [google.com/chrome](https://www.google.com/chrome/)

Most popular web browser with excellent developer tools:
- Chrome DevTools
- Extension ecosystem
- Performance profiling
- Security features

### Firefox Developer Edition
**Package:** `firefox@developer-edition`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Browser optimized for developers  
**Website:** [mozilla.org/firefox/developer](https://www.mozilla.org/en-US/firefox/developer/)

Firefox version built for developers:
- Latest Firefox features
- Enhanced developer tools
- CSS Grid inspector
- Responsive design mode

### Arc Browser
**Package:** `arc`  
**Installed in:** Additional setup only  
**Purpose:** Modern, AI-enhanced browser  
**Website:** [arc.net](https://arc.net/)

Next-generation browser with:
- Vertical tabs
- Spaces for organization
- Built-in ad blocker
- AI-powered features

### Brave Browser
**Package:** `brave-browser`  
**Installed in:** Additional setup only  
**Purpose:** Privacy-focused browser  
**Website:** [brave.com](https://brave.com/)

Chromium-based browser with:
- Built-in ad blocking
- Privacy protection
- Cryptocurrency integration
- Tor browsing mode

### Safari Technology Preview
**Package:** `safari-technology-preview`  
**Installed in:** Additional setup only  
**Purpose:** Safari's experimental features  
**Website:** [developer.apple.com/safari/technology-preview](https://developer.apple.com/safari/technology-preview/)

Preview version of Safari with upcoming web technologies and API implementations.

---

## 🛠 Development & API Tools

### Docker Desktop
**Package:** `docker`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Containerization platform  
**Website:** [docker.com](https://www.docker.com/)

Essential for modern development:
- Container management
- Kubernetes integration
- Multi-platform support
- Development environment isolation

### Postman
**Package:** `postman`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** API development platform  
**Website:** [postman.com](https://www.postman.com/)

Comprehensive API testing tool:
- Request building and testing
- Collection organization
- Environment variables
- Automated testing
- Team collaboration

### Bruno
**Package:** `bruno`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Open-source API client  
**Website:** [usebruno.com](https://www.usebruno.com/)

Fast, Git-friendly API client:
- No account required
- Local file storage
- Scriptable requests
- Environment management
- Privacy-focused

### Insomnia
**Package:** `insomnia`  
**Installed in:** Additional setup only  
**Purpose:** API design and testing tool  
**Website:** [insomnia.rest](https://insomnia.rest/)

Powerful API client with:
- Request/response management
- Environment templating
- Code generation
- Plugin ecosystem

### DevToys
**Package:** `devtoys`  
**Installed in:** Additional setup only  
**Purpose:** Developer utilities app  
**Website:** [devtoys.app](https://devtoys.app/)

Swiss Army knife for developers:
- JSON formatter
- Base64 encoder/decoder
- Hash generators
- Text converters
- Number base converters

### Proxyman
**Package:** `proxyman`  
**Installed in:** Additional setup only  
**Purpose:** HTTP debugging proxy  
**Website:** [proxyman.io](https://proxyman.io/)

Modern web debugging proxy:
- HTTPS traffic inspection
- Request/response modification
- Breakpoints and scripting
- Network throttling

---

## 🎨 Productivity & Utilities

### Rectangle
**Package:** `rectangle`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Window management utility  
**Website:** [rectangleapp.com](https://rectangleapp.com/)

Essential window manager for productivity:
- Keyboard shortcuts for window positioning
- Snap-to-edge functionality
- Multiple monitor support
- Free and open-source

### Raycast
**Package:** `raycast`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Productivity launcher and command palette  
**Website:** [raycast.com](https://www.raycast.com/)

Powerful productivity tool:
- Quick launcher
- Clipboard history
- Calculator and conversions
- Extensions ecosystem
- System shortcuts

### CleanShot X
**Package:** `cleanshot`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Advanced screenshot and screen recording  
**Website:** [cleanshot.com](https://cleanshot.com/)

Professional screenshot tool:
- Advanced annotation tools
- Scrolling capture
- Screen recording
- Cloud uploading
- Built-in editor

### Notion
**Package:** `notion`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** All-in-one workspace  
**Website:** [notion.so](https://www.notion.so/)

Versatile productivity platform:
- Note-taking and documentation
- Project management
- Database functionality
- Team collaboration
- Template marketplace

### Obsidian
**Package:** `obsidian`  
**Installed in:** Additional setup only  
**Purpose:** Knowledge management system  
**Website:** [obsidian.md](https://obsidian.md/)

Powerful note-taking app:
- Linked note system
- Graph view of connections
- Plugin ecosystem
- Markdown-based
- Local file storage

---

## 🔧 Shell & Terminal Tools

### Warp Terminal
**Package:** `warp`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Modern, AI-enhanced terminal  
**Website:** [warp.dev](https://www.warp.dev/)

Next-generation terminal:
- AI command suggestions
- Blocks-based output
- Collaboration features
- Built-in themes
- Fast performance

### Oh My Zsh
**Installed in:** All modes  
**Purpose:** Zsh configuration framework  
**Website:** [ohmyz.sh](https://ohmyz.sh/)

Enhances the Zsh shell with:
- Themes and customization
- Plugin ecosystem
- Auto-completion improvements
- Git integration
- Productivity shortcuts

### bat
**Package:** `bat`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Enhanced cat command  
**Website:** [github.com/sharkdp/bat](https://github.com/sharkdp/bat)

Modern replacement for `cat`:
- Syntax highlighting
- Git integration
- Line numbers
- Paging support
- File type detection

### exa
**Package:** `exa`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Modern ls replacement  
**Website:** [the.exa.website](https://the.exa.website/)

Improved directory listing:
- Colorful output
- Git status integration
- Tree view support
- Extended attributes
- Human-readable sizes

### fzf
**Package:** `fzf`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Fuzzy finder for command line  
**Website:** [github.com/junegunn/fzf](https://github.com/junegunn/fzf)

Interactive fuzzy finder:
- File and directory searching
- Command history search
- Vim integration
- Shell key bindings
- Preview support

### ripgrep (rg)
**Package:** `ripgrep`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Ultra-fast text search tool  
**Website:** [github.com/BurntSushi/ripgrep](https://github.com/BurntSushi/ripgrep)

Fastest grep alternative:
- Regex search
- Respects .gitignore
- Unicode support
- Multiple file formats
- Parallel searching

### tree
**Package:** `tree`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Directory tree visualization  

Displays directory structures as trees:
- Recursive directory listing
- Customizable output
- File size information
- Pattern matching
- Multiple output formats

### htop
**Package:** `htop`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Interactive process viewer  
**Website:** [htop.dev](https://htop.dev/)

Enhanced version of `top`:
- Colorful interface
- Mouse support
- Tree view of processes
- Kill processes interactively
- System resource monitoring

### jq
**Package:** `jq`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** JSON processor  
**Website:** [stedolan.github.io/jq](https://stedolan.github.io/jq/)

Command-line JSON processor:
- JSON parsing and manipulation
- Powerful query language
- Streaming support
- Pretty printing
- Data transformation

### HTTPie
**Package:** `httpie`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** User-friendly HTTP client  
**Website:** [httpie.io](https://httpie.io/)

Human-friendly HTTP client:
- Simple syntax
- JSON support
- Pretty-printed output
- Session support
- Plugin system

### wget
**Package:** `wget`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** File downloading utility  
**Website:** [gnu.org/software/wget](https://www.gnu.org/software/wget/)

Network downloader:
- Recursive downloads
- Resume interrupted downloads
- HTTP/HTTPS/FTP support
- Background downloading
- Retry mechanisms

---

## 🔄 Version Control & Git Tools

### GitHub Desktop
**Package:** `github-desktop`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Git GUI client  
**Website:** [desktop.github.com](https://desktop.github.com/)

User-friendly Git interface:
- Visual diff viewing
- Branch management
- Commit history visualization
- GitHub integration
- Merge conflict resolution

### SourceTree
**Package:** `sourcetree`  
**Installed in:** Additional setup only  
**Purpose:** Advanced Git GUI  
**Website:** [sourcetreeapp.com](https://www.sourcetreeapp.com/)

Professional Git client:
- Advanced branching and merging
- Repository bookmarks
- File status and diff viewing
- Git-flow support
- Atlassian integration

---

## 📱 Additional Applications

### Zoom
**Package:** `zoom`  
**Installed in:** Full mode, Interactive (optional)  
**Purpose:** Video conferencing platform  
**Website:** [zoom.us](https://zoom.us/)

Essential for remote work:
- HD video and audio
- Screen sharing
- Recording capabilities
- Virtual backgrounds
- Breakout rooms

### Slack
**Package:** `slack`  
**Installed in:** Additional setup only  
**Purpose:** Team communication platform  
**Website:** [slack.com](https://slack.com/)

Workplace communication:
- Channel-based messaging
- File sharing
- App integrations
- Voice and video calls
- Workflow automation

---

## 📁 Project Structure

The script also creates a standardized project directory structure:

```
~/Projects/
├── personal/     # Personal projects and experiments
├── work/         # Work-related projects
├── opensource/   # Open-source contributions
└── learning/     # Learning projects and tutorials
```

This organization helps maintain a clean development environment and makes it easy to find projects by context.

---

## 🔐 Security Setup

### SSH Key Generation
The script can generate SSH keys for secure Git operations:
- Uses modern Ed25519 algorithm
- Automatically adds to ssh-agent
- Copies public key to clipboard for easy GitHub setup
- Configures proper permissions

This enables secure, passwordless authentication with GitHub and other Git hosting services.

---

*This documentation covers all applications and tools available in the macOS Development Setup Script. Each tool has been carefully selected to provide a comprehensive, modern development environment suitable for web development, full-stack projects, and general programming tasks.*
