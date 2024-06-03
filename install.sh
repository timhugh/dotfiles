#!/usr/bin/env zsh

# install xcode tools and wait for completion
xcode-select --install
until $(xcode-select --print-path &> /dev/null)
do
  sleep 5
done

git clone https://github.com/timhugh/dotfiles ${HOME}/.dotfiles

${HOME}/.dotfiles/brew/install.sh
${HOME}/.dotfiles/zsh/install.sh
${HOME}/.dotfiles/dock/install.sh

