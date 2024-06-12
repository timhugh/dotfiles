#!/usr/bin/env zsh

set -e

DOT_ROOT=$(cat "${HOME}/.dotfiles_root")
RUBY_ROOT="${DOT_ROOT}/dev/ruby"

echo "installing dev/ruby subpackage"

echo "bundling brewfile"
/opt/homebrew/bin/brew bundle --file "${RUBY_ROOT}/Brewfile"

VERSION=$(cat "${RUBY_ROOT}/ruby-version")
echo "installing ruby ${VERSION}"
/opt/homebrew/bin/ruby-install ${VERSION}

echo "installing ruby configuration files"
test -f "${HOME}/.irbrc" || ln -s "${RUBY_ROOT}/irbrc" "${HOME}/.irbrc"
test -f "${HOME}/.ruby-version" || ln -s "${RUBY_ROOT}/ruby-version" "${HOME}/.ruby-version"

echo "dev/ruby subpackage complete"

