# Package: Zstd

**Version:** 1.5.7
**Chapter:** 8.10 (System Software)
**SBU Estimate:** 0.4 SBU

## Overview
Zstandard (Zstd) is a real-time compression algorithm that provides highly efficient compression ratios. It offers a flexible range of compression-to-speed trade-offs while maintaining an exceptionally fast decoder, making it an essential, modern replacement for older compression libraries.

## Security / Custom Modifications
- **Path Enforcement:** Passed `prefix=/usr` explicitly to the `make` command to ensure the binaries and libraries target the correct FHS-compliant system hierarchy instead of defaulting to `/usr/local`.
- **Static Library Scrubbing:** Manually deleted the static archive (`/usr/lib/libzstd.a`) after installation. This prevents future packages from statically linking Zstandard code into their binaries, forcing reliance on the dynamic shared object (`.so`) for better memory efficiency and security patching.

## Build Notes
- **Required Disk Space:** 86 MB
- **Process:** Compiled directly using the native Makefile without a separate `configure` step.
- **Test Suite:** Executed the native `make check` suite. 
  - *Note on output:* The test suite logs naturally output the word "failed" in several places as part of routine internal checks. These are expected and harmless; only a capitalized "FAIL" indicates a genuine test failure.
