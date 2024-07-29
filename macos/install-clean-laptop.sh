#!/usr/bin/env bash

# install Homebrew and run Brewfile
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# install mas
brew install mas

# check if signed-in on App Store
if mas account | grep -q 'Not signed in'; then
   echo "Installation script aborted: you need to be logged in on the App Store before running this script."
   echo "Brew and mas have already been installed, as these are required to perform the App Store check."
   echo "This is not an issue when re-running the script"
   exit 1
fi

# create projects directory
mkdir ~/Projects

# install other homebrew scripts & apps
brew bundle

# configure Mac OS settings
chmod +x macos
sh macos

# configure App Store
sudo mas uninstall 682658836 # uninstall Garageband
sudo mas uninstall 408981434 # uninstall iMovie

# print manual steps
echo ''
echo 'Installation finished ! Logout and back in to your account to activate all preferences'
echo 'You can now continue in iTerm2...'
echo ''
echo ''
echo 'Configure the following items manually:'
echo '======================================='
echo ''
echo '# Set iTerm2 color scheme to material design'
echo '# Set iTerm2 font to 14pt Menlo Regular'
echo '# Install Lastpass browser plugin'
echo '# Remove unwanted icons from dockbar'
echo '# Log in on additional Internet Accounts in System Preferences'
echo '# Add symlinks for .m2 and .ssh folders'