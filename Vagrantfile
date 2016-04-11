# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "janihur/ubuntu-1404-desktop"
  #config.vm.synced_folder "./inkscape", "/home/vagrant/inkscape"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "3000"
    vb.cpus = 2
  end

  # PROVISION SCRIPT
  $script = <<-SHELL
set -e
sudo add-apt-repository -y ppa:inkscape.dev/trunk
sudo apt-get update
sudo apt-get -y build-dep inkscape
# cdr, visio file format support
sudo apt-get -y install libcdr-dev libvisio-dev
# bitmap tracing and paintbucket
sudo apt-get -y install libpotrace-dev
sudo apt-get -y install bzr ccache autopoint
# cmake build system
sudo apt-get -y install cmake
# GTK3.0 experimental building
sudo apt-get -y install libgtk-3-dev libgdl-3-dev libgtkmm-3.0-dev libgtkspell3-3-dev
bzr checkout lp:inkscape

# TODO: modify LUbuntu default shortcut Ctrl+Alt+T (it collides with Inkscape alignment shortcut)
# TODO: add gedit or some other decent text editor to easy modification inside VM
# TODO: add english keyboard instead of finish

sudo chown vagrant inkscape/ -R  # to allow modifications and rebuild in VM
cd inkscape
export CFLAGS="-g -O0 -Wall" CC="ccache gcc"
export CXXFLAGS="-g -O0 -Wall -std=c++11" CXX="ccache g++"

cmake -D CMAKE_CXX_FLAGS:STRING="$CXXFLAGS -std=c++11" -D WITH_GTK3_EXPERIMENTAL:BOOL=YES -D CMAKE_BUILD_TYPE:STRING=Debug .


#./autogen.sh
#./configure -enable-gtk3-experimental

make -j 2
sudo make install
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

