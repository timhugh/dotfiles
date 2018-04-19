#!/bin/bash

VIM_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

echo Backing up existing .vim, .vimrc, .config/nvim...
_backup "${HOME}/.vimrc" "vim"
_backup "${HOME}/.vim" "vim"
_backup "${HOME}/.config/nvim" "vim"

echo Linking new files...
_ln "${VIM_ROOT}"              "${HOME}/.vim"
_ln "${HOME}/.vim/vimrc"       "${HOME}/.vimrc"
_mkdir "${HOME}/.config"
_ln "${VIM_ROOT}/nvim"         "${HOME}/.config/nvim"

echo Cloning and installing vim plugins...
vundle_dir=${VIM_ROOT}/bundle/Vundle.vim
_mkdir $vundle_dir
log_quiet git clone https://github.com/VundleVim/Vundle.vim.git $vundle_dir
vim +PluginClean +PluginInstall +qall

echo Done!
