# macOS Web Development Setup Script 2025

A comprehensive, interactive setup script for macOS that automates the installation of essential web development tools, editors, databases, and productivity applications.

## 🚀 Features

- **Three Installation Modes**: Choose between minimal frontend setup, full development environment, or interactive selection
- **Smart Detection**: Automatically detects existing installations and skips them
- **Interactive Selection**: Choose specific editors, databases, and tools based on your needs
- **Modern Tool Stack**: Includes the latest development tools and productivity applications
- **Color-coded Output**: Clear, formatted logging with success/error indicators
- **Extensible**: After automatic installation, option to add more tools step-by-step

## 📋 Requirements

- macOS Catalina (10.15) or later
- Zsh shell (default on macOS Catalina+)
- Internet connection
- Administrator privileges

## 📚 Documentation

- **[📦 Complete Applications & Tools Reference](APPS.md)** - Detailed information about every app, tool, and package
- **[🔄 Installation Flow Diagram](setup-flow.mermaid)** - Visual flowchart of the setup process

## 🎯 Installation Modes

### Minimal Frontend Setup (`--auto-minimal`)
Perfect for frontend developers who need just the essentials:

**Core Tools:**
- Xcode Command Line Tools
- Homebrew package manager
- Git version control
- NVM + Node.js LTS
- npm/yarn package managers

**Editor:**
- Visual Studio Code (default)

**Browser:**
- Google Chrome

**Shell:**
- Oh My Zsh with basic configuration

### Full Development Setup (`--auto-full`)
Complete development environment for full-stack developers:

**Everything from Minimal, plus:**

**Additional Editors:**
- Visual Studio Code
- Cursor (AI-powered editor)

**Languages & Runtimes:**
- Python 3.12 + pipenv
- Claude Code (AI assistant)

**Browsers:**
- Firefox Developer Edition

**Databases:**
- PostgreSQL 15
- MongoDB
- Database GUIs (TablePlus, MongoDB Compass)

**Development Tools:**
- Docker Desktop
- Postman (API testing)
- Bruno (open-source API client)
- GitHub Desktop
- Warp (modern terminal)

**Productivity:**
- Rectangle (window management)
- RayCast (productivity launcher)
- CleanShot X (screenshots)
- Notion (notes & project management)
- Zoom (video conferencing)

**Shell Improvements:**
- Modern CLI tools: bat, exa, fzf, ripgrep, tree, htop, jq
- HTTP tools: httpie, wget

**Project Structure:**
- `~/Projects/{personal,work,opensource,learning}` directories

**Security:**
- SSH key generation for GitHub

### Interactive Mode (`--interactive`)
Default mode that asks for confirmation before each installation, allowing you to customize exactly what gets installed.

## 🛠 Usage

### Quick Start

1. **Download the script:**
   ```bash
   curl -O https://raw.githubusercontent.com/yourusername/macos-setup/main/setup.sh
   chmod +x setup.sh
   ```

2. **Run the setup:**
   ```bash
   # Interactive mode (default) - asks before each installation
   ./setup.sh
   
   # Minimal frontend setup - installs essentials only
   ./setup.sh --auto-minimal
   
   # Full development setup - installs everything
   ./setup.sh --auto-full
   
   # Explicit interactive mode
   ./setup.sh --interactive
   ```

### Command Line Options

```bash
./setup.sh [--auto-minimal|--auto-full|--interactive] [-h|--help]
```

**Options:**
- `--auto-minimal`: Install only essential frontend development tools
- `--auto-full`: Install complete development environment
- `--interactive`: Ask for each installation (default)
- `-h, --help`: Show help information

### Examples

```bash
# Quick minimal setup for React development
./setup.sh --auto-minimal

# Complete setup for full-stack development
./setup.sh --auto-full

# Custom setup with your choices
./setup.sh --interactive
```

## 🗂 What Gets Installed

### Core Development Tools
| Tool | Minimal | Full | Purpose |
|------|---------|------|---------|
| Xcode Command Line Tools | ✅ | ✅ | Build tools |
| Homebrew | ✅ | ✅ | Package manager |
| Git | ✅ | ✅ | Version control |
| NVM + Node.js LTS | ✅ | ✅ | JavaScript runtime |
| Python 3.12 | ❌ | ✅ | Python development |
| Oh My Zsh | ✅ | ✅ | Enhanced shell |

### Code Editors (Selectable)
- Visual Studio Code
- Visual Studio Code Insiders
- Cursor (AI-powered)
- WebStorm (JetBrains)

### Databases (Selectable)
- PostgreSQL 15
- MongoDB
- MySQL
- Redis
- TablePlus (GUI)
- MongoDB Compass (GUI)

### Browsers
- Google Chrome (always)
- Firefox Developer Edition (full mode)

### Development Tools (Full Mode)
- Docker Desktop
- Postman
- Bruno
- GitHub Desktop
- Warp Terminal

### Productivity Tools (Full Mode)
- Rectangle
- RayCast
- CleanShot X
- Notion
- Zoom

### Shell Improvements (Full Mode)
- `bat` - better cat
- `exa` - modern ls
- `fzf` - fuzzy finder
- `ripgrep` - fast grep
- `tree` - directory tree
- `htop` - system monitor
- `jq` - JSON processor
- `httpie` - HTTP client
- `wget` - file downloader

## 🔧 Post-Installation

After running the script:

1. **Restart your terminal** or run:
   ```bash
   source ~/.zshrc
   ```

2. **Configure Git** (if not done during setup):
   ```bash
   git config --global user.name "Your Name"
   git config --global user.email "your.email@example.com"
   ```

3. **Add SSH key to GitHub** (if generated):
   - The public key is automatically copied to your clipboard
   - Go to [GitHub SSH Settings](https://github.com/settings/ssh/new)
   - Paste and save the key

4. **Configure your editor** with extensions and settings

5. **Set up your first project**:
   ```bash
   cd ~/Projects/personal
   # Start your development!
   ```

## 🛡 Security

- The script only installs from official sources (Homebrew, official websites)
- SSH keys are generated locally and never transmitted
- No sensitive information is stored or transmitted
- All installations are from verified publishers

## 🐛 Troubleshooting

### Common Issues

**Script fails with "zsh required":**
```bash
zsh setup.sh [options]
```

**Homebrew not found after installation:**
```bash
# Restart terminal or source the profile
source ~/.zprofile
```

**Permission denied errors:**
```bash
# Make sure script is executable
chmod +x setup.sh
```

**Xcode Command Line Tools installation hangs:**
- Complete the GUI installation that pops up
- Re-run the script after installation completes

**Git configuration fails:**
- Run the script again, or configure manually:
```bash
git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"
```

### Getting Help

If you encounter issues:

1. **Check the logs** - the script provides detailed colored output
2. **Ensure macOS is up to date**
3. **Try running individual commands** manually
4. **Check Homebrew status**: `brew doctor`

## 🔄 Updates

To update your installed tools:

```bash
# Update Homebrew and all packages
brew update && brew upgrade

# Update Node.js to latest LTS
nvm install --lts
nvm use --lts

# Update global npm packages
npm update -g
```

## 🤝 Contributing

Contributions are welcome! Please:

1. Fork the repository
2. Create a feature branch
3. Test your changes on a clean macOS system
4. Submit a pull request

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🙏 Acknowledgments

- [Homebrew](https://brew.sh/) for the excellent package manager
- [Oh My Zsh](https://ohmyz.sh/) for shell improvements
- All the amazing open-source tools included in this setup

---

**Happy coding! 💻✨**

*Built with ❤️ for the macOS development community*
