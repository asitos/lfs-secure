# Package: Attr

**Version:** 2.5.2
**Chapter:** 8.25 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Attr package contains essential utilities for administering extended attributes on filesystem objects. Extended attributes allow the system to associate additional metadata (beyond standard file permissions) with files and directories, which is heavily used by security modules (like SELinux or AppArmor) and Access Control Lists (ACLs).

## Security / Custom Modifications
- **Static Linking Prevention:** Passed `--disable-static` to the configure script to prevent the compilation of static archives, enforcing the modern standard of using dynamic shared objects (`.so`) across the system.
- **Path & Configuration Enforcement:** Configured with `--prefix=/usr` and `--sysconfdir=/etc` to ensure binaries and system configuration files land in their strict FHS-compliant directories.
- **Documentation Routing:** Directed version-specific documentation to the proper `/usr/share/doc/attr-2.5.2` directory.

## Build Notes
- **Required Disk Space:** 4.1 MB
- **Process:** Utilized the highly standard C compilation pipeline (`configure`, `make`, `make install`).
- **Test Suite:** Executed the native `make check` suite prior to installation. 
  - *Note:* The test suite strictly requires the host filesystem to support extended attributes (e.g., ext2, ext3, ext4, or btrfs). If the build environment's filesystem lacks this support, the tests will fail.
