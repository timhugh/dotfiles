# config for nodenv
# (github.com/nodenv/nodenv)
if [ -x "$(command -v nodenv)" ]; then
  eval "$(nodenv init -)"
  export PATH=~/.nodenv/shims:$PATH
fi
