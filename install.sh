#!/usr/bin/env zsh

# if dotfiles repo exists
#   git update repo
# else
#   Download dotfiles repo to ${HOME}/.dotfiles

# Link to ${HOME}/git/dotfiles if not already linked

# CD into dotfiles directory
root=$(pwd)

# Determine the set of packages to install
# (required_packages will always be installed)
packages=()
required_packages=(base)
default_packages=(office)
if [[ $(uname) == "Darwin" ]]; then
  default_packages+=(macos)
fi
if [[ -z $@ ]]; then
  echo "No packages passed to install script. Installing the default set."
  packages+=$required_packages
  packages+=$default_packages
else
  packages+=$required_packages
  packages+=($@)
fi

# confirm installation
echo "Install packages?"
for package in $(echo $packages); do
  echo "  - $package"
done
read -q "REPLY? (y/N)? "
echo
[[ $REPLY == "y" ]] || exit 1

# install packages
for package in $(echo $packages); do
  echo "Installing $package"

  cd "$root/packages/$package"

  if [[ -f Brewfile ]]; then
    echo "Bundling brewfile"
    /opt/homebrew/bin/brew bundle
  fi

  for f in *.zsh; do
    echo "Linking $f in zsh profile"
    ln -s "$root/packages/$package/$f" "${HOME}/.zsh_profile.d/$f"
  done

  for f in *.symlink; do
    echo "Linking $f in home directory"
    ln -s "$root/packages/$package/$f" "${HOME}/.${f%.symlink}"
  done

  for f in *.install; do
    echo "Executing installer $f"
    source "$root/packages/$package/$f"
  done

  echo "Done installing $package"
done
cd $root

# add git remote to dotfiles repo
git remote add origin git@github.com:timhugh/dotfiles.git
git branch -u origin/main

