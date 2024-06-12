#!/usr/bin/env zsh

DOT_ROOT="${DOOT_ROOT:-${HOME}/.dotfiles}"
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
echo "creating ~/.secrets"
echo "export DOT_ROOT=${DOT_ROOT}" >> "${HOME}/.secrets"
source "${HOME}/.secrets"

# fire off the usual suspect installers
echo "installing standard packages"
"${DOT_ROOT}/base/install.sh"
"${DOT_ROOT}/zsh/install.sh"
"${DOT_ROOT}/dev/install.sh"
echo "package installs complete"

echo "installation complete!"
echo "press any key to close terminal and open iterm2"
read -n 1 -s

# switch to iterm
open /Applications/iTerm2.app
killall Terminal

