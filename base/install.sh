#!/usr/bin/env zsh

set -e

# check for homebrew install
if ! command -v /opt/homebrew/bin/brew >/dev/null 2>&1
then
  echo "No homebrew installation found. Starting install script..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "homebrew found; skipping installation"
fi

/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/base/Brewfile"

"${DOT_ROOT}/base/os/install.sh"

