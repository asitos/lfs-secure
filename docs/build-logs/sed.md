# Package: Sed (Temporary Native Tool)

**Version:** 4.9
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.1 SBU

## Overview
Sed (Stream Editor) is a non-interactive text editor used to perform basic text transformations on an input stream. It is a critical dependency for the LFS build process, utilized extensively in automated scripts and Makefiles to apply rapid, inline source code patches.

## Security / Custom Modifications
- **Target Sysroot Mapping:** Configured explicitly with `--host=$LFS_TGT` to utilize the cross-toolchain.
- **Cleanroom Installation:** Installed via `make DESTDIR=$LFS install` to correctly map the binary into the target's `/usr/bin` directory, isolating it completely from the Arch Linux host environment.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
