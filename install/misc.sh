# install/misc.sh
#
# creates symlinks in ~/. for:
# .crontab
# .ctags
# .gitignore
# .gitconfig
# .irbrc
# .tmux.conf
# .ruby-version

misc_root="${DOT_ROOT}/misc"
sources="crontab ctags gitconfig gitignore irbrc ruby-version tmux.conf"

echo Backing up existing ${sources}...
for f in $sources; do
  _backup "${HOME}/.$f" "misc"
done

echo Symlinking new files...
for f in $sources; do
  _ln "${misc_root}/$f" "${HOME}/.$f"
done

echo Done!
