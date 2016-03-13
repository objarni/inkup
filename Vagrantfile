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
sudo apt-get -y install bzr ccache autopoint
bzr checkout lp:inkscape
# TODO: modify LUbuntu default shortcut Ctrl+Alt+T (it collides with Inkscape alignment shortcut)
# TODO: add gedit or some other decent text editor to easy modification inside VM
sudo chown vagrant inkscape/ -R  # to allow modifications and rebuild in VM
cd inkscape
export CFLAGS="-g -O0 -Wall" CC="ccache gcc"
export CXXFLAGS="-g -O0 -Wall" CXX="ccache g++"
./autogen.sh
./configure
make -j 2
sudo make install
echo "Inkscape built successfully. To run inkscape:"
echo "1. Login to the VM with user vagrant, password vagrant"
echo "2. Run the binary /home/vagrant/inkscape/src/inkscape"
  SHELL

  config.vm.provision "shell", inline: $script
end
