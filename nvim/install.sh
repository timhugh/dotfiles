#!/usr/bin/env zsh

set -e

DOT_ROOT=$(cat "${HOME}/.dotfiles_root")

echo "installing nvim package"

echo "bundling brewfile"
/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/nvim/Brewfile"

echo "linking configuration"
ln -s "${DOT_ROOT}/nvim" "${HOME}/.config/nvim"

echo "nvim package complete"

