# install/misc.sh
#
# creates symlinks in ~/. for:
# .crontab
# .ctags
# .gitignore
# .gitconfig
# .ideavimrc
# .irbrc
# .tmux.conf
# .ruby-version
# .zshrc

misc_root="${DOT_ROOT}/misc"
sources="crontab ctags gitconfig gitignore ideavimrc irbrc ruby-version tmux.conf zshrc"

echo Backing up existing ${sources}...
for f in $sources; do
  _backup "${HOME}/.$f" "misc"
done

echo Symlinking new files...
for f in $sources; do
  _ln "${misc_root}/$f" "${HOME}/.$f"
done

echo Done!
