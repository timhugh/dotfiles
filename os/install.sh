#!/usr/bin/env zsh

set -e

DOT_ROOT="$(git rev-parse --show-toplevel)"

${DOT_ROOT}/os/dock.sh
${DOT_ROOT}/os/misc.sh

