# Package: Ncurses

**Version:** 6.6
**Chapter:** 8.31 (System Software)
**SBU Estimate:** 0.2 SBU

## Overview
The Ncurses package provides essential libraries for terminal-independent handling of character screens. It is responsible for creating the text-based user interfaces and colored output used by tools like `nano`, `make menuconfig` (for the kernel), and various system installers. 

## Security / Custom Modifications
- **Shared Object Enforcement:** Configured with `--with-shared` and `--with-cxx-shared`, while explicitly passing `--without-normal` and `--without-debug`. This strictly enforces the creation of dynamic shared libraries (for both C and C++) and prevents the installation of outdated static or bloated debug libraries.
- **Pkg-config Integration:** Passed `--enable-pc-files` and explicitly mapped the directory to `/usr/lib/pkgconfig` so modern build systems can easily discover Ncurses via `pkgconf`.
- **Live-System Crash Prevention (DESTDIR Strategy):** Because the current bash shell actively relies on the `libncursesw.so` library to function, overwriting it in-place during `make install` can cause the active shell to crash. To safely bypass this, the software was temporarily staged in a local `DESTDIR` and safely injected into the root filesystem using `cp --remove-destination`.
- **Wide-Character ABI Enforcement:** Modified the staged `curses.h` header file using `sed` to aggressively force the use of the wide-character (UTF-8 compatible) ABI across the system.
- **Legacy Compatibility Symlinks:** Many older applications hardcode lookups for non-wide libraries (e.g., `-lncurses` instead of `-lncursesw`) or the archaic `-lcurses` flag. A `for` loop was utilized to create safe symlinks mapping all legacy calls to the modern, wide-character `.so` and `.pc` files.

## Build Notes
- **Required Disk Space:** 47 MB
- **Process:** Configured, built normally, and staged locally before final system injection. 
- **Test Suite:** The Ncurses test suite can only be run *after* the package is installed (located in the `test/` directory of the source). It is not part of the standard LFS build flow and is safely skipped here.
- **Legacy Version 5 ABI Note:** If you plan to run proprietary, closed-source binaries that explicitly require LSB compliance (version 5 ABI), you will need to perform a supplementary `distclean` and rebuild specifically for those `.so.5` libraries. This is not needed for a standard, from-source Linux system.
