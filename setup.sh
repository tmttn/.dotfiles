#!/usr/bin/env bash

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Log file
LOGFILE="$HOME/dotfiles-install.log"

print_status() {
    echo -e "${GREEN}[INFO]${NC} $1" | tee -a "$LOGFILE"
}

print_warning() {
    echo -e "${YELLOW}[WARN]${NC} $1" | tee -a "$LOGFILE"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1" | tee -a "$LOGFILE"
}

print_header() {
    echo -e "${BLUE}[SETUP]${NC} $1" | tee -a "$LOGFILE"
}

log() {
    echo "$(date): $1" >> "$LOGFILE"
}

# Check if running as root
if [[ $EUID -eq 0 ]]; then
   print_error "This script should not be run as root"
   exit 1
fi

# Initialize log
log "Starting dotfiles setup"
print_header "🚀 Dotfiles Setup Starting..."

# Initialize and update Git submodules
print_header "📦 Initializing Git submodules..."
if git rev-parse --git-dir > /dev/null 2>&1; then
    print_status "Updating Git submodules..."
    git submodule update --init --recursive
    print_status "✓ Git submodules updated successfully"
else
    print_warning "Not in a Git repository, skipping submodule update"
fi

# Check internet connectivity
print_status "Checking internet connectivity..."
if ! ping -c 1 google.com &> /dev/null; then
    print_error "No internet connection"
    exit 1
fi
print_status "✓ Internet connection verified"

# Detect OS and run appropriate setup
if [[ "$OSTYPE" == "darwin"* ]]; then
    print_header "🍎 macOS detected, running macOS setup..."
    log "Running macOS setup"
    
    # Change to macOS directory and run setup
    cd "$(dirname "$0")/macos" || {
        print_error "Could not find macos directory"
        exit 1
    }
    
    # Make sure the script is executable
    chmod +x install-clean-laptop.sh
    
    # Run the macOS setup script
    ./install-clean-laptop.sh
    
    print_status "✓ macOS setup completed"
    
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
    print_header "🐧 Linux detected, setting up Linux environment..."
    log "Running Linux setup"
    
    # Check if stow is available, install if not
    if ! command -v stow &> /dev/null; then
        print_status "Installing GNU Stow..."
        if command -v apt-get &> /dev/null; then
            sudo apt-get update && sudo apt-get install -y stow
        elif command -v pacman &> /dev/null; then
            sudo pacman -S stow
        elif command -v dnf &> /dev/null; then
            sudo dnf install stow
        else
            print_error "Cannot install stow automatically. Please install manually."
            exit 1
        fi
    fi
    
    print_status "✓ Linux setup ready"
else
    print_error "Unsupported OS: $OSTYPE"
    exit 1
fi

# Setup dotfile symlinks with stow (if available and not already done)
print_header "🔗 Setting up dotfile symlinks..."

if command -v stow &> /dev/null; then
    print_status "Using GNU Stow for symlink management"
    
    # Return to dotfiles root directory
    cd "$(dirname "$0")" || exit 1
    
    # Stow shared configurations (work on both macOS and Linux)
    # To add new shared configs, add them here with: stow -t ~ newconfig
    print_status "Linking shared configurations..."
    stow -t ~ zsh
    stow -t ~ nvim
    stow -t ~ wezterm
    stow -t ~ tmux
    stow -t ~ asdf
    stow -t ~ tool-versions
    stow -t ~ backgrounds
    stow -t ~ bash
    stow -t ~ keyboard
    stow -t ~ neofetch
    
    # Platform-specific Git configuration
    if [[ "$OSTYPE" == "darwin"* ]]; then
        print_status "Linking ACA Git configuration for macOS..."
        stow -t ~ git-aca
        
        # macOS-specific configurations
        # To add new macOS-only configs, add them here with: stow -t ~ newconfig
        print_status "Linking macOS-specific configurations..."
        stow -t ~ mvn
    else
        print_status "Linking personal Git configuration for Linux..."
        stow -t ~ git
        
        # Linux-specific configurations
        # To add new Linux-only configs, add them here with: stow -t ~ newconfig
        print_status "Linking Linux-specific configurations..."
        stow -t ~ mvn
        stow -t ~ dunst
        stow -t ~ hypr
        stow -t ~ i3
        stow -t ~ picom
        stow -t ~ polybar
        stow -t ~ rofi
        stow -t ~ waybar
        stow -t ~ wireplumber
        stow -t ~ xorg
    fi
    
    print_status "✓ Dotfile symlinks created successfully"
else
    print_warning "GNU Stow not available, using manual symlinks"
    
    # Fallback manual linking for critical configs
    if [[ "$OSTYPE" == "darwin"* ]]; then
        ln -sf "$PWD/git-aca/.gitconfig" ~/.gitconfig
        print_status "Linked ACA Git configuration for macOS"
    else
        ln -sf "$PWD/git/.gitconfig" ~/.gitconfig
        print_status "Linked personal Git configuration for Linux"
    fi
    
    # Essential shared configurations
    ln -sf "$PWD/zsh/.zshrc" ~/.zshrc
    ln -sf "$PWD/wezterm/.wezterm.lua" ~/.wezterm.lua
    
    print_status "✓ Essential configurations linked manually"
fi

# Final status
print_header "🎉 Setup Complete!"
print_status "Dotfiles have been successfully installed and configured"

echo ""
print_status "📋 Next steps:"
echo "  1. Restart your terminal to load new shell configuration"

if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "  2. Sign in to Mac App Store for App Store apps"
    echo "  3. Configure SSH keys: ssh-keygen -t ed25519 -C 'tom.metten@acagroup.be'"
    echo "  4. Set up GPG keys for commit signing"
    echo "  5. Launch Raycast and configure shortcuts"
    echo "  6. Configure Arc browser sync"
    echo ""
    print_status "🔧 Git configuration:"
    echo "  • Using ACA work email and GPG key for macOS"
else
    echo "  2. Configure SSH keys: ssh-keygen -t ed25519 -C 'thomas.metten@gmail.com'"
    echo "  3. Set up GPG keys for commit signing"
    echo "  4. Install additional packages as needed"
    echo "  5. Configure window manager (i3/Hyprland) if using"
    echo ""
    print_status "🔧 Git configuration:"
    echo "  • Using personal email for Linux systems"
    print_status "🖥️  Available configurations:"
    echo "  • Window managers: i3, Hyprland"
    echo "  • Bars: Polybar, Waybar"
    echo "  • Compositor: Picom"
    echo "  • Launcher: Rofi"
    echo "  • Notifications: Dunst"
fi
echo ""

print_status "📝 Installation log saved to: $LOGFILE"
print_status "Please restart your terminal to complete the setup!"

log "Setup completed successfully"
