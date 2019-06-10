# config for jenv
# http://www.jenv.be/

if [ -f "$HOME/.jenv" ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi
