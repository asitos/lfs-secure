# Package: Libtool

**Version:** 2.5.4
**Chapter:** 8.38 (System Software)
**SBU Estimate:** 0.6 SBU

## Overview
The Libtool package provides a generalized, portable interface that simplifies the complexity of building and using shared libraries across different Unix-like systems. It acts as a standardizing script wrapper around the host's native compiler and linker.

Key components included:
* `libtool` (The core library-building support script)
* `libtoolize` (Utility to add libtool support to a source package)
* `libltdl.so` (Dynamic library that abstracts the difficulties of opening dynamically loaded libraries)

## Security / Custom Modifications
- **FHS Compliance:** Configured explicitly with `--prefix=/usr` to ensure the scripts and headers are installed into the correct system-wide hierarchy.
- **Static Attack Surface Reduction:** Explicitly removed the static library archive post-installation (`rm -fv /usr/lib/libltdl.a`). This archive is only required during the test suite phase. Removing it enforces the system's dynamic-linking architecture, preventing dependent packages from accidentally linking statically against `libltdl`, which would complicate future security patching.

## Build Notes
- **Required Disk Space:** 44 MB
- **Process:** Compiled cleanly in-tree using standard configuration.
- **Test Suite:** Executed `make check` to verify library abstraction logic within the chroot environment.
- **Installation:** Standard `make install` execution, immediately followed by the manual cleanup of the static library archive.
