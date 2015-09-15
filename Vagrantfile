# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|

  config.vm.box = "janihur/ubuntu-1404-desktop"
  config.vm.synced_folder ".", "/home/vagrant"
  config.vm.provider "virtualbox" do |vb|
    vb.gui = true
    vb.memory = "3000"
    vb.cpus = 4
  end

  # PROVISION SCRIPT
  $script = <<-SHELL
set -e
sudo add-apt-repository -y ppa:inkscape.dev/trunk
sudo apt-get update
sudo apt-get -y build-dep inkscape
sudo apt-get -y install bzr ccache autopoint
bzr checkout lp:inkscape
cd inkscape
export CFLAGS="-g -O0 -Wall" CC="ccache gcc"
export CXXFLAGS="-g -O0 -Wall" CXX="ccache g++"
./autogen.sh
./configure
make -j
sudo make install
echo "Inkscape built successfully. To run inkscape:"
echo "1. Login to the VM with user vagrant, password vagrant"
echo "2. Run the binary /home/vagrant/inkscape/src/inkscape"
  SHELL

  config.vm.provision "shell", inline: $script
end
