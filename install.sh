#!/bin/bash

DOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BACKUP_ROOT=${HOME}/.dotfiles_backup

LOG=${HOME}/.dotfiles.log
date > $LOG
function log_quiet {
  "$@" >>$LOG 2>&1
}

function _ln() {
  log_quiet ln -vs $1 $2
}
function _mkdir() {
  log_quiet mkdir -p "$@"
}
function _mv() {
  log_quiet mv -fv "$@"
}
function _rm() {
  log_quiet rm -v "$@"
}
function _backup() {
  src=$1
  dest=${BACKUP_ROOT}/$2

  _mkdir -p $BACKUP_ROOT
  _mkdir -p $dest
  _mv -vf $src $dest/
  _rm -v $src
}

# welcome / config

# install brew and brew packages

########
# BASH #
########
source ${DOT_ROOT}/bash/install.sh

########
# MISC #
########
source ${DOT_ROOT}/misc/install.sh

#######
# VIM #
#######
source ${DOT_ROOT}/vim/install.sh

# prompt for name and email (for git config)

# auth with hub (email, password, 2FA)

# prompt for desired ruby version and install it?

source ${HOME}/.bash_profile
