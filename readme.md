[gbsim][1] Windows port
=====================

Building
--------

 - Follow the [MinGW getting started instructions][2], especially the `fstab` bit.  Under "Basic Setup", install mingw-developer-tools, mingw32-base, mingw32-g++, msys-base
 - Run `c:\mingw\msys\1.0\msys.bat`
 - Go to where you cloned gbsim
 - Run `make`
 - Wait and pray

The binary should be in `gbsim/gbsim/obj-mingw32/main.elf`.  Rename it to something more sensible.  Consider `strip`ping or [UPX][3]ing it - the binary is rather big.


  [1]: https://github.com/33d/gbsim
  [2]: http://mingw.org/wiki/Getting_Started
  [3]: http://upx.sourceforge.net/