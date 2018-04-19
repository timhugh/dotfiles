#!/bin/bash

# bash/install.sh
#
# creates symlinks in ~/. for:
# .bashrc
# .bash_profile
# .bash_aliases
# .bash_prompt
# .bash_profile.d/

BASH_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

sources='bashrc bash_aliases bash_profile bash_prompt bash_profile.d'

echo 'Backing up old files...'
backup_dir=${HOME}/.bash_backup
mkdir $backup_dir
for f in $sources; do
  src=${HOME}/.$f
  dest=${backup_dir}/$f
  mv -v $src $dest
done

echo 'Symlinking new files...'
for f in $sources; do
  src=${BASH_ROOT}/$f
  dest=${HOME}/.$f
  ln -vs $src $dest
done

echo 'Sourcing new files...'
source ~/.bash_profile

echo 'Done!'
