# Package: GCC

**Version:** 15.2.0
**Chapter:** 8.30 (System Software)
**SBU Estimate:** 45 SBU (with tests)

## Overview
The GNU Compiler Collection (GCC) is the absolute core of the Linux From Scratch build. This package contains the C and C++ compilers that will compile every remaining piece of software on the system. Successfully building and verifying this package signifies that the native toolchain is fully operational and independent of the host distribution.

## Security / Custom Modifications
- **PIE and SSP Enforcement:** Configured with `--enable-default-pie` and `--enable-default-ssp`. This natively bakes Position-Independent Executable (PIE) generation and Stack Smashing Protection (SSP) into the compiler's default behavior, ensuring all future compiled software benefits from Address Space Layout Randomization (ASLR) and buffer overflow mitigations.
- **Glibc 2.43 Compatibility Fix:** Applied an inline `sed` patch to `libgomp/affinity-fmt.c` to resolve a known pointer incompatibility with newer Glibc versions.
- **64-bit Architecture Normalization:** Modified `gcc/config/i386/t-linux64` to force 64-bit libraries into the standard `/usr/lib` directory instead of `/usr/lib64`, maintaining a clean, flattened FHS hierarchy.
- **Libcody C++20 Standards Patch:** Manually scrubbed `u8` prefixes from `libcody` source files using `sed` to prevent a fatal C++ standard clash regarding the newly isolated `char8_t` type during compilation.
- **Out-of-Tree Build:** Compiled strictly within a dedicated `build` directory to prevent source tree contamination during the massive compilation process.
- **Bootstrap Disablement:** Configured with `--disable-bootstrap` to bypass the 3-stage compiler self-rebuild. Because we constructed a pristine temporary toolchain in earlier chapters, the time-consuming bootstrap phase is unnecessary here.

## Build Notes
- **Required Disk Space:** 6.6 GB
- **Process:** Heavy pre-compilation patching followed by a massive, resource-intensive C/C++ compilation. 
- **Test Suite (CRITICAL):** The test suite was executed utilizing a dedicated, unprivileged `tester` account to prevent environment contamination. Stack limits were explicitly set to `unlimited` to prevent complex tests from crashing the compiler via stack exhaustion. *Note: A handful of failures in `pr90579.c`, `strchr-1.c`, and libstdc++ names tests are expected upstream.*
