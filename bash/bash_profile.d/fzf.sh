# config for fzf
# (https://github.com/junegunn/fzf)
if [ -x "$(command -v fzf)" ]; then
  if [[ ! "$PATH" == */usr/local/opt/fzf/bin* ]]; then
    export PATH="$PATH:/usr/local/opt/fzf/bin"
  fi

  # Auto-completion
  [[ $- == *i* ]] && source "/usr/local/opt/fzf/shell/completion.bash" 2> /dev/null

  # Key bindings
  source "/usr/local/opt/fzf/shell/key-bindings.bash"

  # Use fd instead of find
  # (ignores .gitignore files, for one)
  export FZF_DEFAULT_COMMAND="fd --type f"
fi
