# Package: Libcap

**Version:** 2.77
**Chapter:** 8.27 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Libcap package implements the userspace interface to the POSIX 1003.1e capabilities available in modern Linux kernels. Instead of relying on a binary "all-or-nothing" root privilege system, Linux capabilities allow administrators and developers to partition root access into a set of distinct, granular privileges (e.g., allowing a program to bind to a low network port without granting it full root access).

## Security / Custom Modifications
- **Static Library Scrubbing (Pre-compile):** Used `sed` to patch `libcap/Makefile` prior to compilation, explicitly removing the installation instructions for static archives (`.a` files) to enforce strict dynamic linking across the system.
- **Architecture Path Enforcement:** Passed `lib=lib` to the `make` command. On x86_64 systems, this explicitly overrides the default behavior of installing into `/usr/lib64`, forcing the libraries into the standard FHS-compliant `/usr/lib` directory to maintain our clean, flattened hierarchy.
- **Go Compiler Exclusion:** *(Note for future updates)* If updating this package on a live system where the `go` compiler is installed, you must pass `export GOLANG=no` to the environment to prevent build errors.

## Build Notes
- **Required Disk Space:** 3.1 MB
- **Process:** Built strictly using Makefile variables, bypassing the traditional `configure` script.
- **Test Suite:** Executed the native `make test` suite prior to installation to verify that the capability partitioning logic interfaced correctly with the kernel.
