# Package: MPFR

**Version:** 4.2.2
**Chapter:** 8.23 (System Software)
**SBU Estimate:** 0.2 SBU

## Overview
The MPFR (Multiple Precision Floating-Point Reliable) package provides a C library for multiple-precision floating-point computations with correct rounding. It builds directly upon the GMP library you just installed and is a strict prerequisite for building the final GCC compiler.

## Security / Custom Modifications
- **Thread Safety:** Passed `--enable-thread-safe` during configuration. This is crucial for modern multi-core systems, ensuring the math library can be safely accessed by multiple threads simultaneously without race conditions or memory corruption.
- **Static Linking Prevention:** Enforced dynamic shared object (`.so`) generation exclusively by passing `--disable-static`.
- **Documentation Routing:** Directed all generated documentation (including manually built HTML files) to the FHS-compliant `/usr/share/doc/mpfr-4.2.2` directory.

## Build Notes
- **Required Disk Space:** 43 MB
- **Process:** Utilized the standard C compilation pipeline but explicitly added a step to generate the HTML documentation alongside the binaries.
- **Test Suite (CRITICAL):** The test suite is considered strictly necessary to verify the complex floating-point mathematical logic. The output was audited to ensure exactly 198 tests passed without failure.
