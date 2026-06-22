# Package: Diffutils

**Version:** 3.12
**Chapter:** 8.62 (System Software)
**SBU Estimate:** 0.5 SBU

## Overview
The Diffutils package contains essential programs for comparing files and directories. These tools are a cornerstone of Unix-like environments, heavily relied upon by developers and build scripts to identify source code changes, generate patch files, and merge file conflicts.

Key binaries included:
* `diff` (Compares files or directories line by line to report differences)
* `cmp` (Compares two files byte by byte, useful for binary files)
* `diff3` (Compares three files simultaneously)
* `sdiff` (Merges two files side-by-side interactively)

## Security / Custom Modifications
- **System-Wide FHS Compliance:** Configured entirely with standard parameters (`--prefix=/usr`). Because these are fundamental system tools, ensuring they are mapped directly to the root execution path is critical for the proper functioning of subsequent build scripts that hardcode standard POSIX utility locations. 

## Build Notes
- **Required Disk Space:** 51 MB
- **Process:** Compiled cleanly in-tree using standard GNU Autotools configurations.
- **Test Suite:** Executed `make check` to strictly verify the logical parsing and comparison algorithms within the chroot environment, ensuring accurate byte and text boundary detection.
- **Installation:** Standard `make install` execution.
