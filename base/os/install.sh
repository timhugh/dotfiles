#!/usr/bin/env zsh

set -e 

DOT_ROOT=$(cat "${HOME}/.dotfiles_root")

echo "installing base/os subpackage"

echo "configuring dock icons"
# clear all of that starter garbage from the dock
/opt/homebrew/bin/dockutil --remove all
# add home and downloads folders
/opt/homebrew/bin/dockutil --add "${HOME}" --display folder --view grid
/opt/homebrew/bin/dockutil --add "${HOME}/Downloads" --display folder --view grid

echo "configuring dock settings"
defaults write com.apple.dock autohide -bool "true"
defaults write com.apple.dock show-recents -bool "false"
defaults write com.apple.dock minimize-to-application -bool "true"

echo "configuring mission control"
# don't automatically rearrange spaces
defaults write com.apple.dock mru-spaces -bool "false"

echo "configuring screenshot tool"
defaults write com.apple.screencapture location -string "~/Downloads"
defaults write com.apple.screencapture show-thumbnail -bool "false"

# 24 hr time
echo "configuring menu bar clock"
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE MMM d HH:mm\""

# these two are piped to /dev/null and the return is ignored because we don't
# totally care if they succeed, and they tend to have errors even when they do
echo "restarting dock"
killall Dock &> /dev/null || true
echo "restarting system ui server"
killall SystemUIServer &> /dev/null || true

echo "base/os subpackage complete"

