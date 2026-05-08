# Package: Gawk (Temporary Native Tool)

**Version:** 5.3.2
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.1 SBU

## Overview
Gawk (GNU Awk) is a powerful text pattern scanning and processing language. It is a fundamental dependency for many autoconf-generated `configure` scripts and Makefiles that perform complex string manipulations during the build process.

## Security / Custom Modifications
- **Build Optimization:** Applied a `sed` patch (`sed -i 's/extras//' Makefile.in`) prior to configuration to explicitly prevent the compilation of unneeded "extras". This keeps the target sysroot lean and strictly limited to essential tools.
- **Target Sysroot Mapping:** Configured with `--host=$LFS_TGT` and installed via `make DESTDIR=$LFS install` to guarantee isolated cross-compilation.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation to maintain cleanroom integrity.
