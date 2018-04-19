#!/bin/bash

DOT_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# install brew and brew packages

########
# BASH #
########
# creates symlinks in ~/. for:
# .bashrc
# .bash_profile
# .bash_aliases
# .bash_prompt
# .bash_profile.d/
cat <<EOF
----------------------
Installing bash config

EOF
source ${DOT_ROOT}/bash/install.sh

# install misc (ctags, tmuxconf, etc)

# install vimrc

# prompt for name and email (for git config)

# auth with hub (email, password, 2FA)

# prompt for desired ruby version and install it?
