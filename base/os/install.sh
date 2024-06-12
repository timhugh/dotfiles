#!/usr/bin/env zsh

set -e 

echo "installing base/os subpackage"

echo "configuring dock icons"
/opt/homebrew/bin/dockutil --remove all
/opt/homebrew/bin/dockutil --add "${HOME}" --display folder --view grid
/opt/homebrew/bin/dockutil --add "${HOME}/Downloads" --display folder --view grid

echo "configuring dock settings"
defaults write com.apple.dock show-recents -bool "false"
defaults write com.apple.dock minimize-to-application -bool "true"

# screenshot tool
echo "configuring screenshot tool"
defaults write com.apple.screencapture location -string "~/Downloads"
defaults write com.apple.screencapture show-thumbnail -bool "false"

# 24 hr time
echo "configuring menu bar clock"
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE MMM d HH:mm\""

echo "restarting dock"
killall Dock

echo "restarting system ui server"
killall SystemUIServer

echo "base/os subpackage complete"

