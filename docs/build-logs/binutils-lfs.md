# Package: Binutils

**Version:** 2.46.0
**Chapter:** 8.21 (System Software)
**SBU Estimate:** 1.7 SBU

## Overview
The Binutils package contains fundamental tools for compiling and linking software, including the assembler (`as`), the linker (`ld`), and a suite of utilities for parsing and manipulating object files. This is a massive, core component of the system toolchain.

## Security / Custom Modifications
- **Out-of-Tree Build:** Compiled strictly within a dedicated `build` directory, as recommended by upstream documentation to prevent source tree contamination.
- **System Zlib Integration:** Passed `--with-system-zlib` to force the package to use the system's dynamic `zlib` library (compiled in Chapter 8.6) rather than its own bundled, internal version.
- **Linker & Plugin Support:** Configured with `--enable-ld=default` to establish `bfd` as the primary linker, and `--enable-plugins` to allow external tools (like GCC) to interface deeply with the linking process.
- **Modern GNU Standards:** Enabled `--enable-default-hash-style=gnu` and `--enable-new-dtags` to ensure the generated ELF binaries comply with modern Linux standards for shared library resolution and hash table generation.
- **Directory Flattening:** Passed `tooldir=/usr` explicitly to the `make` commands. This overrides the default behavior of creating custom target-specific directories (e.g., `/usr/x86_64-pc-linux-gnu`), which are only necessary for cross-compiling environments, keeping our clean LFS hierarchy flat.
- **Static Library Scrubbing:** Aggressively deleted all static archive (`.a`) files associated with internal binutils libraries (bfd, opcodes, ctf, sframe, etc.) post-installation to strictly enforce dynamic linking and conserve disk space.

## Build Notes
- **Required Disk Space:** 835 MB
- **Process:** Configured and built entirely out-of-tree.
- **Test Suite (CRITICAL):** Executed `make -k check`. The Binutils test suite is considered strictly necessary to verify the integrity of the linker. 
  - *Note:* A single test failure related to `gprofng` is a known upstream issue and is safe to ignore.
