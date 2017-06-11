![alt tag](http://i.imgur.com/hrOux06.png)


inkup
=====
**inkup** is an attempt to write a Vagrantfile capable of building a virtual machine, which in turn can build Inkscape Trunk from sources.


Why?
----
I've been interested in contributing to the great open source vector-graphics editor [Inkscape](https://inkscape.org/) for years. However, every time I've started reading the build instructions, I've stopped because of all the build dependencies which would "mess up" my computer. Inkscape is written primarily in C/C++, with extension support via an embedded Python interpreter -- and there's probably a lot more that I don't even know of. On top of that, it's got a huge list of build dependencies, not only direct dependencies but also build system dependencies.

After years of building up courage, I spent a weekend making Inkscape compile, then modified the Rectangle Tool to always place the resulting rectangle object at (0, 0). What a feeling seeing Inkscape behaving in this irratic way because I told it to!

Also during that weekend, I started writing this Vagrantfile, so the effort could be re-used for someone else and lower the threshold to build Inkscape from sources. It also means restarting development a breeze, e.g. if you re-install your OS or switch computer.

**inkup** was inspired by [this forum thread](http://inkscape.13.x6.nabble.com/Inkscape-with-Vagrant-Test-Inkscape-with-only-3-commands-td4969224.html).


The VM
------
The base VM O/S is Lubuntu Desktop 14.04-64 bit.


Dependencies
------------
1. [VirtualBox](https://www.virtualbox.org/) - tested with version 4.3.10, 4.3.26 and 5.0.14, host OS Windows 7, Ubuntu 14.04 and 15.10. Make sure you enable virtualization technology in your UEFI/BIOS boot settings.
2. [Vagrant](https://www.vagrantup.com/) - tested with Vagrant 1.7.2 and 1.7.4.


Building Inkscape Trunk
-----------------------
1. **git clone git@github.com:objarni/inkup.git** (or you could just download the Vagrantfile in this repo, and ignore git altogether)
2. **cd inkup** (mkdir inkup if you ignored git!)
3. **vagrant up** (this command needs Vagrantfile in the same directory to work!)
4. **Enjoy the build process** Depending on your computers and network speed, wait from 30 mins to several hours (don't worry - rebuilding Inkscape from within the VM will be a lot faster!)

What happens on "vagrant up"?
-----------------------------
The provisioning script is defined in the Vagrantfile, and basically what it does is:

1. Downloads and imports a Lubuntu 14.04 virtual machine image for VirtualBox
2. Adds the PPA for Inkscape Trunk to the VM
3. Installing all packages necessary to build Inkscape from sources
4. Gets the Inkscape source from Launchpad (this step is quite slow; if you think the process has hanged after saying "You have not informed bzr of your Launchpad ID, ..." give it 30 more minutes to try and finish)
5. Builds Inkscape
6. Write a finished message with what you can do next (e.g. run Inkscape from within the VM)


Hey! A weird Ubuntu looking Window pops up during build!
--------------------------------------------------------
Yeah, that is by design. You want to see Inkscape - after all it's a graphical editor, not some server software :)

Just minimize the VM window during the build, and enter it when the build is finished to run your fresh, home-brewn version of Inkscape.


Running Inkscape Trunk
----------------------
Once the build is finished (this will take at least 15 minutes, or more if you do not have the VM base image to start with), you can log into the VM using username 'vagrant' and password 'vagrant'.

The Inkscape binary will be built to `/home/vagrant/build-inkscape/bin/inkscape` inside of the VM.


Updating and rebuilding
-----------------------
To update and rebuild Inkscape, you need to get your hands dirty and work from inside the VM.

1. Step into the VM (user/pw vagrant/vagrant), decline the update
2. Open a terminal (Menu at bottom left, System Tools > XTerm)
2. cd inkscape
3. bzr update
4. cd ../build-inkscape
5. make

If you get into a messed-up state:

1. cd ~/build-inkscape
2. cmake clean-cmake-files
3. cmake ../inkscape
4. make


Caveats
-------
The shared folder feature of Vagrant / VirtualBox does not work so you cannot browse the source in your host OS
which would be nicer than browsing and editing the source inside the VM. I get around this by downloading the
Inkscape source on my host machine too, so I get fast navigation/source reading, and then I make changes in the
VM using gedit or similar.
