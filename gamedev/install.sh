#!/usr/bin/env zsh

set -e

echo "installing gamedev package"

echo "bundling brewfile"
/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/gamedev/Brewfile"

echo "gamedev package complete"
