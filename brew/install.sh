#!/usr/bin/env zsh

set -e

DOT_ROOT="$(git rev-parse --show-toplevel)"

# install Homebrew
if ! command -v brew >/dev/null 2>&1
then
  echo "No homebrew installation found. Starting install script..."
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
else
  echo "homebrew found; skipping installation"
fi

# build master brewfile
: ${PACKAGES:=base dev gamedev outdoors}
echo "Installing all formulas for packages: (${PACKAGES})"
echo > ${HOME}/.Brewfile
for package in $(echo ${PACKAGES}); do
  cat "${DOT_ROOT}/brew/Brewfile.${package}" >> ${HOME}/.Brewfile
done

brew bundle --global

