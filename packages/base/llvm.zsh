# sys_root="$(xcrun --show-sdk-path)"
#
# export CC="$(mise which clang) -isysroot ${sys_root}"
# export CXX="$(mise which clang++) -isysroot ${sys_root}"
#
# export CFLAGS="-isysroot ${sys_root} ${CFLAGS}"
# export CXXFLAGS="-isysroot ${sys_root} ${CXXFLAGS}"
# export LDFLAGS="-isysroot ${sys_root} ${LDFLAGS}"
#
