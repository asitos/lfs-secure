# Package: Pkgconf

**Version:** 2.5.1
**Chapter:** 8.20 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Pkgconf package provides a crucial build tool that acts as a modern, drop-in replacement for the traditional `pkg-config`. During the `configure` and `make` phases of compiling software, this tool automatically passes the correct include paths and library linkage flags to the compiler, ensuring dependencies are successfully resolved.

## Security / Custom Modifications
- **Static Linking Prevention:** Passed `--disable-static` to strictly prevent the creation of static archive libraries, enforcing the modern standard of dynamic shared object (`.so`) utilization across the OS.
- **Path Enforcement:** Configured with `--prefix=/usr` and a version-specific `--docdir=/usr/share/doc/pkgconf-2.5.1` to ensure strict FHS compliance for the binary and its documentation.
- **Legacy Compatibility (Pkg-config mapping):** Because the vast majority of open-source software still explicitly calls the older `pkg-config` command in their build scripts, manual symlinks were established for both the binary (`/usr/bin/pkg-config` -> `pkgconf`) and its man page (`pkg-config.1` -> `pkgconf.1`).

## Build Notes
- **Required Disk Space:** 5.0 MB
- **Process:** Utilized a very standard C compilation pipeline (`configure`, `make`, `make install`).
- **Test Suite:** This package does not include a test suite in this phase of the LFS build.
