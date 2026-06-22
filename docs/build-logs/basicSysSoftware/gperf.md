# Package: Gperf

**Version:** 3.3
**Chapter:** 8.40 (System Software)
**SBU Estimate:** 0.2 SBU

## Overview
The Gperf package contains a specialized utility that generates perfect, highly efficient C/C++ hash functions from a user-defined set of keys. It is heavily utilized by compilers, parsers, and other system tools to guarantee exact-match string lookups without any hash collisions, significantly optimizing performance during string recognition phases.

Key binaries included:
* `gperf` (The core perfect hash function generator)

## Security / Custom Modifications
- **FHS Documentation Isolation:** Explicitly configured with `--docdir=/usr/share/doc/gperf-3.3` to cleanly sandbox the package's documentation by version. This prevents namespace collisions with future updates and ensures strict adherence to the Filesystem Hierarchy Standard.
- **System-Wide FHS Compliance:** Applied the standard `--prefix=/usr` to ensure the binary is installed directly into the root filesystem's main execution path.

## Build Notes
- **Required Disk Space:** 12 MB
- **Process:** Compiled cleanly in-tree using standard configurations.
- **Test Suite:** Executed `make check` to mathematically verify the integrity of the hash generation algorithms within the isolated chroot environment.
- **Installation:** Standard `make install` execution.
