# Package: Libstdc++ (Target C++ Library)

**Version:** 15.2.0 (From GCC Source)
**Chapter:** 5 (Cross-Compiler Stage 1)
**SBU Estimate:** 0.4 SBU

## Overview
This builds the C++ Standard Library (`libstdc++`) for the target sysroot. This had to be deferred until after `glibc` was successfully compiled and mapped to the `$LFS` directory, resolving the circular dependency between the C and C++ standard libraries.

## Security / Custom Modifications
- **Isolated Target Binding:** Configured strictly with `--host=$LFS_TGT` to utilize the newly minted cross-compiler.
- **Header Path Enforcement:** Forced the C++ include directory to point to the isolated `/tools/$LFS_TGT/include/c++/15.2.0` to prevent the host compiler from attempting to resolve C++ headers from the Arch Linux host.
- **Libtool Scrubbing:** Manually deleted all generated `.la` (libtool archive) files from `$LFS/usr/lib`. This is a critical security step to prevent `libtool` from misdirecting future linker calls back to the host distribution.

## Build Notes
- Extracted a fresh GCC source tree. Internal math libraries (`gmp`, `mpfr`, `mpc`) were intentionally omitted as they are not required when configuring the `libstdc++-v3` subdirectory independently.
- Built and installed cleanly.
