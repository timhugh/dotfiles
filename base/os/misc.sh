#!/usr/bin/env zsh

set -e

# screenshot tool
defaults write com.apple.screencapture location -string "~/Downloads"
defaults write com.apple.screencapture show-thumbnail -bool "false"

# 24 hr time
defaults write com.apple.menuextra.clock "DateFormat" -string "\"EEE MMM d HH:mm\""

killall SystemUIServer

