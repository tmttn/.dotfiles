# .dotfiles

Personal dotfiles for macOS development environment setup with automatic configuration switching.

## Quick Start

```bash
git clone https://github.com/tmttn/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./setup.sh
```

**Note**: The setup script automatically initializes and updates Git submodules, so you don't need to run `git submodule update --init --recursive` manually.

## Features

- 🍎 **Automatic macOS Detection**: Git configuration automatically switches to ACA work settings on MacBooks
- 📦 **Comprehensive Package Management**: 100+ packages via Homebrew including development tools and fonts
- 🚀 **One-Command Setup**: Complete development environment setup with a single script
- ⚙️ **Modular Configuration**: Organized by application/tool for easy maintenance
- 🔗 **Symlink Management**: Uses GNU Stow for clean dotfile management
- 📦 **Git Submodules**: Automatically pulls external configurations and plugins

### Included Submodules

- **Neovim**: [kickstart.nvim](https://github.com/tmttn/kickstart.nvim) - Complete Neovim configuration
- **Zsh Plugins**:
  - [zsh-autosuggestions](https://github.com/zsh-users/zsh-autosuggestions) - Command autosuggestions
  - [gradle-completion](https://github.com/gradle/gradle-completion) - Gradle autocomplete
  - [zsh-npm-scripts-autocomplete](https://github.com/grigorii-zander/zsh-npm-scripts-autocomplete) - NPM scripts completion
  - [zsh-mvn-contexts](https://github.com/artemy/zsh-mvn-contexts) - Maven context switching
  - [zsh-ssh](https://github.com/sunlei/zsh-ssh) - SSH host completion
- **Keyboard**: [keyboards](https://github.com/tmttn/keyboards) - Custom keyboard layouts

## Platform-Specific Setup

- **macOS**: See [macos/README.md](macos/README.md) - Automated laptop setup with Brewfile
- **Linux**: Coming soon

## Structure

```text
├── asdf/              # Version manager configuration
├── backgrounds/       # Desktop wallpapers
├── bash/             # Bash shell configuration
├── git/              # Personal Git configuration
├── git-aca/          # Work Git configuration (auto-used on macOS)
├── hypr/             # Hyprland window manager
├── i3/               # i3 window manager
├── keyboard/         # Keyboard layouts and configs
├── kitty/            # Kitty terminal (Linux)
├── kitty-macos/      # Kitty terminal (macOS)
├── macos/            # macOS-specific setup and Brewfile
├── nvim/             # Neovim configuration
├── tmux/             # Terminal multiplexer config
├── zsh/              # Zsh shell with oh-my-zsh
└── wezterm/          # WezTerm terminal configuration
```

## Smart Git Configuration

This setup configures Git for ACA work environment:

- **Work repositories**: Uses `tom.metten@acagroup.be` with ACA GPG key by default
- **Personal repositories**: Can be overridden locally as needed
- **All commits**: GPG signed for security

## Requirements

### macOS

- macOS 12+ (Monterey or later)
- Internet connection
- Admin privileges
- Xcode Command Line Tools (installed automatically)

### Linux

- GNU Stow
- Git
- Curl

## What Gets Installed (macOS)

### Development Tools

- asdf (version manager)
- Docker & Colima
- Git, GitHub CLI
- Node.js, Python, Go
- VS Code with extensions

### Fonts

- 50+ Nerd Fonts for terminal icons
- Programming fonts (Fira Code, JetBrains Mono, etc.)

### Applications

- Arc, Firefox browsers
- Raycast launcher
- Rectangle window manager
- And many more via Brewfile

### System Configuration

- Sensible macOS defaults
- Dock configuration
- Finder settings
- Security preferences

## Manual Steps After Installation

1. **Sign in to Mac App Store** (for App Store apps)
2. **Configure SSH keys** for Git repositories
3. **Set up GPG keys** for commit signing
4. **Launch Raycast** and configure shortcuts
5. **Configure Arc browser** sync

## Customization

- Edit `macos/Brewfile` to add/remove packages
- Modify `zsh/.zshrc` for shell customization
- Update `macos/macos.sh` for system preferences
- Add new configurations in dedicated folders

### Adding New Stow Configurations

To add a new application configuration to this dotfiles repository:

1. **Create the configuration directory**:

   ```bash
   mkdir ~/.dotfiles/myapp
   ```

2. **Add your configuration files**:

   ```bash
   # Create the expected directory structure
   mkdir -p ~/.dotfiles/myapp/.config/myapp
   
   # Copy your existing config
   cp ~/.config/myapp/config.yml ~/.dotfiles/myapp/.config/myapp/
   ```

3. **Test the stow configuration**:

   ```bash
   cd ~/.dotfiles
   stow -n -v myapp  # Dry run to see what would be linked
   stow myapp        # Actually create the symlinks
   ```

4. **Add to the setup script** (if it should be installed automatically):
   - For **shared configs** (both macOS/Linux): Add to the "shared configurations" section
   - For **macOS-only**: Add to the macOS-specific section  
   - For **Linux-only**: Add to the Linux-specific section

   ```bash
   # In setup.sh, add to appropriate section:
   stow -t ~ myapp
   ```

5. **Update documentation**:
   - Add the new config to the Structure section in this README
   - Document any special setup requirements

#### Common Stow Patterns

- **Simple config file**: `myapp/.myapprc`
- **XDG config**: `myapp/.config/myapp/config.yml`
- **Multiple files**: `myapp/.config/myapp/` with subdirectories
- **Conditional configs**: Create separate directories like `myapp-linux/` and `myapp-macos/`

#### Troubleshooting Stow

- **Conflicts**: Use `stow -D myapp` to remove, fix conflicts, then `stow myapp`
- **Adopt existing files**: Use `stow --adopt myapp` to move existing files into the stow directory
- **Verbose output**: Use `stow -v myapp` to see exactly what's being linked
- **Dry run**: Use `stow -n myapp` to preview changes without making them

## Troubleshooting

### Common Issues

- **Homebrew installation fails**: Check internet connection and run `xcode-select --install`
- **Permission denied**: Ensure you're not running as root
- **Git config not switching**: Verify you're in `/Users/` path on macOS
- **Missing plugins/configs**: Run `git submodule update --init --recursive` manually if setup fails

### Logs

Installation logs are saved to `~/dotfiles-install.log`

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Test on a fresh macOS installation
5. Submit a pull request

## License

This is a personal configuration repository. Feel free to fork and adapt for your own use.

---

⭐ **Pro Tip**: Run `./setup.sh` on a fresh macOS installation and grab a coffee ☕ - everything will be ready when you return!
