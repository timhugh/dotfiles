#!/usr/bin/env zsh

set -e

echo "installing dev/iterm2 subpackage"

# load/save settings from dotfiles
echo "configuring iterm2 to use dotfiles configuration at ${DOT_ROOT}/dev/iterm2"
defaults write com.googlecode.iterm2 PrefsCustomFolder -string "${DOT_ROOT}/dev/iterm2"
defaults write com.googlecode.iterm2 LoadPrefsFromCustomFolder -bool true

echo "installing meslo nerd font"
wget -O "${DOT_ROOT}/tmp/Meslo.zip" "https://github.com/ryanoasis/nerd-fonts/releases/download/v3.2.1/Meslo.zip"
unzip -D "${DOT_ROOT}/tmp/Meslo" "${DOT_ROOT}/tmp/Meslo.zip"
cp "${DOT_ROOT}/tmp/Meslo/*.ttf" "${HOME}/Library/Fonts"

echo "dev/iterm2 subpackage complete"
