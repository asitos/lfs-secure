# Package: Readline

**Version:** 8.3
**Chapter:** 8.12 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Readline package provides a set of libraries that offer advanced command-line editing and history capabilities. It is the core backend that allows users to use arrow keys, reverse-search (Ctrl+R), and edit text on interactive command lines (like the Bash shell).

## Security / Custom Modifications
- **Linking Bug Prevention:** Used `sed` to disable the default behavior where reinstalling Readline moves old libraries to a `.old` extension. This prevents a known, highly specific linking bug triggered by `ldconfig`.
- **Rpath Hardening:** Stripped hardcoded library search paths (`rpath`) from the shared libraries by patching `support/shobj-conf`. Hardcoded `rpath`s are unnecessary in standard FHS environments and can introduce security vulnerabilities by hijacking library load orders.
- **Upstream C-Code Patching:** Applied an inline fix directly to the `input.c` source code using `sed` to resolve a known logic bug specific to version 8.3.
- **Curses Integration:** Passed `--with-curses` during configuration to ensure `termcap` library functions are resolved through the `curses` library (generating the correct `readline.pc` file). Additionally, passed `SHLIB_LIBS="-lncursesw"` to `make` to force explicit linking against the wide-character `ncurses` shared library.
- **Static Linking Prevention:** Passed `--disable-static` to enforce dynamic shared-object (`.so`) generation exclusively.
- **Documentation Routing:** Directed documentation output to the proper `/usr/share/doc/readline-8.3` directory.

## Build Notes
- **Required Disk Space:** 17 MB
- **Process:** Required significant pre-configuration source manipulation (via `sed`) before running the standard `configure` and `make` pipeline. 
- **Test Suite:** This package does not include an upstream test suite.
- **Documentation:** Extra formats (PostScript, PDF, HTML, DVI) were manually installed post-compilation.
