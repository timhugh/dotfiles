#!/usr/bin/env zsh

set -e

DOT_ROOT=$(cat "${HOME}/.dotfiles_root")

echo "installing bin package"

echo "creating ~/bin"
mkdir -p "${HOME}/bin"
echo "installing with_env"
ln -s "${DOT_ROOT}/bin/with_env" "${HOME}/bin/with_env"

echo "bin package complete"

