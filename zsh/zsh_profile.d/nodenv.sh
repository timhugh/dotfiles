# config for nodenv
# (github.com/nodenv/nodenv)
export PATH=$HOME/.nodenv/bin:$PATH

if [ -x "$(command -v nodenv)" ]; then
  eval "$(nodenv init -)"
  export PATH=~/.nodenv/shims:$PATH
fi
