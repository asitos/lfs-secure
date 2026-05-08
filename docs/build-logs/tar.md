# Package: Tar (Temporary Native Tool)

**Version:** 1.35
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.1 SBU

## Overview
The Tar utility provides the fundamental ability to create and extract archive files. This cross-compiled version is strictly required in the target sysroot so the system can extract future source code tarballs natively without relying on the host operating system's tools.

## Security / Custom Modifications
- **Target Sysroot Mapping:** Configured explicitly with `--host=$LFS_TGT` to utilize the isolated cross-toolchain.
- **Cleanroom Installation:** Installed via `make DESTDIR=$LFS install` to map the binary directly into the target's `/usr/bin` directory, safely isolating it from the Arch Linux host.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
