Docker Based Building
=====================

You can use this docker image to build inkscape in a controlled repeatable environment. We suggest you mount a directory on your computer at /app/src inside the container, so that you can easily inspect the results of the build.

If you only want to build (and not develop), do this:

    $ docker build -t inkscape-build-env .
    ...
    $ docker run -t inkscape-build-env
    ...

A more typical usage pattern might be this:

    $ docker build -t inkscape-build-env .
    ...
    $ mkdir src
    $  docker run -it -v `pwd`/src:/app/src inkscape-build-env bash
    root@abcdef123:/app# build.sh

    $ # in another terminal
    $ cd src
    $ # test the build from the container above
    $ inkscape/src/inskape
    $ # fix a bug!
    $ edit inkscape/src/some_file.c
    $ # now rerun the build.sh in the other terminal
    $ inkscape/src/inskape


Limitations
===========

All of this only makes sense if:

* You're running Linux as your host OS (dom0 in xen-speak)
* You have all the libraries needed to run inkscape

So if you're on Windows, or your host OS is not Ubuntu 15.04, then you should probably stick with the Vagrant alternative.
