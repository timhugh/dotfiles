#!/usr/bin/env zsh

xcode-select --install

git clone https://github.com/timhugh/dotfiles ${HOME}/.dotfiles

${HOME}/.dotfiles/brew/install.sh
${HOME}/.dotfiles/zsh/install.sh
${HOME}/.dotfiles/dock/install.sh

