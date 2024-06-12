#!/usr/bin/env zsh

set -ex

mkdir -p "${HOME}/bin"
ln -s "${DOT_ROOT}/bin/with_env" "${HOME}/bin/with_env"

