# Package: Grep (Temporary Native Tool)

**Version:** 3.12
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.1 SBU

## Overview
Grep is the standard Unix utility for searching plain-text data sets for lines matching a regular expression. It is a strict prerequisite for parsing configuration files and outputs during the LFS build process.

## Security / Custom Modifications
- **Target Sysroot Mapping:** Configured explicitly with `--host=$LFS_TGT` to utilize the cross-toolchain.
- **Cleanroom Installation:** Installed via `make DESTDIR=$LFS install` to correctly map the binary into the target's `/usr/bin` directory, avoiding any contamination of the host's `/usr` tree.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
