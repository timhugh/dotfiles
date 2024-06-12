#!/usr/bin/env zsh

set -e

echo "installing dev/iterm2 subpackage"

# load/save settings from dotfiles
echo "configuring iterm2 to use dotfiles configuration at ${DOT_ROOT}/dev/iterm2"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${DOT_ROOT}/dev/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

echo "dev/iterm2 subpackage complete"

