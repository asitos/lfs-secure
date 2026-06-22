# Package: Sed

**Version:** 4.9
**Chapter:** 8.32 (System Software)
**SBU Estimate:** 0.3 SBU

## Overview
The Sed (Stream Editor) package is an absolutely essential command-line utility used for parsing and transforming text. As you have seen throughout the LFS build process, it is heavily relied upon by build scripts and makefiles to automatically search, replace, and patch source code on the fly.

## Security / Custom Modifications
- **Unprivileged Testing:** Just like the GCC build, the test suite for Sed is executed using the dedicated, unprivileged `tester` account. This ensures that the test suite cannot accidentally modify or corrupt the root filesystem during execution.
- **Path Enforcement:** Configured with `--prefix=/usr` to ensure the binary and base components are installed strictly within the FHS standard tree.
- **Manual Documentation Staging:** Explicitly compiled the HTML documentation alongside the binaries (`make html`), manually created the destination directory with strict `755` permissions, and securely staged the HTML files into `/usr/share/doc/sed-4.9` with `644` permissions.

## Build Notes
- **Required Disk Space:** 30 MB
- **Process:** Utilized the highly standard C compilation pipeline, with an added step for HTML manual generation.
- **Test Suite:** Executed natively using `make check` via the `tester` user.
