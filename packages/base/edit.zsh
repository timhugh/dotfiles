function edit_cd() {
    local input="$1"
    local path="$(bash "${HOME}/.local/share/edit.sh" "$input")"

    if [ $? -ne 0 ]; then
        return 1
    fi
    cd "$path" || return 1
}

function edit() {
    source "${HOME}/.config/edit.conf" 2>/dev/null || true

    edit_cd "$1" || return 1

    if [ -n "$editor" ] && [ "$editor" != "cd" ]; then
        $editor .
    fi
}

