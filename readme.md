[gbsim][5] Windows port
===

**This is DEPRECATED** - use [the original repository][5] instead.

Building
---

1. Install [msys2][1] (I used 64 bit)
1. Run `update-core` and `pacman -Suu`, as described in [the instructions][2] 
1. Install these packages (`pacman -S ...`): 
  - mingw-w64-i686-toolchain 
  - git 
  - make
1. Update the path for mingw: `export PATH=$PATH:/mingw32/bin`
1. `make`
1. The binary is in `gbsim/gbsim/obj-i686-w64-mingw32/main.elf` -  it's actually an executable, so rename it to `.exe`.  

        $ file gbsim/gbsim/obj-i686-w64-mingw32/main.elf
        gbsim/gbsim/obj-i686-w64-mingw32/main.elf: PE32 executable (console) Intel 80386, for MS Windows

Before distributing the file, run `ldd` on it to confirm that it depends only on Windows files:

    $ ldd gbsim/gbsim/obj-i686-w64-mingw32/main.elf
        ntdll.dll => /c/WINDOWS/SYSTEM32/ntdll.dll (0x771b0000)
        KERNEL32.DLL => /c/WINDOWS/SYSTEM32/KERNEL32.DLL (0x76310000)
        KERNELBASE.dll => /c/WINDOWS/SYSTEM32/KERNELBASE.dll (0x76190000)
        GDI32.dll => /c/WINDOWS/SYSTEM32/GDI32.dll (0x74290000)
        USER32.dll => /c/WINDOWS/SYSTEM32/USER32.dll (0x76f00000)

The executable size can be reduced with `strip` and [UPX][6].

Notes
---

simavr does some magic with avrlibc - it uses its headers to get the definitions for each chip.  We only care about one, so it would be easier to copy this manually, then avrlibc wouldn't be necessary.

msys2 [comes with SDL][3] and [libelf][4], so we don't need those either.  That means with the avrlibc dependency removed, the [upstream code][5] could be built without this special Windows package.

[1]: http://msys2.github.io/
[2]: https://sourceforge.net/p/msys2/wiki/MSYS2%20installation/
[3]: https://github.com/Alexpux/MINGW-packages/tree/master/mingw-w64-SDL2
[4]: https://github.com/Alexpux/MINGW-packages/tree/master/mingw-w64-libelf
[5]: https://github.com/33d/gbsim
[6]: http://upx.sourceforge.net/

