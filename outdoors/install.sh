#!/usr/bin/env zsh

echo "installing outdoors package"

echo "bundling brewfile"
/opt/homebrew/bin/brew bundle --file "${DOT_ROOT}/outdoors/Brewfile"

echo "outdoors package complete"

