#!/usr/bin/env zsh

dockutil --remove all
dockutil --add ${HOME} --display folder --view grid
dockutil --add ${HOME}/Downloads --display folder --view grid

