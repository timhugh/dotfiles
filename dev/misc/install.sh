#!/usr/bin/env zsh

set -e

DOT_ROOT=$(cat "${HOME}/.dotfiles_root")

echo "installing dev/misc subpackage"

MISC_ROOT="${DOT_ROOT}/dev/misc"

# sqlite config
echo "installing sqlite config"
test -f "${HOME}/.sqliterc" || ln -s "${MISC_ROOT}/sqliterc" "${HOME}/.sqliterc"

echo "dev/misc subpackage complete"

