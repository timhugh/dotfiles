#!/usr/bin/env zsh

set -e
setopt nullglob

git_repo="git@github.com:timhugh/dotfiles.git"
branch=main
dotfiles_src="https://github.com/timhugh/dotfiles/archive/${branch}.zip"
root="${HOME}/share/dotfiles"

function install_xcode_tools() {
    if xcode-select -p &> /dev/null
    then
        echo "I see you already have Xcode Command Line Tools installed."
        return;
    fi

    echo "Let's install Xcode Command Line Tools..."
    # touch this file so softwareupdate will anticipate an xcode install
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    # get the version of the latest xcode tools and install
    VER="$(softwareupdate --list | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')"
    softwareupdate --install "$VER"
    echo "Okay, now you have a C compiler."
}

function install_homebrew() {
    if command -v /opt/homebrew/bin/brew &> /dev/null
    then
        echo "Nice! You already have Homebrew installed."
        return
    fi

    echo "Let's install Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    echo "Great. Now you can install all the things!"
}

function install_rosetta() {
    if [[ "$(uname -m)" != "arm64" ]]; then
        echo "You're on an Intel Mac, no need to install Rosetta."
        return
    fi

    if arch -arch x86_64 uname -m &> /dev/null
    then
        echo "You already have Rosetta installed."
        return
    fi

    echo "Let's install Rosetta..."
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    echo "All done! Now you can run Intel apps on your arm64 Mac."
}

echo "Welcome to your friendly dotfiles installer!"
echo
echo "We'll start with the basics..."

echo "---"
if [[ -d "$root" ]]; then
    echo "It looks like you've already got the dotfiles repo at $root"
else
    echo "First, we'll download a zip of the dotfiles repo and extract it to $root"
    mkdir -p "$HOME"/share
    curl -L -o "$root".zip "$dotfiles_src"
    unzip "$root".zip -d "$HOME"/share
    rm "$root".zip
    mv "${HOME}/share/dotfiles-${branch}" "$HOME"/share/dotfiles
    echo "That's done"
fi

echo "---"
if [[ -e "${HOME}"/.dotfiles ]] && [[ $(readlink -f "${HOME}"/.dotfiles) != "$root" ]]; then
    echo "Uh oh!"
    echo "You've already got a symlink at ${HOME}/.dotfiles, but it doesn't point to $root"
    echo "You'll have to remove that symlink and re-run this script:"
    echo "  rm ${HOME}/.dotfiles"
    echo
    echo "I'll wait here"
    exit 1
elif [[ -e "${HOME}/.dotfiles" ]]; then
    echo "Dotfiles symlink already exists at ${HOME}/.dotfiles"
else
    echo "Okay now I'm going to link it to ${HOME}/.dotfiles"
    ln -fs "$HOME"/share/dotfiles "$HOME"/.dotfiles
fi

cd "$root"

echo "---"
install_xcode_tools
echo "---"
install_homebrew
echo "---"
install_rosetta

echo "---"
echo "Now that we have the basics, let's install some packages!"

packages=()
default_packages=(base python node ruby go)
if [[ $(uname) == "Darwin" ]]; then
    default_packages+=(macos)
fi
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

    cd "$root/packages/$package"

    if [[ -f Brewfile ]]; then
        echo "Bundling brewfile"
        /opt/homebrew/bin/brew bundle
    fi

    for f in *.zsh; do
        dest="${HOME}/.zsh_profile.d/${f}"

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

    for f in *.config; do
        dest="${HOME}/.config/${f%.config}"
        mkdir -p "${HOME}/.config"
        if [[ -e $dest ]]; then
            echo "Skipping $f, file exists at $dest"
            continue
        fi

        echo "Linking $f in config directory"
        ln -fs "$root/packages/$package/$f" "$dest"
    done

    for f in *.completion; do
        echo "Installing $f as completion"
        dest="${HOME}/.zsh_completions.d/_${f%.completion}"
        if [[ -e $dest ]]; then
            echo "Skipping $f, file exists at $dest"
            continue
        fi

        echo "Linking $f in completion directory"
        ln -fs "$root/packages/$package/$f" "$dest"
    done

    for f in *.install; do
        echo "Executing installer $f"
        source "$root/packages/$package/$f"
    done

    echo "Done installing $package"
done

echo "---"
echo "Okay, everything is installed!"

cd "$root"
echo "Last thing! Checking git remote config for dotfiles repo..."
if [[ ! -d .git ]]; then
    echo "It looks like this is not a git repo, so I'll initialize it now"
    git init
fi
if [[ $(git remote get-url origin) != $git_repo ]]; then
    echo "Let's set the remote origin to $git_repo"
    git remote add origin "$git_repo"
fi

echo
echo "All done! Enjoy your new dotfiles!"
echo "Come see me again if you want more packages!"

