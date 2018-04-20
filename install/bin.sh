# install/bin.sh
#
# creates symlinks in ~/bin/

bin_dir="${DOT_ROOT}/bin"
for f in "${bin_dir}"/*; do
  echo Backing up ${HOME}/${f}...
  _backup "${HOME}/bin/$f" "bin"
  echo Symlinking ${HOME}/${f}...
  _ln "$f" "${HOME}/bin/"
done
