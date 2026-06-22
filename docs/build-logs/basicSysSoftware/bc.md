# Package: Bc

**Version:** 7.0.3
**Chapter:** 8.15 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Bc package contains an arbitrary precision numeric processing language. While it functions as a powerful command-line calculator, it is technically a complete programming language used extensively in shell scripts and kernel compilation to handle complex floating-point math and logic.

## Security / Custom Modifications
- **Compiler Hardening:** Explicitly passed `CC='gcc -std=c99'` to force the compiler to adhere strictly to the C99 standard, ensuring maximum compatibility and preventing modern GCC defaults from throwing errors on older syntax.
- **Optimization:** Configured with `-O3` to instruct the compiler to apply the highest safe level of performance optimizations to the binary.
- **Readline Integration:** Passed the `-r` flag during configuration to explicitly link `bc` against the newly compiled `readline` library. This dramatically improves the user experience by enabling command-line history (up-arrow) and text-editing features within the interactive `bc` prompt.
- **Test Suite Scoping:** Passed the `-G` flag to strictly omit parts of the test suite that try to execute the system's `bc` command. Since `bc` isn't installed yet in our clean LFS chroot, this prevents false-positive test failures.

## Build Notes
- **Required Disk Space:** 7.8 MB
- **Process:** Utilized a custom configure string followed by the standard `make` and `make install`.
- **Test Suite:** Executed `make test` (note: not `make check` for this specific package) to validate the mathematical precision engine before installation.
