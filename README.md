# Gaia Rocking...

This repo is a shell you can use to set up a Gaia hacking environment.

## TL;DR

    git clone --recursive git://github.com/canuckistani/gaia-rocking.git
    cd ./gaia-rocking
    make setup

You can run B2G desktop in two different ways with this setup:

  1. running via make, simple cd to the gaia-rocking directoryr and type `make run`
  2. via Finder, open the gaia-rocking/bin directory and double click on 'Launcher.app'

## Current status notes

### Caveats: 
  * OS X only ( so far, Linux should be easy, Windows likely painful )

### Works: 

  * download and install B2G.app in ./bin
  * updating Gaia as a git submodule
  * running B2G desktop from a helper .app using AppleScript.

### TODO:

  * adding your own apps as submodules
  * some cool method of pushing custom apps(s) to the gaia profile's appcache (???) Need to see if we can re-use stuff from Gaia's makefile

**DISCLAIMER**: this is opiniated and badly written software. Pull requests welcome, but if you don't like node or you do run Windaz, might be best to create your own equally opinionated version.

## Future possibilities:

  * automate creating an app shell using jrburkes responsive-template or longster's mason?