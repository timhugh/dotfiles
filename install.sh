#!/usr/bin/env zsh

DOT_ROOT=${DOOT_ROOT:-${HOME}/.dotfiles}

# install xcode tools and wait for completion
xcode-select --install
until $(xcode-select --print-path &> /dev/null)
do
  sleep 5
done

git clone "https://github.com/timhugh/dotfiles" "${DOT_ROOT}"
mkdir -p ${HOME}/git
ln -s "${DOT_ROOT}" "${HOME}/git/dotfiles"

if [ ! -f "${HOME}/.env" ];
then
    ln -s "${DOT_ROOT}/zsh/env" "${HOME}/.env"
    echo "DOT_ROOT=${DOT_ROOT}" >> "${HOME}/.env"
fi
source "${HOME}/.env"

./base/install.sh
./zsh/install.sh
./dev/install.sh

# switch to iterm
open /Applications/iTerm2.app
killall Terminal

