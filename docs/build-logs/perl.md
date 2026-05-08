# Package: Perl (Temporary Tools)

**Version:** 5.42.0
**Chapter:** 7.9
**SBU Estimate:** 0.6 SBU

## Overview
Perl (Practical Extraction and Report Language) is a highly capable text-processing language. It is strictly required in the temporary toolchain because the build scripts, test suites, and autotools of subsequent packages rely heavily on Perl for configuration and code generation.

## Architectural Highlights
- **Custom Configuration:** Utilized Perl's interactive `Configure` script, automated via the `-des` flags (defaults, ensure completion, silent output).
- **Module Hierarchy Isolation:** Explicitly defined `privlib`, `archlib`, `sitelib`, and `vendorlib` to path into `/usr/lib/perl5/5.42/*`. By structuring modules by major and minor version numbers, the system is protected against module breakage during future patch-level upgrades.
- **Dynamic Linking:** Enabled shared library compilation (`-D useshrplib`) to ensure `libperl` is accessible dynamically, preventing unnecessary static binary bloat in the sysroot.
- **Native Installation:** Executed `make install` to directly populate the live filesystem from within the chroot environment.

## Build Notes
- Extracted, configured, and compiled natively inside the chroot.
- Source tree successfully destroyed post-installation.
