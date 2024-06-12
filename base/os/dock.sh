#!/usr/bin/env zsh

set -e

echo "configuring dock icons"
/opt/homebrew/bin/dockutil --remove all
/opt/homebrew/bin/dockutil --add "${HOME}" --display folder --view grid
/opt/homebrew/bin/dockutil --add "${HOME}/Downloads" --display folder --view grid

echo "configuring dock settings"
defaults write com.apple.dock show-recents -bool "false"
defaults write com.apple.dock minimize-to-application -bool "true"

echo "restarting dock"
killall Dock

