# install/atom.sh
#
# creates symlinks in ~/.atom for:
#   config.cson
#   github.cson
#   keymap.cson
#   packages/

atom_root="${DOT_ROOT}/atom"
sources="config.cson github.cson keymap.cson packages"

echo Backing up existing ${sources}...
for f in $sources; do
  _backup "${HOME}/.atom/$f" "atom"
done

echo Symlinking new files...
for f in $sources; do
  _ln "${atom_root}/$f" "${HOME}/.atom/$f"
done

echo Done!
