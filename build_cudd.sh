#!/bin/bash

# download the the CUDD library
wget ftp://vlsi.colorado.edu/pub/cudd-3.0.0.tar.gz

tar -zxvf cudd-3.0.0.tar.gz
cd cudd-3.0.0

# complie the CUDD shared library
./configure --enable-silent-rules --enable-shared --enable-obj
make -j4 check
make install