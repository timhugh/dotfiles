#!/usr/bin/env zsh

set -ex

# install oh-my-zsh if necessary
test -f "${HOME}/.zshrc" && source "${HOME}/.zshrc"
if [[ -n "$ZSH" && -d $ZSH ]]
then
  echo "oh-my-zsh is already installed; skipping"
else
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# link configuration files
test -f "${HOME}/.zshrc" || ln -s "${DOT_ROOT}/zsh/zshrc ${HOME}/.zshrc"
test -f "${HOME}/.zsh_aliases" || ln -s "${DOT_ROOT}/zsh/zsh_aliases ${HOME}/.zsh_aliases"
test -d "${HOME}/.zsh_profile.d" || ln -s "${DOT_ROOT}/zsh/zsh_profile.d ${HOME}/.zsh_profile.d"

