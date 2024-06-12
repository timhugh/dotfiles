#!/usr/bin/env zsh

set -e

echo "installing dev/misc subpackage"

MISC_ROOT="${DOT_ROOT}/dev/misc"

# ruby config
echo "installing ruby configuration files"
test -f "${HOME}/.irbrc" || ln -s "${MISC_ROOT}/irbrc" "${HOME}/.irbrc"
test -f "${HOME}/.ruby-version" || ln -s "${MISC_ROOT}/ruby-version" "${HOME}/.ruby-version"

# sqlite config
echo "installing sqlite config"
test -f "${HOME}/.sqliterc" || ln -s "${MISC_ROOT}/sqliterc" "${HOME}/.sqliterc"

echo "dev/misc subpackage complete"

