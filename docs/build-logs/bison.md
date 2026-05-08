# Package: Bison (Temporary Tools)

**Version:** 3.8.2
**Chapter:** 7.8
**SBU Estimate:** 0.2 SBU

## Overview
Bison is a parser generator (a GNU replacement for `yacc`). It is installed in the temporary toolchain to allow subsequent packages to dynamically generate C code for parsing complex configuration files and grammar specifications.

## Architectural Highlights
- **First Native Installation:** This marks a critical milestone in the build process. Unlike Chapter 6, which utilized `DESTDIR=$LFS` to map binaries into the sysroot, this package was installed directly via `make install` natively within the chroot environment. The `chroot` natively protects the host system.
- **Documentation Pathing:** Configured with `--docdir=/usr/share/doc/bison-3.8.2` to adhere strictly to the FHS and ensure versioned documentation isolation.

## Build Notes
- Extracted, configured, and compiled natively inside the chroot.
- Source tree successfully destroyed post-installation.
