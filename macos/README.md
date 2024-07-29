# New ACA laptop dotfiles

## Description
Installing a newly received, clean laptop can be quite time-consuming. These dotfiles try to alleviate the effort to install a new company laptop. The scripts configures your Mac, installs and uninstalls software.

## Usage
1. Follow all Opsklaar instructions for setting up your new laptop
2. Configure your git credentials:
    * `git config --global user.name "Your Stash name"`
    * `git config --global user.email "Your Stash email"`
3. Git clone the following repo: https://stash.aca-it.be/users/thomas.metten/repos/dotfiles
4. `chmod +x install-clean-laptop`
5. `./install-clean-laptop`
6. Logout and login on your account again to activate changed Mac preferences
6. Enjoy!

__It is advisable to transfer the following folders from your previous Macbook (either manually or by using Google Drive + symlinks):__
* ~/.m2
* ~/.ssh

__Failing to type your sudo password results in an incomplete run of the script! If this happens, simply run the script again and type your password correctly.__

## Manual configuration steps (not yet automated)
* Set iTerm2 color scheme to material design
* Set iTerm2 font to 14pt Menlo Regular
* Install Lastpass and Dashlane browser plugins
* Remove Firefox and other unwanted icons from dockbar
* Log in on additional Internet Accounts in System Preferences
* Add symlinks for .m2 and .ssh folders

## Installations
* [Homebrew](https://brew.sh/)
* [Docker + Docker Desktop](https://www.docker.com/products/docker-desktop)
* [iTerm2](https://www.iterm2.com/)
* [Visual Studio Code](https://code.visualstudio.com/)
* [Spectacle](https://www.spectacleapp.com/)
* [IntelliJ IDEA](https://www.jetbrains.com/idea/)
* [Spotify](https://www.spotify.com/be-nl/)
* [Lastpass](https://www.lastpass.com/)

## Uninstallations
* iMovie
* Garageband

## Configurations
* Disable the sound effects on boot
* Increase keyboard repeat rate
* Automatically hide and show the Dock
* Remove auto-hiding Dock Delay
* Remove animation when hiding/showing the Dock
* Hide 'recent applications' from the Dock
* Set hot corner bottom-left: sleep screen
* Show battery percentage
* Add a `~/Projects` directory to clone Stash repo's into
* Disable auto-correct
