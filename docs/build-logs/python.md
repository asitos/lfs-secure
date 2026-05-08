# Package: Python (Temporary Tools)

**Version:** 3.14.3
**Chapter:** 7.10
**SBU Estimate:** 0.5 SBU

## Overview
Python 3 is a mandatory interpreter for modern Linux build systems. In this temporary phase, a minimal Python environment is compiled to satisfy the build dependencies of upcoming core packages, such as Meson and Glibc.

## Architectural Highlights
- **Minimal Footprint:** Configured with `--without-ensurepip` to avoid installing the Python package manager, which is unnecessary for temporary build orchestration.
- **Dynamic Linking Priority:** Utilized `--enable-shared` and `--without-static-libpython` to forcefully prevent the compilation and installation of massive, unneeded static libraries (`libpython.a`), saving substantial space in the chroot environment.
- **Expected Warnings:** Ignored warnings regarding missing optional modules (like `ssl`) during the `make` phase, as those dependencies (OpenSSL) have not yet been built in the temporary sysroot.

## Build Notes
- Extracted, configured, and compiled natively inside the chroot.
- Source tree successfully destroyed post-installation.
