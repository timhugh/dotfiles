#!/usr/bin/env zsh

# load/save settings from dotfiles
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${DOT_ROOT}/dev/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

