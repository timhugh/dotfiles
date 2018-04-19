#!/bin/bash

# bash/install.sh
#
# creates symlinks in ~/. for:
# .bashrc
# .bash_profile
# .bash_aliases
# .bash_prompt
# .bash_profile.d/

src_files='bashrc bash_aliases bash_profile bash_prompt'

echo 'Backing up old files...'
mkdir ~/.bash_backup
for f in $src_files; do mv -v ~/.$f ~/.bash_backup/$f; done

echo 'Symlinking new files...'
for f in $src_files; do ln -vs `pwd`/$f ~/.$f; done
# TODO if ~/.bash_profile.d already exists, this creates a symlink inside the dir
ln -vs `pwd`/bash_profile.d ~/.bash_profile.d

echo 'Sourcing new files...'

source ~/.bash_profile

echo 'Done!'
