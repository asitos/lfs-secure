# Package: Man-pages

**Version:** 6.17
**Chapter:** 8.3 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Man-pages package contains over 2,400 man pages. These files provide the primary documentation for the system, describing C programming language functions, critical device files, and significant configuration files necessary for both users and developers.

## Security / Custom Modifications
- **Redundant Page Removal:** Executed `rm -v man3/crypt*` to remove specific man pages for password hashing functions. This is a deliberate step because `libxcrypt` provides more accurate and modern versions of these pages, preventing documentation conflicts.
- **Variable Environment Hardening:** Used the `-R` flag during installation to prevent `make` from setting any built-in variables. The man-pages building system is incompatible with these variables; passing this flag ensures the installation path remains predictable and clean.
- **Git Warning Suppression:** Passed `GIT=false` to the make command. This prevents the build system from attempting to execute git commands, which would otherwise flood the terminal with "command not found" warnings in the isolated LFS environment.

## Build Notes
- **Required Disk Space:** 54 MB
- Since this package consists of static documentation rather than source code requiring a compiler, the build is extremely fast, requiring only file system operations.
