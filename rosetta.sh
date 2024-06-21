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

install_rosetta

