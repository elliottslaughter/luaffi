#!/bin/bash

set -e
set -x

LUA_VERSION=${LUA_VERSION:-5.2.4}
export LUA_PREFIX=$PWD/install
if [[ $(uname) == Linux ]]; then
    LUA_TARGET=linux
elif [[ $(uname) == Darwin ]]; then
    LUA_TARGET=macosx
else
    LUA_TARGET=posix
fi

if [[ ! -d $LUA_PREFIX ]]; then
    mkdir $LUA_PREFIX

    curl -o lua-$LUA_VERSION.tar.gz https://www.lua.org/ftp/lua-$LUA_VERSION.tar.gz
    tar xfz lua-$LUA_VERSION.tar.gz
    rm lua-$LUA_VERSION.tar.gz

    pushd lua-$LUA_VERSION
    make $LUA_TARGET install INSTALL_TOP="$LUA_PREFIX"
    popd
fi

export PATH="$PATH:$LUA_PREFIX/bin"

make clean
make all
make test
