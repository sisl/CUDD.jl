#!/bin/bash

# download the the CUDD library
wget ftp://vlsi.colorado.edu/pub/cudd-3.0.0.tar.gz

tar -zxvf cudd-3.0.0.tar.gz
mv cudd-3.0.0 src/
cd src/cudd-3.0.0

# complie the CUDD shared library
./configure --enable-silent-rules --enable-shared --enable-obj
make -j4 check
sudo make install