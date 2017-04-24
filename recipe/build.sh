#!/bin/bash

./configure --prefix="$PREFIX"
if [ $(uname -s) == 'Darwin' ]; then
    # Modify Makefiles for gettext
    sed -i.bak -e "s|^LDFLAGS =.*|LDFLAGS = -Wl,-rpath $PREFIX/lib|" gnulib-tests/Makefile Makefile
else
    # Remove test broken in sed 4.4
    sed -i.bak -e 's|testsuite/panic-tests.sh||' Makefile
fi
make
make -j 1 check
make install
