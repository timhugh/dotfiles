if [[ -d ${HOME}/share/nvim-macos-arm64 ]]; then
    export EDITOR="${HOME}/share/nvim-macos-arm64/bin/nvim"
else
    export EDITOR='nvim'
fi
alias e="$EDITOR"
alias ev="neovide"

