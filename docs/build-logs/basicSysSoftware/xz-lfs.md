# Package: Xz

**Version:** 5.8.2
**Chapter:** 8.8 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Xz package provides modern, high-ratio compression and decompression utilities. It supports both the older `lzma` and the newer `xz` compression formats. For text files and source code archives, `xz` yields significantly better compression percentages than traditional tools like `gzip` or `bzip2`.

## Security / Custom Modifications
- **Static Linking Prevention:** Passed `--disable-static` during configuration. This explicitly prevents the compilation of static archives (`.a` files), enforcing modern dynamic linking (`.so` shared objects) across the system to save disk space and improve memory efficiency.
- **Path Enforcement:** Configured with `--prefix=/usr` to place binaries and libraries into the standard system hierarchy.
- **Documentation Routing:** Utilized `--docdir=/usr/share/doc/xz-5.8.2` to ensure the package's documentation is cleanly routed to a version-specific folder within the FHS-compliant `/usr/share` directory, rather than cluttering the root documentation path.

## Build Notes
- **Required Disk Space:** 24 MB
- **Process:** Utilized the standard C build sequence (`configure`, `make`, `make install`).
- **Test Suite:** Executed the native `make check` suite prior to installation to verify that the compression routines compiled accurately against the new Glibc environment.
