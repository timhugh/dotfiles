#!/usr/bin/env zsh

echo "installing dev package"

echo "bundling brewfile"
/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/dev/Brewfile"

"${DOT_ROOT}/dev/iterm2/install.sh"
"${DOT_ROOT}/dev/git/install.sh"

echo "dev package complete"

