# Package: Zlib

**Version:** 1.3.2
**Chapter:** 8.6 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Zlib package provides essential compression and decompression routines. It is a foundational library relied upon by a massive number of system programs, utilities, and future packages to handle compressed data streams efficiently.

## Security / Custom Modifications
- **Static Library Scrubbing:** Manually removed the static archive (`/usr/lib/libz.a`) after installation. On a modern LFS system utilizing dynamic shared objects (`.so`), static libraries are largely unnecessary bloat. Removing it forces future packages to link dynamically, ensuring they always use the system's updated compression routines rather than baking in old code.
- **Path Enforcement:** Configured purely with `--prefix=/usr` to deploy the headers and shared libraries directly into the standard system hierarchy.

## Build Notes
- **Required Disk Space:** 6.4 MB
- **Process:** Utilized the standard C compilation pipeline (`configure`, `make`, `make install`).
- **Test Suite:** Executed the native `make check` suite prior to installation to verify that the mathematical compression algorithms compiled correctly against the new `glibc` base.
