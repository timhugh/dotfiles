#!/usr/bin/env zsh

set -e

echo "installing nvim package"

echo "bundling brewfile"
/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/nvim/Brewfile"

echo "nvim package complete"

