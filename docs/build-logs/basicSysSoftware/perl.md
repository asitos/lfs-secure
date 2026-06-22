# Package: Perl

**Version:** 5.42.0
**Chapter:** 8.44 (System Software)
**SBU Estimate:** 1.3 SBU

## Overview
The Perl package provides the Practical Extraction and Report Language, a highly capable scripting language that blends features of C, `sed`, `awk`, and `sh`. It is a fundamental dependency for many system build scripts (including Linux kernel configurations) and provides extensive text processing capabilities. 

Key binaries included:
* `perl` (The core interpreter)
* `cpan` (Comprehensive Perl Archive Network package manager)
* `perldoc` & `pod*` utilities (Documentation parsing and conversion)
* `shasum` (Checksum verification utility)

## Security / Custom Modifications
- **Shared Library Enforcement:** Exported `BUILD_ZLIB=False` and `BUILD_BZIP2=0` prior to configuration. This explicitly overrides Perl's default behavior of statically compiling its own internal copies of these compression libraries. By forcing Perl to link dynamically against the system's external Zlib and Bzip2 libraries, we ensure that future security patches to those core compression algorithms automatically secure the Perl interpreter without requiring a recompilation of Perl itself.
- **Strict FHS Layout:** Passed extensive directory flags (`-D prefix`, `-D vendorprefix`, `-D privlib`, etc.) to the `Configure` script. This forces Perl to distribute its vast array of core, site, and vendor modules cleanly into `/usr/lib/perl5/5.42/`, strictly maintaining the Filesystem Hierarchy Standard.
- **Dynamic Linking:** Configured with `-D useshrplib` to ensure the core Perl engine is built as a shared C library (`libperl.so`) rather than a static binary, reducing memory footprint and allowing other programs to natively embed the Perl engine.
- **Man Page Override:** Manually specified `-D man1dir` and `-D man3dir` to ensure the generation of manual pages, bypassing the automatic disablement that occurs because the `groff` text formatter is not yet installed in the chroot environment.

## Build Notes
- **Required Disk Space:** 257 MB
- **Process:** Configured using the interactive `Configure` script passed with the `-des` flags for non-interactive, default-accepting setup based on our manual overrides.
- **Test Suite:** Executed `TEST_JOBS=$(nproc) make test_harness` to run the comprehensive testing suite in parallel, verifying the language's core syntax engine, regex parsing, and module linking mechanisms.
- **Installation:** Standard `make install`, followed by unsetting the temporary build environment variables.
