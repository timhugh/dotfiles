#!/usr/bin/env zsh

set -e

DOT_ROOT="$(git rev-parse --show-toplevel)"

# link config files
test -f ${HOME}/.gitconfig || ln -s ${DOT_ROOT}/git/gitconfig ${HOME}/.gitconfig
test -f ${HOME}/.gitignore || ln -s ${DOT_ROOT}/git/gitignore ${HOME}/.gitignore
mkdir -p ${HOME}/.ssh/config.d
test -f ${HOME}/.ssh/config || ln -s ${DOT_ROOT}/git/sshconfig ${HOME}/.ssh/config

# create github key
test -f ${HOME}/.ssh/github_key || ssh-keygen -f ${HOME}/.ssh/github_key -q -N ''

