# config for jenv
# http://www.jenv.be/

if [ -d "$HOME/.jenv" ]; then
  export PATH="$HOME/.jenv/bin:$PATH"
  eval "$(jenv init -)"
fi
