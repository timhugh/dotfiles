#!/usr/bin/env zsh

set -ex

DOT_ROOT="${DOOT_ROOT:-${HOME}/.dotfiles}"

if xcode-select --print-path &> /dev/null
then
    echo "xcode tools are already installed"
else
    # install xcode tools and wait for completion
    xcode-select --install
    until xcode-select --print-path &> /dev/null
    do
        sleep 5
    done
fi

if [ ! -f "${DOT_ROOT}" ]
then
    # clone this repo and link it in the git projects dir
    git clone "https://github.com/timhugh/dotfiles" "${DOT_ROOT}"
    mkdir -p ${HOME}/git
    ln -s "${DOT_ROOT}" "${HOME}/git/dotfiles"
fi

# create secrets file with first "secret"
#
# secrets is a bit of a misnomer; this does often contain api keys and the like
# but I also use it for system-specific configuration that I don't want in this repo
echo "export DOT_ROOT=${DOT_ROOT}" >> "${HOME}/.secrets"
source "${HOME}/.secrets"

# fire off the usual suspect installers
"${DOT_ROOT}/base/install.sh"
"${DOT_ROOT}/zsh/install.sh"
"${DOT_ROOT}/dev/install.sh"

# switch to iterm
open /Applications/iTerm2.app
killall Terminal

