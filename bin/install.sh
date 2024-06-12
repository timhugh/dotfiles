#!/usr/bin/env zsh

echo "installing bin package"

echo "creating ~/bin"
mkdir -p "${HOME}/bin"
echo "installing with_env"
ln -s "${DOT_ROOT}/bin/with_env" "${HOME}/bin/with_env"

echo "bin package complete"

