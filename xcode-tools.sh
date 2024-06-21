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

install_xcode_tools
