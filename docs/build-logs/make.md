# Package: Make (Temporary Native Tool)

**Version:** 4.4.1
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** < 0.1 SBU

## Overview
GNU Make is the core automation tool that controls the compilation of executables from source code. This cross-compiled version is strictly required in the target sysroot to drive all future source builds once we enter the `chroot` environment.

## Security / Custom Modifications
- **Target Sysroot Mapping:** Configured explicitly with `--host=$LFS_TGT` to utilize the isolated cross-toolchain.
- **Cleanroom Installation:** Installed via `make DESTDIR=$LFS install` to map the binary directly into the target's `/usr/bin` directory, avoiding any overlap with the Arch host's build system.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
