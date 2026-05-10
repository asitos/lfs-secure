# Package: Lz4

**Version:** 1.10.0
**Chapter:** 8.9 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
Lz4 is an extremely fast, lossless compression algorithm. It is designed for incredibly high-speed compression and decompression operations (capable of multi-GB/s speeds per core) and is often paired with other algorithms like Zstandard for optimized data throughput.

## Security / Custom Modifications
- **Static Linking Prevention:** Passed `BUILD_STATIC=no` directly to the `make` command. This explicitly prevents the creation of static `.a` libraries, ensuring the system relies entirely on dynamic shared objects (`.so`) for better memory footprint and easier security updates across the OS.
- **Path Enforcement:** Forced the installation hierarchy by passing `PREFIX=/usr` to `make`, as this package does not use a traditional `configure` script to set directory targets.

## Build Notes
- **Required Disk Space:** 4.2 MB
- **Process:** Built strictly using Makefile variables (`make BUILD_STATIC=no PREFIX=/usr`).
- **Test Suite:** Executed `make -j1 check`. The `-j1` flag was critical here to force the test suite to run as a single, sequential job, which prevents race conditions and ensures accurate validation of the compression routines before installation.
