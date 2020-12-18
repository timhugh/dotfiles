#!/bin/bash

DOT_ROOT="$(git rev-parse --show-toplevel)"
ZSH_DIR="${DOT_ROOT}/modules/zsh/src"

OS="$(${DOT_ROOT}/install/os-detect.sh)"

CURRENT_ZSH=$(command -v zsh)
if [ $CURRENT_ZSH ]; then
  echo "Found ZSH: ${CURRENT_ZSH}; skipping install"
else
  echo "Installing ZSH..."
  if [ $OS = "Mac" ]; then
    brew install zsh
  else
    sudo apt install zsh
  fi
fi
CURRENT_ZSH=$(command -v zsh)

if [ ${SHELL} = ${CURRENT_ZSH} ]; then
  echo "Current shell is: ${SHELL}. No need to change"
else
  echo "Current shell is: ${SHELL}."
  echo "Changing default shell to ${CURRENT_ZSH}... (will prompt for password)"
  chsh -s ${CURRENT_ZSH}
fi

if [ -d ${HOME}/.oh-my-zsh ]; then
  echo "Found oh-my-zsh config dir; skipping install"
else
  echo "Installing oh-my-zsh..."
  mkdir -p ${DOT_ROOT}/tmp
  wget -O ${DOT_ROOT}/tmp/oh-my-zsh-installer.sh https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
  CHSH=no RUNZSH=no KEEP_ZSHRC=yes sh ${DOT_ROOT}/tmp/oh-my-zsh-installer.sh
fi

echo "Linking configuration..."
ln -s ${ZSH_DIR}/.zshrc ${HOME}/.zshrc
ln -s ${ZSH_DIR}/.zshrc.d ${HOME}/.zshrc.d
ln -s ${ZSH_DIR}/.zsh_aliases ${HOME}/.zsh_aliases
