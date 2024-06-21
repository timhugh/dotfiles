#!/usr/bin/env zsh

set -ex
setopt nullglob

git_repo="git@github.com:timhugh/dotfiles.git"
branch=main
dotfiles_src="https://github.com/timhugh/dotfiles/archive/${branch}.zip"
root="${HOME}/share/dotfiles"

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
    if command -v /opt/homebrew/bin/brew &> /dev/null
    then
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

    # TODO: this is not working; it's installing anyway
    if ! arch -arch x86_64 uname -m &> /dev/null
    then
        echo "Rosetta already installed"
        return
    fi

    echo "Installing Rosetta"
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    echo "Rosetta installed successfully"
}

echo "Welcome to your friendly dotfiles installer!"
echo "Starting with the basics..."
echo

if [[ -d "$root" ]]; then
    echo "Dotfiles repo already exists at $root"
else
    echo "Downloading dotfiles..."
    mkdir -p "$HOME"/share
    curl -L -o "$root".zip "$dotfiles_src"
    unzip "$root".zip -d "$HOME"/share
    rm "$root".zip
    mv "${HOME}/share/dotfiles-${branch}" "$HOME"/share/dotfiles
fi

if [[ -e "${HOME}"/.dotfiles ]] && [[ $(readlink -f "${HOME}"/.dotfiles) != "$root" ]]; then
    echo "Dotfiles symlink exists at ${HOME}/.dotfiles but points to $(readlink -f "${HOME}"/.dotfiles)"
    echo "Please remove the existing symlink and re-run this script:"
    echo "  rm ${HOME}/.dotfiles"
    exit 1
elif [[ -e "${HOME}/.dotfiles" ]]; then
    echo "Dotfiles symlink already exists at ${HOME}/.dotfiles"
else
    echo "Linking to ${HOME}/.dotfiles"
    ln -fs "$HOME"/share/dotfiles "$HOME"/.dotfiles
fi

cd "$root"

install_xcode_tools
install_homebrew
install_rosetta

# Determine the set of packages to install
# (required_packages will always be installed)
packages=()
required_packages=(base)
default_packages=(office)
if [[ $(uname) == "Darwin" ]]; then
    default_packages+=(macos node ruby go)
fi
if [[ -z "$*" ]]; then
    echo "No packages passed to install script. Installing the default set."
    packages+=("${required_packages[@]}")
    packages+=("${default_packages[@]}")
else
    packages+=("${required_packages[@]}")
    packages+=("${@[@]}")
fi

# confirm installation
echo "Install packages?"
for package in "${packages[@]}"; do
    echo "  - $package"
done
echo "(y/N) > "
read -rk 1 reply
echo
[[ $reply == "y" ]] || exit 1

mkdir -p "${HOME}/.zsh_profile.d"

# install packages
for package in "${packages[@]}"; do
    echo "Installing $package"

    cd "$root/packages/$package"

    if [[ -f Brewfile ]]; then
        echo "Bundling brewfile"
        /opt/homebrew/bin/brew bundle
    fi

    for f in *.zsh; do
        dest="${HOME}/.zsh_profile.d/${f%.*}.sh"

        if [[ -e $dest ]]; then
            echo "Skipping $f, file exists at $dest"
            continue
        fi

        echo "Installing $f in zsh profile"
        echo "Linking $f in zsh profile"
        ln -fs "$root/packages/$package/$f" "$dest"

        echo "Sourcing ${dest}"
        source "$dest"
    done

    for f in *.symlink; do
        dest="${HOME}/.${f%.symlink}"
        # TODO: test actual destination of symlink against source using readlink -f
        if [[ -e $dest ]]; then
            echo "Skipping $f, file exists at $dest"
            continue
        fi

        echo "Linking $f in home directory"
        ln -fs "$root/packages/$package/$f" "$dest"
    done

    for f in *.install; do
        echo "Executing installer $f"
        source "$root/packages/$package/$f"
    done

    echo "Done installing $package"
done

echo "Configuring git remote in dotfiles repo"
cd "$root"
[[ -d .git ]] || git init
[[ $(git remote get-url origin) == $git_repo ]] || git remote add origin $git_repo

echo "Dotfiles installed successfully"

