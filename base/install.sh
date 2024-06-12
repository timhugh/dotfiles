#!/usr/bin/env zsh

set -e

echo "installing base package"

# check for homebrew install
if ! command -v /opt/homebrew/bin/brew >/dev/null 2>&1
then
  echo "installing homebrew"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "homebrew found; skipping installation"
fi

echo "installing rosetta"
/usr/bin/softwareupdate --install-rosetta --agree-to-license

echo "bundling brewfile"
/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/base/Brewfile"

"${DOT_ROOT}/base/os/install.sh"

echo "base package complete"
