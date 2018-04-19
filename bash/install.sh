#!/bin/bash

# bash/install.sh
#
# creates symlinks in ~/. for:
# .bashrc
# .bash_profile
# .bash_aliases
# .bash_prompt
# .bash_profile.d/

bash_root="${DOT_ROOT}/bash"
sources='bashrc bash_aliases bash_profile bash_prompt bash_profile.d'

echo Backing up existing bashrc, bash_aliases, bash_profile...
for f in $sources; do
  _backup "${HOME}/.$f" "bash"
done

echo Symlinking new files...
for f in $sources; do
  _ln "${bash_root}/$f" "${HOME}/.$f"
done

echo Done!
