# install/misc.sh
#
# creates symlinks in ~/. for:
# .crontab
# .ctags
# .gitignore
# .gitconfig
# .tmux.conf

misc_root="${DOT_ROOT}/misc"
sources="crontab ctags gitconfig gitignore tmux.conf"

echo Backing up existing ${sources}...
for f in $sources; do
  _backup "${HOME}/.$f" "misc"
done

echo Symlinking new files...
for f in $sources; do
  _ln "${misc_root}/$f" "${HOME}/.$f"
done

echo Done!
