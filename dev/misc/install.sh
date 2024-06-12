#!/usr/bin/env zsh

set -ex

MISC_ROOT="${DOT_ROOT}/dev/misc"

# ruby config
test -f "${HOME}/.irbrc" || ln -s "${MISC_ROOT}/irbrc" "${HOME}/.irbrc"
test -f "${HOME}/.ruby-version" || ln -s "${MISC_ROOT}/ruby-version" "${HOME}/.ruby-version"

# sqlite config
test -f "${HOME}/.sqliterc" || ln -s "${MISC_ROOT}/sqliterc" "${HOME}/.sqliterc"


