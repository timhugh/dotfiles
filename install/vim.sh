# install/vim.sh
#
# creates symlinks in ~/. for:
# .vim
# .vimrc
# .config/nvim
#
# clones Vundle and installs all plugins from .vimrc

vim_root="${DOT_ROOT}/vim"

echo Backing up existing .vim, .vimrc, .config/nvim...
_backup "${HOME}/.vimrc" "vim"
_backup "${HOME}/.vim" "vim"
_backup "${HOME}/.config/nvim" "vim"

echo Linking new files...
_ln "${vim_root}"              "${HOME}/.vim"
_ln "${vim_root}/vimrc"        "${HOME}/.vimrc"
_mkdir "${HOME}/.config"
_ln "${vim_root}/nvim"         "${HOME}/.config/nvim"

echo Cloning and installing vim plugins...
vundle_dir=${vim_root}/bundle/Vundle.vim
_mkdir $vundle_dir
log_quiet git clone https://github.com/VundleVim/Vundle.vim.git $vundle_dir
vim +PluginClean +PluginInstall +qall
