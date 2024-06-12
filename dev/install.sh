#!/usr/bin/env zsh

set -e

DOT_ROOT=$(cat "${HOME}/.dotfiles_root")

echo "installing dev package"

echo "bundling brewfile"
/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/dev/Brewfile"

"${DOT_ROOT}/dev/iterm2/install.sh"

"${DOT_ROOT}/dev/git/install.sh"

"${DOT_ROOT}/dev/ruby/install.sh"

"${DOT_ROOT}/dev/node/install.sh"

"${DOT_ROOT}/dev/misc/install.sh"

echo "dev package complete"

