# Package: Less

**Version:** 692
**Chapter:** 8.43 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Less package provides a highly capable terminal pager used to view the contents of text files. Unlike simpler pagers (like `more`), `less` allows for both forward and backward navigation, robust string searching, and jumping to specific marks without needing to load the entire file into memory before starting.

Key binaries included:
* `less` (The core file viewer)
* `lessecho` (Utility utilized by the pager to properly expand meta-characters like `*` and `?` in filenames)
* `lesskey` (Utility to parse and configure custom key bindings)

## Security / Custom Modifications
- **FHS Compliance:** Configured with `--prefix=/usr` to ensure the binaries are placed directly into the standard system execution path.
- **Centralized Configuration Enforcement:** Explicitly passed `--sysconfdir=/etc` during configuration. This parameter forces the package to look for its global configuration and system-wide key bindings strictly within the `/etc` directory, adhering to the Linux standard for isolating configuration data from binary directories.

## Build Notes
- **Required Disk Space:** 17 MB
- **Process:** Compiled cleanly in-tree using the specified configuration.
- **Test Suite:** Executed `make check` to verify the mathematical and logical integrity of the text parsing and pagination algorithms within the chroot environment.
- **Installation:** Standard `make install` execution.
