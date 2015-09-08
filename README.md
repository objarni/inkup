inkup
=====

*inkup* is an attempt to write a Vagrantfile capable of building a
virtual machine which can build Inkscape Trunk from sources.

It uses a Lubuntu Desktop 14.04 VM as it's base.

inkup was inspired by [this forum thread](http://inkscape.13.x6.nabble.com/Inkscape-with-Vagrant-Test-Inkscape-with-only-3-commands-td4969224.html|this thread).

To build Inkscape Trunk
-----------------------

1. git clone <repo url> inkup
2. cd inkup
3. vagrant up

The provision-script is written inline inside the Vagrantfile, and
basically adds the PPA for Inkscape Trunk to the VM, followed by
intsalling all packages necessary to build Inkscape from sources,
and finally builds Inkscape.


To run Inkscape Trunk
---------------------

Once the build is finished (this will take at least 15 minutes, or
more if you do not have the VM base image to start with), you can
log into the VM using username 'vagrant' and password 'vagrant'.

Then, navigate to /home/vagrant/src, where you will find the "inkscape"
binary which is the fresh Inkscape Trunk build.


