#!/bin/bash

./configure --prefix="$PREFIX"
if [ $(uname -s) == 'Darwin' ]; then
    # Modify Makefiles for gettext
    sed -i.bak -e "s|^LDFLAGS =.*|LDFLAGS = -Wl,-rpath $PREFIX/lib|" gnulib-tests/Makefile Makefile
fi
make
make -j 1 check
make install
