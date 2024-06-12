#!/usr/bin/env zsh

set -ex

GIT_ROOT="${DOT_ROOT}/dev/git"

# git config
test -f "${HOME}/.gitconfig" || ln -s "${GIT_ROOT}/gitconfig" "${HOME}/.gitconfig"
test -f "${HOME}/.gitignore" || ln -s "${GIT_ROOT}/gitignore" "${HOME}/.gitignore"

# ssh config
mkdir -p "${HOME}/.ssh/config.d"
test -f "${HOME}/.ssh/config" || "ln -s ${GIT_ROOT}/sshconfig" "${HOME}/.ssh/config"

# create github key
test -f "${HOME}/.ssh/github_key" || ssh-keygen -f "${HOME}/.ssh/github_key" -q -N ''

