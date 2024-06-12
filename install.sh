#!/usr/bin/env zsh

set -e

DOT_ROOT="${DOOT_ROOT:-${HOME}/.dotfiles}"
echo "${DOT_ROOT}" > "${HOME}/.dotfiles_root"

echo "installing dotfiles to ${DOT_ROOT}"

if xcode-select --print-path &> /dev/null
then
    echo "xcode tools are already installed"
else
    echo "launching xcode installer"
    # install xcode tools and wait for completion
    xcode-select --install
    until xcode-select --print-path &> /dev/null
    do
        sleep 5
    done
    echo "xcode install complete!"
fi

if [ -d "${DOT_ROOT}" ]
then
    echo "skipping clone -- dotfiles found in ${DOT_ROOT}"
else
    echo "cloning dotfiles repo to ${DOT_ROOT}"

    git clone "https://github.com/timhugh/dotfiles" "${DOT_ROOT}"

    mkdir -p ${HOME}/git
    ln -s "${DOT_ROOT}" "${HOME}/git/dotfiles"

    echo "dotfiles cloned!"
fi

# create secrets file with first "secret"
#
# secrets is a bit of a misnomer; this does often contain api keys and the like
# but I also use it for system-specific configuration that I don't want in this repo

if [ ! -f "${HOME}/.secrets" ]
then
    echo "creating ~/.secrets"
    touch "${HOME}/.secrets"
fi
source "${HOME}/.secrets"
if [ -z "${DOT_ROOT}" ]
then
    echo "adding DOT_ROOT to ~/.secrets"
    echo "export DOT_ROOT=${DOT_ROOT}" >> "${HOME}/.secrets"
fi
source "${HOME}/.secrets"

# fire off the usual suspect installers
echo "installing standard packages"
"${DOT_ROOT}/base/install.sh"
"${DOT_ROOT}/zsh/install.sh"
"${DOT_ROOT}/dev/install.sh"
echo "package installs complete"

echo "installation complete!"

# switch to iterm
if [ $TERM_PROGRAM != "iTerm.app"]
then
    echo "killing terminal and launching iterm2"
    read -s -k "?press any key to continue"

    open /Applications/iTerm.app
    killall Terminal
fi

