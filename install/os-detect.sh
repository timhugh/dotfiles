#!/bin/sh

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     machine=Linux;;
    Darwin*)    machine=Mac;;
esac
if [[ ${machine} = "Linux" ]] && [[ $(grep -q icrosoft /proc/version) ]];
then
  machine=WSL
fi
echo ${machine}
