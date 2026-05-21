# Package: GMP

**Version:** 6.3.0
**Chapter:** 8.22 (System Software)
**SBU Estimate:** 0.3 SBU

## Overview
The GMP (GNU Multiple Precision) package provides highly optimized math libraries for arbitrary precision arithmetic. It operates on signed integers, rational numbers, and floating-point numbers without practical limits on precision, making it a critical dependency for cryptography and complex compilation tasks (such as building GCC itself).

## Security / Custom Modifications
- **Compiler Compatibility Fix:** Applied an inline `sed` patch to the `configure` script to fix legacy function declarations (`()` to `(...)`), ensuring compatibility with GCC 15 and newer.
- **Language Support Expansion:** Enabled C++ support by passing `--enable-cxx` to ensure future packages can link against GMP's C++ bindings.
- **Static Linking Prevention:** Enforced the exclusive use of dynamic shared objects by passing `--disable-static`.
- **Documentation Routing:** Directed all documentation (including manually generated HTML files) to the FHS-compliant `/usr/share/doc/gmp-6.3.0` directory.
- **Host Optimization Awareness:** *Note:* By default, GMP highly optimizes itself for the specific CPU compiling it. If the CPU detection is flawed, it may result in `Illegal instruction` errors later. (If this happens, a rebuild with `--host=none-linux-gnu` is required).

## Build Notes
- **Required Disk Space:** 54 MB
- **Process:** Utilized the standard C compilation pipeline but explicitly added a step to generate the HTML documentation alongside the binaries.
- **Test Suite (CRITICAL):** The test suite is considered strictly necessary to verify the highly optimized mathematical logic. The output was logged, and an `awk` script was used to mathematically guarantee that at least 199 distinct tests passed successfully.
