# Package: Findutils (Temporary Native Tool)

**Version:** 4.10.0
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.2 SBU

## Overview
Findutils provides essential directory tree searching utilities (`find`) and command-execution tools (`xargs`). These are critical for navigating the filesystem and automating bulk file operations inside the target sysroot.

## Security / Custom Modifications
- **Target Sysroot Mapping:** Configured with `--host=$LFS_TGT` and installed via `make DESTDIR=$LFS install` to prevent overriding the Arch host's utilities.
- **FHS Compliance:** Appended `--localstatedir=/var/lib/locate` to the configuration. This strict pathing ensures that the future database used by the `locate` command adheres to the Filesystem Hierarchy Standard, preventing clutter in the `/usr` tree.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
