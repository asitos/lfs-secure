# Package: MPC

**Version:** 1.3.1
**Chapter:** 8.24 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The MPC package contains a C library for the arithmetic of complex numbers with arbitrarily high precision and correct rounding. It operates on top of the GMP and MPFR libraries you just built. Together, these three mathematical libraries form the critical core dependencies required to build the GCC compiler suite.

## Security / Custom Modifications
- **Static Linking Prevention:** Enforced the exclusive use of dynamic shared object (`.so`) generation by passing `--disable-static` to the configuration script.
- **Path Enforcement & Documentation:** Configured with `--prefix=/usr` and `--docdir=/usr/share/doc/mpc-1.3.1` to ensure the binaries, shared libraries, and version-specific documentation land in strict FHS-compliant locations.

## Build Notes
- **Required Disk Space:** 22 MB
- **Process:** Utilized the standard C compilation pipeline, with explicit manual targets (`make html` and `make install-html`) to generate and stage the HTML-based documentation alongside the core software.
- **Test Suite:** Executed the native `make check` suite prior to installation to verify that the complex number arithmetic logic resolved correctly against the newly installed GMP and MPFR backends.
