# install/zsh.sh
#
# creates symlinks in ~/. for:
# .zshrc
# .zsh_aliases
# .zsh_profile.d

zsh_root="${DOT_ROOT}/zsh"
sources='zshrc zsh_aliases zsh_profile.d'

echo Backing up existing zsh profile...
for f in $sources; do
  _backup "${HOME}/.$f" "zsh"
done

echo Symlinking new files...
for f in $sources; do
  _ln "${zsh_root}/$f" "${HOME}/.$f"
done
