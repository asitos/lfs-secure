# Package: Libpipeline

**Version:** 1.5.8
**Chapter:** 8.70 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Libpipeline package provides a C library for safely and flexibly constructing and manipulating pipelines of subprocesses. It is primarily utilized by man-db (the upcoming manual page viewer package) to securely pipe unformatted manual pages through formatting engines like `groff` before displaying them on the terminal.

Key libraries included:
* `libpipeline.so` (The core shared library used for subprocess pipeline management)

## Security / Custom Modifications
- **System-Wide FHS Compliance:** Configured with `--prefix=/usr` to ensure the shared library is installed into the standard system library path, making it readily available for downstream dependencies.

## Build Notes
- **Required Disk Space:** 10 MB
- **Process:** Compiled cleanly in-tree using standard GNU Autotools configurations (`./configure` & `make`).
- **Test Suite:** Explicitly skipped. The upstream test suite relies on the `Check` unit testing framework, which has been intentionally removed from the core LFS specification to minimize unnecessary bloat.
- **Installation:** Standard `make install` execution.
