# Package: DejaGNU

**Version:** 1.6.3
**Chapter:** 8.19 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The DejaGNU package provides a comprehensive framework for testing other GNU tools. It acts as the final piece of the testing triad (alongside Tcl and Expect), allowing critical system components like `gcc` and `binutils` to run their massive test suites reliably.

## Security / Custom Modifications
- **Out-of-Tree Build:** Compiled strictly within a dedicated `build` directory, as recommended by upstream developers to prevent source tree contamination.
- **Path Enforcement:** Configured with `--prefix=/usr` to ensure the testing framework integrates into standard FHS paths.
- **Manual Documentation Compilation:** Leveraged `makeinfo` to manually compile the `.texi` source documentation into both single-page HTML and plaintext formats prior to installation.
- **Documentation Routing:** Manually staged the FHS-compliant documentation directory (`/usr/share/doc/dejagnu-1.6.3`) and installed the newly compiled HTML and plaintext files with strict, secure permissions (`755` for directories, `644` for files).

## Build Notes
- **Required Disk Space:** 6.9 MB
- **Process:** Configured and built out-of-tree. Notice there is no `make` command required to build the core software—only the configuration, documentation generation, and installation phases are needed.
- **Test Suite:** Executed the native `make check` suite prior to installation to verify the framework could correctly parse and execute GNU testing logic using the system's Tcl/Expect stack.
