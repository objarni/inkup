# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "janihur/ubuntu-1404-desktop"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "3000"
    vb.cpus = 2
    vb.customize ["modifyvm", :id, "--clipboard", "bidirectional"]
  end

  # PROVISION SCRIPT
  $script = <<-SHELL
# Break on any error
set -e

# Add Inkscape trunk PPA 
sudo add-apt-repository -y ppa:inkscape.dev/trunk
sudo apt-get update

# Minimal Inkscape dependencies
sudo apt-get -y build-dep inkscape

# Extra Inkscape dependencies: cdr, visio file format support
sudo apt-get -y install libcdr-dev libvisio-dev

# Extra Inkscape dependency for bitmap tracing and paintbucket
sudo apt-get -y install libpotrace-dev

# Source & build tools
sudo apt-get -y install bzr ccache autopoint

# cmake build system
sudo apt-get -y install cmake

# GTK3.0 experimental building
sudo apt-get -y install libgtk-3-dev libgdl-3-dev libgtkmm-3.0-dev libgtkspell3-3-dev

# Get the source!
bzr checkout lp:inkscape

# To enable rebuilding inside VM (file modifications)
sudo chown vagrant inkscape/ -R

# Create Makefiles with cmake build system
cd inkscape
export CFLAGS="-g -O0 -Wall"
export CC="ccache gcc"
export CXXFLAGS="-g -O0 -Wall -std=c++11"
export CXX="ccache g++"
cmake -D CMAKE_CXX_FLAGS:STRING="$CXXFLAGS" -D WITH_GTK3_EXPERIMENTAL:BOOL=YES -D CMAKE_BUILD_TYPE:STRING=Debug .

# US keyboard not Finnish!
setxkbmap -layout us

# Old build system
#./autogen.sh
#./configure -enable-gtk3-experimental

# Compile Inkscape
make -j 2

# Install newly built Inkscape
sudo make install

# Finished!
echo "Inkscape built successfully. To run inkscape:"
echo "1. Login to the VM with user vagrant, password vagrant"
echo "2. Make some changes in /home/vagrant/inkscape/src"
echo "3. Re-build Inkscape*"
echo "4. Run the binary /home/vagrant/inkscape/src/inkscape"
echo ""
echo "*To build inkscape showing only errors (no warnings):"
echo ""
echo "      make -j2 2>&1 >/dev/null | grep error"
  SHELL
  

  config.vm.provision "shell", inline: $script
end

