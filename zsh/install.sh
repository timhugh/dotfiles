#!/usr/bin/env zsh

set -e

DOT_ROOT="$(git rev-parse --show-toplevel)"

if [ -d $ZSH ]
then
  echo "oh-my-zsh is already installed; skipping"
  exit 0
fi

# install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# link configuration files
ln -s ${DOT_ROOT}/zsh/zshrc ${HOME}/.zshrc
ln -s ${DOT_ROOT}/zsh/zsh_aliases ${HOME}/.zsh_aliases
ln -s ${DOT_ROOT}/zsh/zsh_profile.d ${HOME}/.zsh_profile.d

