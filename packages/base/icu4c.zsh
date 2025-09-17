icu4c="$(brew --prefix icu4c)"

export PATH="$icu4c/bin:$PATH"
export PATH="$icu4c/sbin:$PATH"

export LDFLAGS="-L$icu4c/lib $LDFLAGS"
export CPPFLAGS="-I$icu4c/include $CPPFLAGS"
export PKG_CONFIG_PATH="$icu4c/lib/pkgconfig:$PKG_CONFIG_PATH"

