# config for nodenv
# (github.com/nodenv/nodenv)
export PATH="${HOME}"/.nodenv/bin:"${PATH}"

if command -v nodenv; then
  eval "$(nodenv init -)"
  export PATH="${HOME}"/.nodenv/shims:"${PATH}"
fi

