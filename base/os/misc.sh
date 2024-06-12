#!/usr/bin/env zsh


# screenshot tool
echo "configuring screenshot tool"
defaults write com.apple.screencapture location -string "~/Downloads"
defaults write com.apple.screencapture show-thumbnail -bool "false"

# 24 hr time
echo "configuring menu bar clock"
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE MMM d HH:mm\""

echo "restarting system ui server"
killall SystemUIServer

