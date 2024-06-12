#!/usr/bin/env zsh

echo "installing dev/git subpackage"

GIT_ROOT="${DOT_ROOT}/dev/git"

# git config
echo "installing git configuration files"
test -f "${HOME}/.gitconfig" || ln -s "${GIT_ROOT}/gitconfig" "${HOME}/.gitconfig"
test -f "${HOME}/.gitignore" || ln -s "${GIT_ROOT}/gitignore" "${HOME}/.gitignore"

# ssh config
echo "installing ssh configuration files"
mkdir -p "${HOME}/.ssh/config.d"
test -f "${HOME}/.ssh/config" || ln -s "${GIT_ROOT}/sshconfig" "${HOME}/.ssh/config"

# create github key
echo "generating a new ssh key for github"
test -f "${HOME}/.ssh/github_key" || ssh-keygen -f "${HOME}/.ssh/github_key" -q -N ''

echo "dev/git subpackage complete"

