#!/usr/bin/env zsh

set -e

git_repo="git@github.com:timhugh/dotfiles.git"

function install_xcode_tools() {
    if xcode-select -p &> /dev/null
    then
        echo "Xcode tools already installed"
        return;
    fi

    echo "Installing Xcode Command Line Tools"
    # touch this file so softwareupdate will anticipate an xcode install
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    # get the version of the latest xcode tools and install
    VER="$(softwareupdate --list | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')"
    softwareupdate --install "$VER"
    echo "Xcode Command Line Tools installed successfully"
}

function install_homebrew() {
    if [[ command -v /opt/homebrew/bin/brew ]]; then
        echo "Homebrew already installed"
        return
    fi

    echo "Installing Homebrew"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Homebrew installed successfully"
}

function install_rosetta() {
    if [[ "$(uname -m)" != "arm64" ]]; then
        echo "Rosetta install not needed"
        return
    fi

    if [[ ! "(arch -arch x86_64 uname -m &> /dev/null)" ]]
    then
        echo "Rosetta already installed"
        return
    fi

    echo "Installing Rosetta"
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    echo "Rosetta installed successfully"
}

root="${HOME}"/.dotfiles
echo "Installing dotfiles to $root"
echo "Starting with the basics..."
echo

install_xcode_tools
install_homebrew
install_rosetta

echo "Checking to see if dotfiles repo already exists at $root..."
if [[ -d "$root" ]]; then
    echo "Dotfiles repo already exists. Updating..."
    cd "$root"
    git pull
else
    echo "Dotfiles repo does not exist. Cloning..."
    git clone "$git_repo" "$root"
    echo "Dotfiles repo cloned successfully"
fi
echo "Linking to ${HOME}/share/dotfiles..."
ln -s "$root" "${HOME}"/share/dotfiles

cd $root

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

echo "Dotfiles installed successfully"
