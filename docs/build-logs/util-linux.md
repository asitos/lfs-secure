# Package: Util-linux (Temporary Tools)

**Version:** 2.41.3
**Chapter:** 7.12
**SBU Estimate:** 0.2 SBU

## Overview
Util-linux provides fundamental system utilities for mounting filesystems, partitioning disks, and managing the hardware clock. This temporary compilation provides core system administration tools required for the final system build.

## Architectural Highlights
- **FHS Compliance:** Created `/var/lib/hwclock` and explicitly routed the `adjtime` file to this location to ensure standard compliance and prevent rogue file creation.
- **Dependency Mitigation:** Aggressively disabled components requiring external libraries not yet present in the chroot (e.g., `login`, `su`, `chsh`). These will be fully compiled in Chapter 8 using the `shadow` package.
- **Dynamic Optimization:** Disabled static libraries (`--disable-static`) to preserve sysroot space.

## Build Notes
- Extracted, configured, and compiled natively inside the chroot.
- Source tree successfully destroyed post-installation.
