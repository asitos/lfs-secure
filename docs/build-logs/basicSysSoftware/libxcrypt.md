# Package: Libxcrypt

**Version:** 4.5.2
**Chapter:** 8.28 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Libxcrypt package provides a modern, highly secure library for one-way hashing of passwords. It acts as a drop-in replacement for the traditional `libcrypt` provided by older versions of Glibc, handling password authentication across the Linux system.

## Security / Custom Modifications
- **Glibc 2.43+ Compatibility Fix:** Applied an inline `sed` patch to remove a `const` declaration in `lib/crypt-{sm3,gost}-yescrypt.c`, resolving a known build failure with newer versions of Glibc.
- **Cryptographic Hash Hardening:** Passed `--enable-hashes=strong,glibc` during configuration to enforce the compilation of strong, modern hash algorithms (like argon2), while keeping traditional Glibc hashes enabled strictly for backward compatibility.
- **Obsolete API Deprecation:** Configured with `--enable-obsolete-api=no` to entirely strip legacy, insecure API functions from the library. Since this is a modern, built-from-source system, no native packages will attempt to link against these outdated endpoints.
- **Failure Token Removal:** Disabled legacy failure tokens via `--disable-failure-tokens`, as these are only required for cross-platform compatibility on non-Glibc systems and pose unnecessary overhead here.
- **Static Linking Prevention:** Enforced the exclusive use of dynamic shared objects (`.so`) by passing `--disable-static`.

## Build Notes
- **Required Disk Space:** 14 MB
- **Process:** Required a `sed` patch prior to the standard C compilation pipeline (`configure`, `make`, `make install`).
- **Test Suite:** Executed the native `make check` suite prior to installation to verify the integrity of the cryptographic hashing algorithms.
- **Legacy ABI Note:** If you plan to run proprietary, pre-compiled binary applications on this system that explicitly require LSB compliance and ABI version 1, you would need to rebuild this package with `--enable-obsolete-api=glibc`. For standard from-source LFS, the configured deprecation is correct.
