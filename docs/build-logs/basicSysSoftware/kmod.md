# Package: Kmod

**Version:** 34.2
**Chapter:** 8.60 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Kmod package provides the core libraries and utilities required for loading, unloading, and managing Linux kernel modules. It replaces the older module-init-tools package. Notably, standard module management commands (such as `modprobe`, `lsmod`, `insmod`, `rmmod`, `depmod`, and `modinfo`) are not standalone binaries; they are simply symbolic links to the primary `kmod` executable, which changes its behavior based on how it is invoked.

Key components included:
* `kmod` (The monolithic kernel module management binary)
* `libkmod.so` (The shared library utilized by other programs, like systemd, to interface with kernel modules)

## Security / Custom Modifications
- **Modern Build System Integration:** This package marks the operational deployment of the `meson` and `ninja` build tools compiled in the previous steps, moving away from standard GNU Autotools (`./configure` & `make`).
- **Out-of-Tree Compilation:** Built within an isolated `build` directory to keep the source tree clean, a standard best practice for Meson-based projects.
- **Dependency Minimization:** Explicitly passed `-D manpages=false`. This deliberately disables the generation of manual pages, successfully preventing the build system from attempting to invoke external XML parsing programs (like `xsltproc`) which are not provisioned within the strictly controlled LFS chroot environment.
- **System-Wide FHS Compliance:** Configured with `--prefix=/usr` to ensure all resulting module-management binaries and libraries are mapped correctly into the root execution path.

## Build Notes
- **Required Disk Space:** 6.7 MB
- **Process:** Configured using `meson setup` and compiled natively via the `ninja` backend utilizing the `release` build type for execution optimization.
- **Test Suite:** Explicitly skipped. The Kmod test suite requires *raw* kernel source headers to function. Because LFS deliberately utilizes *sanitized* kernel headers (provisioned earlier to guarantee a stable userspace API), the test suite cannot execute properly within this scope.
- **Installation:** Standard `ninja install` execution.
