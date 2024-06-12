#!/usr/bin/env zsh

set -e 

echo "installing base/os subpackage"

"${DOT_ROOT}/base/os/dock.sh"
"${DOT_ROOT}/base/os/misc.sh"

echo "base/os subpackage complete"

