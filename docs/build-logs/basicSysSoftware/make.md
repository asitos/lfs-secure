# Package: Make

**Version:** 4.4.1
**Chapter:** 8.71 (System Software)
**SBU Estimate:** 0.6 SBU

## Overview
The Make package provides the core GNU build automation tool. It automatically determines which pieces of a large program need to be recompiled by reading `Makefile`s, and issues the exact commands required to compile them. It is arguably the most critical compilation dependency in the entire Linux ecosystem, serving as the traditional backbone for building almost every package in Linux From Scratch.

Key binaries included:
* `make` (The build automation executable)

## Security / Custom Modifications
- **System-Wide FHS Compliance:** Configured entirely with standard parameters (`--prefix=/usr`) to ensure the binary is installed directly into the root execution path, a location universally hardcoded and expected by nearly every source code package in existence.

## Build Notes
- **Required Disk Space:** 13 MB
- **Process:** Compiled cleanly in-tree using standard GNU Autotools configurations.
- **Test Suite:** The test suite strictly requires execution as a non-root user. The source tree ownership was recursively shifted (`chown -R tester .`), and the extensive tests were executed within the unprivileged `tester` user context (`su tester -c "PATH=$PATH make check"`) to rigorously validate its parsing and command-execution logic without risking host-environment contamination.
- **Installation:** Standard `make install` execution.
