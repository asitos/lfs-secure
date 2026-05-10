# Package: Pcre2

**Version:** 10.47
**Chapter:** 8.13 (System Software)
**SBU Estimate:** 0.2 SBU

## Overview
The Pcre2 package provides the next generation of Perl Compatible Regular Expression libraries. These libraries are deeply integrated into many system tools and applications to provide powerful, complex pattern matching capabilities.

## Security / Custom Modifications
- **Performance Optimization (JIT):** Passed `--enable-jit` to enable Just-In-Time compilation, which massively accelerates pattern matching operations across the system.
- **Modern Encoding Support:** Configured with `--enable-unicode`, `--enable-pcre2-16`, and `--enable-pcre2-32` to fully support UTF-8, UTF-16, and UTF-32 character strings.
- **System Integration (Grep & Testing):** Leveraged previously compiled packages by passing `--enable-pcre2grep-libz` and `--enable-pcre2grep-libbz2` (allowing `pcre2grep` to directly search inside `.gz` and `.bz2` compressed archives) and `--enable-pcre2test-libreadline` (giving the test utility command-line history and editing capabilities).
- **Static Linking Prevention:** Enforced dynamic linking exclusively by passing `--disable-static`
- **Path & Documentation Enforcement:** Used `--prefix=/usr` and `--docdir=/usr/share/doc/pcre2-10.47` to maintain strict FHS compliance for binaries and versioned documentation.

## Build Notes
- **Required Disk Space:** 28 MB
- **Process:** Utilized the standard C compilation pipeline (`configure`, `make`, `make install`).
- **Test Suite:** Executed the `make check` suite prior to installation to ensure the complex regular expression engines and JIT compiler integrated correctly with the host architecture.
