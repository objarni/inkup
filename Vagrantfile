# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "janihur/ubuntu-1404-desktop"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "3000"
    vb.cpus = 4
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
    v.customize ["modifyvm", :id, "--vram", "12"]
  end

  # PROVISION SCRIPT
  $script = <<-SHELL
# Break on any error
set -e

# US keyboard not Finnish!
sudo echo "setxkbmap -layout us" >>/home/vagrant/.bashrc

# Add Inkscape trunk PPA 
sudo add-apt-repository -y ppa:inkscape.dev/trunk
sudo apt-get update

# Build tools
sudo apt-get -y install bzr

# Get the source!
cd /home/vagrant
echo "Fetching Inkscape source..."
bzr checkout lp:inkscape

# Install Google Test Framework
cd /home/vagrant/inkscape
sudo ./download-gtest.sh

# Minimal Inkscape dependencies
sudo apt-get -y build-dep inkscape

# Extra Inkscape dependencies: cdr, visio file format support
sudo apt-get -y install libcdr-dev libvisio-dev

# Extra Inkscape dependency for bitmap tracing and paintbucket
sudo apt-get -y install libpotrace-dev

# Build tools
sudo apt-get -y install ccache autopoint

# Couple of editors
sudo apt-get -y install gedit vim

# cmake build system
sudo apt-get -y install cmake cmake-curses-gui

# GTK3.0 experimental building
sudo apt-get -y install libgtk-3-dev libgdl-3-dev libgtkmm-3.0-dev libgtkspell3-3-dev

# Create Makefiles with cmake build system
mkdir /home/vagrant/build-inkscape
cd /home/vagrant/build-inkscape
export CFLAGS="-g -O0 -Wall"
export CC="ccache gcc"
export CXXFLAGS="-g -O0 -Wall -std=c++11"
export CXX="ccache g++"
cmake -D CMAKE_CXX_FLAGS:STRING="$CXXFLAGS" -D WITH_GTK3_EXPERIMENTAL:BOOL=YES -D CMAKE_BUILD_TYPE:STRING=Debug ../inkscape

# To enable rebuilding inside VM (file modifications)
sudo chown vagrant /home/vagrant/inkscape/ -R
sudo chown vagrant /home/vagrant/build-inkscape/ -R

# Old build system
#./autogen.sh
#./configure -enable-gtk3-experimental

# Compile & install Inkscape
cd /home/vagrant/build-inkscape
make -j 2
sudo make install

# Finished!
echo "Inkscape built successfully. To run inkscape:"
echo "1. Login to the VM with user vagrant, password vagrant"
echo "2. Make some changes in /home/vagrant/inkscape/src"
echo "3. Re-build Inkscape*"
echo "4. Run the binary /home/vagrant/build-inkscape/bin/inkscape"
echo ""
echo "*To build inkscape showing only errors (no warnings):"
echo ""
echo "      make -j 2>&1 >/dev/null | grep error"
  SHELL
  

  config.vm.provision "shell", inline: $script
end

