#!/usr/bin/env bash

set -euo pipefail
shopt -s nullglob

source ./_util.sh

echo "Welcome to your friendly dotfiles installer!"

########################################
# Detect OS
########################################
os=
if [[ $(uname) == "Darwin" ]]; then
    echo "Detected macOS"
    os="macos"
elif [[ $(uname) == "Linux" ]]; then
    echo "Detected Linux"
    os="linux"
else
    echo "Sorry, I don't know how to speak $(uname) yet."
    exit 1
fi

########################################
# Determine packages to install
########################################
default_packages=(base)
if [[ $os == "macos" ]]; then
    default_packages+=(macos)
elif [[ $os == "linux" ]]; then
    default_packages+=(linux)
fi
packages=()
if [[ -z "$*" ]]; then
    echo "You didn't specify any packages, so I'll use the default set"
    echo "If you want to install a different set, you can pass them as arguments to this script, like: "
    echo "  ./install.sh extras"
    echo
    packages+=("${default_packages[@]}")
else
    packages+=("${@[@]}")
fi

echo "Here's what I'm going to install:"
for package in "${packages[@]}"; do
    echo "  - $package"
done
echo -n "Sound good? (y/N) > "
read -r -n 1 reply
echo
[[ $reply == "y" ]] || exit 1

########################################
# Install packages
########################################
mkdir -p "${HOME}/.zsh_profile.d"
mkdir -p "${HOME}/.zsh_completions.d"
mkdir -p "${HOME}/.local/bin"
mkdir -p "${HOME}/.local/share"
mkdir -p "${HOME}/.config"

echo
for package in "${packages[@]}"; do
    echo "---"
    echo "### Installing $package ###"

    cd "$dot_root/packages/$package"

    if [[ -f "_bundle.${os}" ]]; then
        echo "Installing ${os} bundle"
        source "_bundle.${os}"
    fi

    for f in *.zsh; do
        dest="${HOME}/.zsh_profile.d/${f}"
        echo "Installing ${dest}"
        replace_symlink "$dot_root/packages/$package/$f" "$dest"
    done

    for f in *.zsh_completions; do
        dest="${HOME}/.zsh_completions.d/${f%.zsh_completions}"
        echo "Installing ${dest}"
        replace_symlink "$dot_root/packages/$package/$f" "$dest"
    done

    for f in *.symlink; do
        dest="${HOME}/.${f%.symlink}"
        echo "Installing ${dest}"
        replace_symlink "$dot_root/packages/$package/$f" "$dest"
    done

    for f in *.share; do
        dest="${HOME}/.local/share/${f%.share}"
        echo "Installing ${dest}"
        replace_symlink "$dot_root/packages/$package/$f" "$dest"
    done

    for f in *.config; do
        dest="${HOME}/.config/${f%.config}"
        echo "Installing ${dest}"
        replace_symlink "$dot_root/packages/$package/$f" "$dest"
    done

    for f in *.bin; do
        dest="${HOME}/.local/bin/${f%.bin}"
        echo "Installing ${dest}"
        replace_symlink "$dot_root/packages/$package/$f" "$dest"
    done

    for f in *.mise; do
        echo "Executing mise installer $f"
        source "$dot_root/packages/$package/$f"
    done

    for f in *.install; do
        echo "Executing installer $f"
        "$dot_root/packages/$package/$f"
    done

    echo "Done installing $package"
done
