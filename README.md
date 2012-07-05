# Gaia Rocking...

This repo is a shell you can use to set up a Gaia hacking environment.

## TL;DR

$ git clone git://github.com/canuckistani/gaia-rocking.git
$ cd ./gaia-rocking
$ git submodule init
$ make setup
$ 

## Current status notes

### Caveats: 
* OS X only ( so far, Linux should be easy, Windows likely painful )

### Works: 

* download and install B2G.app in ./bin
* updating Gaia as a git submodule
* running B2G desktop from a helper .app using AppleScript.

### TODO:

* adding your own apps as submodules
* some cool method of pushing custom apps(s) to the gaia profile's appcache (???)
* 

** DISCLAIMER **: this is opiniated and badly written software. Pull requests welcome, but if you don;t like node or you do run Windaz, might be best to create your own equally opinionated version.

## Future possibilities:

* automate creating an app shell using jrburkes responsive-template or longster's mason?