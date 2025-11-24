#!/usr/bin/env zsh

set -euo pipefail
setopt nullglob

source ./_util.sh

echo "Welcome to your friendly dotfiles installer!"
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
    echo "  ./install.sh 3dprinting gamedev"
    echo
    packages+=("${default_packages[@]}")
else
    packages+=("${@[@]}")
fi

echo "Here's what I'm going to install:"
for package in "${packages[@]}"; do
    echo "  - $package"
done
print "Sound good? (y/N) > "
read -rk 1 reply
echo
[[ $reply == "y" ]] || exit 1

mkdir -p "${HOME}/.zsh_profile.d"

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
        echo "Sourcing ${dest}"
        source "$dest"
    done

    for f in *.symlink; do
        dest="${HOME}/.${f%.symlink}"
        echo "Installing ${dest}"
        replace_symlink "$dot_root/packages/$package/$f" "$dest"
    done

    for f in *.config; do
        dest="${HOME}/.config/${f%.config}"
        mkdir -p "${HOME}/.config"
        echo "Installing ${dest}"
        replace_symlink "$dot_root/packages/$package/$f" "$dest"
    done

    for f in *.bin; do
        dest="${HOME}/.local/bin/${f%.bin}"
        mkdir -p "${HOME}/.local/bin"
        echo "Installing ${dest}"
        replace_symlink "$dot_root/packages/$package/$f" "$dest"
    done

    for f in *.mise; do
        echo "Executing mise installer $f"
        source "$dot_root/packages/$package/$f"
    done

    for f in *.install; do
        echo "Executing installer $f"
        source "$dot_root/packages/$package/$f"
    done

    echo "Done installing $package"
done
