# Package: Acl

**Version:** 2.3.2
**Chapter:** 8.26 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Acl package contains essential utilities for administering Access Control Lists (ACLs). ACLs are an extension to the traditional UNIX permission model, allowing administrators to define highly specific, fine-grained discretionary access rights for individual users or groups on files and directories.

## Security / Custom Modifications
- **Static Linking Prevention:** Passed `--disable-static` to the configure script to prevent the compilation of static archives, enforcing the modern standard of using dynamic shared objects (`.so`) across the system.
- **Path & Documentation Enforcement:** Configured with `--prefix=/usr` and `--docdir=/usr/share/doc/acl-2.3.2` to ensure the binaries and version-specific documentation land cleanly in their strict FHS-compliant directories.

## Build Notes
- **Required Disk Space:** 6.5 MB
- **Process:** Utilized the highly standard C compilation pipeline (`configure`, `make`, `make install`).
- **Test Suite:** Executed the native `make check` suite prior to installation. 
  - *Constraint 1:* The test suite strictly requires the host filesystem to have access controls enabled. 
  - *Constraint 2:* A single test (`test/cp.test`) is **known to fail** at this stage. This is completely expected because the core system `cp` utility (provided by Coreutils) has not yet been recompiled with ACL support. It is safe to ignore this specific failure.
