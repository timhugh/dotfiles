dot_root="${HOME}/git/timhugh/dotfiles"

function replace_symlink() {
    local src="$1"
    local dest="$2"

    if [[ -e "$dest" && ! -L "$dest" ]]; then
        echo "Hold up! There's something at $dest."
        echo "  (d)elete it"
        echo "  (b)ack it up"
        echo "  (S)kip linking"
        echo "  or ctrl-c to abort installer"
        echo "> "
        read -rk 1 action
        echo
        if [[ $action == "d" ]]; then
            echo "Deleting $dest"
            rm -rf "$dest"
        elif [[ $action == "b" ]]; then
            timestamp=$(date +%Y%m%d%H%M%S)
            echo "Backing up $dest to ${dest}.backup.${timestamp}"
            mv "$dest" "${dest}.backup.${timestamp}"
        else
            echo "Skipping linking for $dest"
            return
        fi
    fi
    rm -f "$dest"
    ln -s "$src" "$dest"
}
