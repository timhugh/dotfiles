#!/usr/bin/env zsh

set -e
setopt nullglob

git_repo="git@github.com:timhugh/dotfiles.git"
branch=main
dotfiles_src="https://github.com/timhugh/dotfiles/archive/${branch}.zip"
root="${HOME}/share/dotfiles"

# save stdout descriptor
exec 3>&1
# redirect everything else to a file
mkdir -p "$root"/tmp
timestamp=$(date +%Y%m%d%H%M%S)
logfile="$root/tmp/install-$timestamp.log"
exec > "$logfile" 2>&1

print() {
    echo "$@"
    echo "$@" >&3
}

function install_xcode_tools() {
    if xcode-select -p &> /dev/null
    then
        print "I see you already have Xcode Command Line Tools installed."
        return;
    fi

    print "Let's install Xcode Command Line Tools..."
    # touch this file so softwareupdate will anticipate an xcode install
    touch /tmp/.com.apple.dt.CommandLineTools.installondemand.in-progress
    # get the version of the latest xcode tools and install
    VER="$(softwareupdate --list | grep "\*.*Command Line" | tail -n 1 | sed 's/^[^C]* //')"
    softwareupdate --install "$VER"
    print "Okay, now you have a C compiler."
}

function install_homebrew() {
    if command -v /opt/homebrew/bin/brew &> /dev/null
    then
        print "Nice! You already have Homebrew installed."
        return
    fi

    print "Let's install Homebrew..."
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    print "Great. Now you can install all the things!"
}

function install_rosetta() {
    if [[ "$(uname -m)" != "arm64" ]]; then
        print "You're on an Intel Mac, no need to install Rosetta."
        return
    fi

    if arch -arch x86_64 uname -m &> /dev/null
    then
        print "You already have Rosetta installed."
        return
    fi

    print "Let's install Rosetta..."
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
    print "All done! Now you can run Intel apps on your arm64 Mac."
}

print "Welcome to your friendly dotfiles installer!"
print "I'm going to do most of this quietly, but if you want to see the nitty gritty, check out this logfile:"
print "$logfile"
echo
echo "Hey look at you, log sniffing!"
print
print "We'll start with the basics..."

print "---"
if [[ -d "$root" ]]; then
    print "It looks like you've already got the dotfiles repo at $root"
else
    print "First, we'll download a zip of the dotfiles repo and extract it to $root"
    mkdir -p "$HOME"/share
    curl -L -o "$root".zip "$dotfiles_src"
    unzip "$root".zip -d "$HOME"/share
    rm "$root".zip
    mv "${HOME}/share/dotfiles-${branch}" "$HOME"/share/dotfiles
    print "That's done"
fi

if [[ -e "${HOME}"/.dotfiles ]] && [[ $(readlink -f "${HOME}"/.dotfiles) != "$root" ]]; then
    print "Uh oh!"
    print "You've already got a symlink at ${HOME}/.dotfiles, but it doesn't point to $root"
    print "You'll have to remove that symlink and re-run this script:"
    print "  rm ${HOME}/.dotfiles"
    print
    print "I'll wait here"
    exit 1
elif [[ -e "${HOME}/.dotfiles" ]]; then
    echo "Dotfiles symlink already exists at ${HOME}/.dotfiles"
else
    print "Okay now I'm going to link it to ${HOME}/.dotfiles"
    ln -fs "$HOME"/share/dotfiles "$HOME"/.dotfiles
fi

cd "$root"

print "---"
install_xcode_tools
print "---"
install_homebrew
print "---"
install_rosetta
print "---"

# Determine the set of packages to install
# (required_packages will always be installed)
packages=()
required_packages=(base)
default_packages=(office)
if [[ $(uname) == "Darwin" ]]; then
    default_packages+=(macos node ruby go)
fi
if [[ -z "$*" ]]; then
    print "You didn't specify any packages, so I'll use the default set"
    print "If you want to install a different set, you can pass them as arguments to this script, like: "
    print "  ./install.sh 3dprinting gamedev"
    print
    packages+=("${required_packages[@]}")
    packages+=("${default_packages[@]}")
else
    packages+=("${required_packages[@]}")
    packages+=("${@[@]}")
fi

# confirm installation
print "Here's what I'm going to install:"
for package in "${packages[@]}"; do
    print "  - $package"
done
print "Sound good? (y/N) > "
read -rk 1 reply
echo
[[ $reply == "y" ]] || exit 1

echo "It didn't print in this log, but you said yes!"

mkdir -p "${HOME}/.zsh_profile.d"

print
print "---"
# install packages
for package in "${packages[@]}"; do
    print "Installing $package"

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

print "---"
print "Okay, everything is installed!"

print "Last thing: now that we have git, let's configure the dotfiles repo to point at the remote"
cd "$root"
[[ -d .git ]] || git init
[[ $(git remote get-url origin) == $git_repo ]] || git remote add origin $git_repo

print
print "All done! Enjoy your new dotfiles!"
print "Come see me again if you want more packages!"

