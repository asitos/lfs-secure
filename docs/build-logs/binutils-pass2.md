# Package: Binutils (Pass 2 - Target Linker)

**Version:** 2.46.0
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.4 SBU

## Overview
Binutils Pass 2 compiles the native linker, assembler, and object manipulation tools. Unlike Pass 1 (which built host-native cross-tools), this pass utilizes the isolated cross-compiler to build the exact utilities that will orchestrate code linking natively inside the future chroot environment.

## Security / Custom Modifications
- **Host Contamination Prevention:** Applied a strict `sed` patch to `ltmain.sh` to fix an inconsistency where shipped `libiberty` and `zlib` libraries might force `libtool` to mistakenly link against the host distribution.
- **Target Sysroot Mapping:** Configured explicitly with `--host=$LFS_TGT` and installed via `make DESTDIR=$LFS install`.
- **Library Validation:** Built `libbfd` as a shared library (`--enable-shared`).
- **Archive Scrubbing:** Explicitly deleted generated static (`.a`) and libtool archive (`.la`) files from `$LFS/usr/lib`. This ensures future packages strictly use dynamic linking and do not inadvertently resolve hardcoded paths back to the host system.

## Build Notes
- Extracted, configured (in a dedicated `build` subdirectory), and compiled cleanly.
- Source tree successfully destroyed post-installation.
