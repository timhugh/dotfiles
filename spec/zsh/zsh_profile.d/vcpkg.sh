if [ -d "${HOME}/share/vcpkg" ]
then
    export VCPKG_ROOT="${HOME}/share/vcpkg"
    export PATH="${VCPKG_ROOT}:${PATH}"
fi

