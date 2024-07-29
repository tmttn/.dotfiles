#!/usr/bin/env bash

# close any open System Preferences panes, to prevent them from overriding settings we’re about to change
osascript -e 'tell application "System Preferences" to quit'

# disable the sound effects on boot
sudo nvram SystemAudioVolume=" "

# set a blazingly fast keyboard repeat rate
defaults write -g InitialKeyRepeat -int 10 # normal minimum is 15 (225 ms)
defaults write -g KeyRepeat -int 1 # normal minimum is 2 (30 ms)

# automatically hide and show the Dock
defaults write com.apple.dock autohide -bool true

# remove the auto-hiding Dock delay
defaults write com.apple.dock autohide-delay -float 0

# remove the animation when hiding/showing the Dock
defaults write com.apple.dock autohide-time-modifier -float 0

# bottom left screen corner → Sleep screen
defaults write com.apple.dock wvous-bl-corner -int 5
defaults write com.apple.dock wvous-bl-modifier -int 0

# show battery percentage
defaults write com.apple.menuextra.battery ShowPercent true

# do not show recent applications in the dock
defaults write com.apple.dock show-recents -bool false

# disable auto-correct
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false