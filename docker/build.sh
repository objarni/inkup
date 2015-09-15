#!/bin/bash

bzr checkout lp:inkscape
cd inkscape
export CFLAGS="-g -O0 -Wall" CC="ccache gcc"
export CXXFLAGS="-g -O0 -Wall" CXX="ccache g++"
./autogen.sh
./configure
make
sudo make install
echo "Inkscape built successfully. To run inkscape:"
echo "1. Login to the VM with user vagrant, password vagrant"
echo "2. Run the binary /home/vagrant/inkscape/src/inkscape"
