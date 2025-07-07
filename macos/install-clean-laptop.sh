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
echo ''
