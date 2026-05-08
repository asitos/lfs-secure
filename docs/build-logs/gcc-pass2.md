# Package: GCC (Pass 2 - Target Compiler)

**Version:** 15.2.0
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 4.5 SBU

## Overview
This phase builds the actual C and C++ compiler that will reside natively inside the LFS system. It is cross-compiled using the host-to-target compiler from Pass 1, but is configured to execute strictly on the target architecture (`--host=$LFS_TGT` and `--target=$LFS_TGT`).

## Security / Custom Modifications
- **Embedded Math Libraries:** GMP, MPFR, and MPC were extracted directly into the GCC source tree to ensure isolated, FHS-compliant compilation without relying on host-installed math libraries.
- **Library Path Standardization:** Patched `gcc/config/i386/t-linux64` to force 64-bit libraries into `lib` rather than `lib64`, maintaining a clean and standardized filesystem hierarchy.
- **POSIX Thread Support:** Forced the libgcc and libstdc++ headers to utilize POSIX threads (`gthr-posix.h`) natively.
- **Sysroot Enclosure:** Configured with `--with-build-sysroot=$LFS` to physically prevent GCC's internal build tools from attempting to read headers or libraries from the Arch Linux host.
- **C++ Exception Handling Fix:** Passed `LDFLAGS_FOR_TARGET=-L$PWD/$LFS_TGT/libgcc` to force `libstdc++` to link against the newly compiled `libgcc` in this pass, rather than the Pass 1 version (which lacked libc support and would break C++ exceptions).
- **POSIX Compliance:** Created a symlink from `gcc` to `cc` in `$LFS/usr/bin` to satisfy generic UNIX build scripts.

## Build Notes
- Extracted, patched, configured (in an isolated `build` directory), and compiled cleanly.
- Source tree successfully destroyed post-installation.
