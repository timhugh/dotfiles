#!/usr/bin/env zsh

set -e

/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/dev/Brewfile"

"${DOT_ROOT}/dev/iterm2/install.sh"
"${DOT_ROOT}/dev/git/install.sh"

