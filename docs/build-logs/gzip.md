# Package: Gzip (Temporary Native Tool)

**Version:** 1.14
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.1 SBU

## Overview
Gzip is the standard GNU compression utility. It is strictly required in the target sysroot for decompressing future source tarballs and compressing system documentation (like man pages) once inside the chroot environment.

## Security / Custom Modifications
- **Target Sysroot Mapping:** Configured explicitly with `--host=$LFS_TGT` to utilize the cross-toolchain.
- **Cleanroom Installation:** Installed via `make DESTDIR=$LFS install` to map the binaries directly into the target's `/usr/bin` directory, avoiding any overlap with the Arch host's compression tools.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
