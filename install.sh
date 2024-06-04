#!/usr/bin/env zsh

# install xcode tools and wait for completion
xcode-select --install
until $(xcode-select --print-path &> /dev/null)
do
  sleep 5
done

git clone https://github.com/timhugh/dotfiles ${HOME}/.dotfiles

cd ${HOME}/.dotfiles
brew/install.sh
zsh/install.sh
dock/install.sh
git/install.sh

