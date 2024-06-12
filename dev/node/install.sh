#!/usr/bin/env zsh

set -e

DOT_ROOT=$(cat "${HOME}/.dotfiles_root")

echo "installing dev/node subpackage"

echo "bundling brewfile"
/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/dev/node/Brewfile"

echo "configuring nodenv plugins"
alias nodenv="/opt/homebrew/bin/nodenv"
mkdir -p "$(nodenv root)/plugins"
git clone https://github.com/nodenv/nodenv-update.git "$(nodenv root)/plugins/nodenv-update"

ln -s "${DOT_ROOT}/dev/node/node-version" "${HOME}/.node-version"
VERSION=$(cat "${DOT_ROOT}/dev/node/node-version")

echo "installing node ${VERSION}"
nodenv install ${VERSION}

echo "dev/node subpackage complete"

