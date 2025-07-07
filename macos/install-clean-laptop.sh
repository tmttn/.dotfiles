#!/usr/bin/env bash

set -e  # Exit on any error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

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

log "Starting macOS setup"
print_header "🍎 macOS Laptop Setup Starting..."

# Check if Xcode Command Line Tools are installed
if ! command -v git &> /dev/null; then
    print_status "Installing Xcode Command Line Tools..."
    xcode-select --install
    print_status "Please complete the Xcode installation and re-run this script"
    exit 1
fi

# Install Homebrew if not already installed
if ! command -v brew &> /dev/null; then
    print_header "🍺 Installing Homebrew..."
    log "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    
    # Add Homebrew to PATH for Apple Silicon Macs
    if [[ $(uname -m) == "arm64" ]]; then
        echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> ~/.zprofile
        eval "$(/opt/homebrew/bin/brew shellenv)"
    fi
    
    print_status "✓ Homebrew installed successfully"
else
    print_status "✓ Homebrew already installed"
fi

# Install oh-my-zsh if not already installed
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
    print_header "🐚 Installing oh-my-zsh..."
    log "Installing oh-my-zsh"
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
    print_status "✓ oh-my-zsh installed successfully"
else
    print_status "✓ oh-my-zsh already installed"
fi

# Install mas (Mac App Store CLI)
if ! command -v mas &> /dev/null; then
    print_status "Installing Mac App Store CLI..."
    brew install mas
fi

# Check if signed-in on App Store
print_status "Checking Mac App Store login status..."
if mas account | grep -q 'Not signed in'; then
   print_error "You need to be logged in to the Mac App Store before running this script."
   print_status "Please open the App Store app and sign in, then re-run this script."
   print_status "Homebrew and mas have been installed successfully."
   exit 1
fi
print_status "✓ Signed in to Mac App Store"

# Create projects directory
if [[ ! -d "$HOME/Projects" ]]; then
    print_status "Creating ~/Projects directory..."
    mkdir -p ~/Projects
    log "Created Projects directory"
fi

# Install packages from Brewfile
print_header "📦 Installing packages from Brewfile..."
log "Running brew bundle"
if brew bundle; then
    print_status "✓ All packages installed successfully"
else
    print_warning "Some packages may have failed to install - check the output above"
fi

# Setup Git configuration with conditional includes
print_header "🔧 Setting up Git configuration..."
log "Configuring Git"

# Ensure git config directory exists
mkdir -p ~/.config/git

# The main git config with conditional includes is already set up
# Just ensure it's properly linked
if [[ ! -f ~/.gitconfig ]]; then
    print_status "Linking Git configuration..."
    ln -sf ~/.dotfiles/git/.gitconfig ~/.gitconfig
    print_status "✓ Git configuration linked"
fi

print_status "✓ Git will automatically use ACA configuration on macOS"
log "Git configuration completed"

# Configure macOS system settings
if [[ -f "macos.sh" ]]; then
    print_header "⚙️  Configuring macOS system settings..."
    log "Applying macOS settings"
    chmod +x macos.sh
    ./macos.sh
    print_status "✓ macOS settings applied"
else
    print_warning "macos.sh not found, skipping system configuration"
fi

# Clean up unwanted apps
print_header "🧹 Removing unwanted pre-installed apps..."
log "Removing unwanted apps"

if mas list | grep -q "682658836"; then
    print_status "Removing GarageBand..."
    sudo mas uninstall 682658836 2>/dev/null || print_warning "Could not remove GarageBand"
fi

if mas list | grep -q "408981434"; then
    print_status "Removing iMovie..."
    sudo mas uninstall 408981434 2>/dev/null || print_warning "Could not remove iMovie"
fi

# Final setup completion
print_header "🎉 macOS Setup Complete!"
log "macOS setup completed successfully"

print_status "📋 Next manual steps:"
echo "  1. Logout and back in to activate all system preferences"
echo "  2. Configure SSH keys: ssh-keygen -t ed25519 -C 'tom.metten@acagroup.be'"
echo "  3. Set up GPG keys for commit signing"
echo "  4. Launch Raycast and configure shortcuts"
echo "  5. Configure Arc browser sync"
echo "  6. Set up development environments (Node.js, Python, etc.)"
echo ""

print_status "🔐 Git is configured to automatically use ACA work email on this macOS system"
print_status "📝 Installation log: $LOGFILE"

log "Installation completed successfully"
