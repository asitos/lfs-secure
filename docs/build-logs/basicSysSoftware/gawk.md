# Package: Gawk

**Version:** 5.3.2
**Chapter:** 8.63 (System Software)
**SBU Estimate:** 0.2 SBU

## Overview
The Gawk package provides the GNU implementation of `awk`, a highly capable programming language fundamentally designed for text processing and data extraction. It is heavily utilized within shell scripts to perform complex pattern scanning, column extraction, and text manipulation tasks that exceed the capabilities of simpler tools like `sed` or `cut`.

Key binaries included:
* `gawk` (The core GNU awk interpreter)
* `awk` (Standard POSIX symlink pointing to `gawk`)
* `gawk-5.3.2` (Hard link preserving the specific version)

## Security / Custom Modifications
- **Build Cleanliness:** Applied a `sed` patch (`sed -i 's/extras//' Makefile.in`) prior to configuration. This explicitly intercepts the Make process to prevent the installation of unnecessary supplementary files, minimizing the system footprint.
- **Symlink & Hardlink Management:** Manually removed the pre-existing `gawk-5.3.2` binary from `/usr/bin/` before installation. This forces the build system to overwrite the older, temporary hardlink created during the cross-compilation phase (Chapter 6), guaranteeing the final system links to the newly compiled, native binary. Post-installation, a symlink for the `awk` manual page was explicitly created to ensure standard POSIX command documentation resolves correctly.

## Build Notes
- **Required Disk Space:** 45 MB
- **Process:** Configured and compiled cleanly in-tree.
- **Test Suite:** The test suite required execution as a non-root user. The source tree permissions were recursively modified (`chown -R tester .`), and the tests were executed within the `tester` user context (`su tester -c "PATH=$PATH make check"`) to ensure rigorous validation of the text parsing algorithms without elevated privileges.
- **Installation:** Managed `make install`, followed by manual linkage of the `awk` man page and the structured deployment of the supplementary documentation.
