#!/usr/bin/env zsh

set -e

DOT_ROOT=$(cat "${HOME}/.dotfiles_root")

echo "installing 3dprinting subpackage"

echo "bundling brewfile"
/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/3dprinting/Brewfile"

echo "3dprinting package complete"

