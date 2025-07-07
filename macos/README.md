# macOS Development Environment Setup

## Description

Automated setup for a new macOS development environment with ACA work configuration. This script installs development tools, configures system preferences, and sets up Git to automatically use work credentials on macOS.

## Features

- 🚀 **One-command setup**: Complete development environment in minutes
- 🔧 **Smart Git configuration**: Automatically uses ACA work email and GPG key on macOS
- 📦 **Comprehensive package management**: 100+ development tools and applications
- ⚙️ **Optimized macOS settings**: Sensible defaults for development work
- 🎨 **50+ Nerd Fonts**: All the fonts you need for terminal and IDE

## Quick Start

```bash
cd ~/.dotfiles/macos
./install-clean-laptop.sh
```

Or run from the root directory:

```bash
cd ~/.dotfiles
./setup.sh
```

## Prerequisites

1. **Complete ACA IT setup**: Follow all company laptop setup instructions first
2. **Mac App Store login**: Sign in to the Mac App Store before running
3. **Internet connection**: Required for downloading packages
4. **Admin privileges**: You'll be prompted for your password

## What Gets Installed

### Development Tools

- **Package Managers**: Homebrew, asdf (version manager)
- **Languages**: Node.js, Python, Go, Java
- **Development**: Docker + Colima, Git, GitHub CLI
- **Editors**: VS Code with extensions, Neovim
- **Terminals**: WezTerm, Kitty

### Applications

- **Browsers**: Arc, Firefox
- **Productivity**: Raycast, Rectangle, Spotify
- **Communication**: Slack, Teams
- **Development**: Postman, TablePlus, Finder alternatives

### System Configuration

- Optimized keyboard repeat rate
- Auto-hide dock with no delay
- Show battery percentage
- Hot corner for sleep screen
- Disable boot sound effects
- ~/Projects directory creation

## Automatic Git Configuration

The setup configures Git for ACA work environment:

- **Work repositories**: Uses `tom.metten@acagroup.be` with ACA GPG key
- **Personal repositories**: Can override locally as needed (like this dotfiles repo)
- **All commits**: GPG signed by default for security

Test with: `git config user.email` (shows work email for new repositories)

## Migration from Previous MacBook

Use `wormhole` for secure file transfer:

```bash
# On old MacBook
wormhole send ~/.ssh
wormhole send ~/.m2
wormhole send ~/Projects/important-project

# On new MacBook
wormhole receive
```

### Essential Directories to Migrate

- `~/.ssh` - SSH keys and configuration
- `~/.m2/settings.xml` - Maven configuration
- `~/Projects/*` - Your development projects
- GPG keys (see below)

## GPG Key Migration

### Export from old MacBook

```bash
# Export public keys
gpg -a --export > mypubkeys.asc

# Export private keys
gpg -a --export-secret-keys > myprivatekeys.asc

# Export trust database
gpg --export-ownertrust > otrust.txt
```

### Import to new MacBook

```bash
# Import keys
gpg --import myprivatekeys.asc
gpg --import mypubkeys.asc

# Import trust
gpg --import-ownertrust otrust.txt

# Verify
gpg -K  # Secret keys
gpg -k  # Public keys
```

## Manual Steps After Installation

1. **Restart your terminal** to load new shell configuration
2. **Configure SSH keys** for Git repositories
3. **Install browser extensions** (LastPass, development tools)
4. **Clean up dock** - remove unwanted application icons
5. **Sign in to development services** (GitHub, Docker Hub, etc.)
6. **Configure Raycast shortcuts** and preferences
7. **Set up browser sync** (Arc, Firefox)

## Troubleshooting

### Common Issues

- **Script fails**: Ensure you're signed in to Mac App Store
- **Permission errors**: Don't run as root, use your user account
- **Homebrew issues**: Run `xcode-select --install` first
- **Git config not working**: Verify you're in `/Users/` path

### Recovery

If the script fails partway through:

1. Check the log file: `~/dotfiles-install.log`
2. Fix the issue (usually authentication)
3. Re-run the script - it's designed to be idempotent

### Logs

All installation activity is logged to `~/dotfiles-install.log` for debugging.

## Customization

- **Add packages**: Edit `Brewfile` and re-run `brew bundle`
- **Modify system settings**: Update `macos.sh`
- **Change shell config**: Edit `../zsh/.zshrc`
- **Git preferences**: Modify `../git/.gitconfig` or `../git-aca/.gitconfig`

## Security Notes

- GPG signing is enabled by default for commits
- SSH key generation uses modern Ed25519 algorithm
- All credentials are stored securely in macOS Keychain
- Git configuration automatically adapts to work environment

---

💡 **Pro Tip**: This setup is designed for ACA development work and includes work-specific configurations that activate automatically on macOS systems.
