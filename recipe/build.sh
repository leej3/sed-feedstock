#!/bin/bash

set -ex

./configure --prefix="$PREFIX"

if [[ $(uname) == Linux ]]; then
    # Remove test broken in sed 4.4
    sed -i.bak -e 's|testsuite/panic-tests.sh||' Makefile
fi

make $VERBOSE_AT
make -j 1 check || { cat ./test-suite.log; exit 1; }
make install
