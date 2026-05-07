# Package: Ncurses (Temporary Native Tool)

**Version:** 6.6
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.4 SBU

## Overview
Ncurses provides the API for text-based terminal user interfaces (TUI). This package is critical for future interactive configuration menus, such as the Linux kernel's `menuconfig`. 

## Security / Custom Modifications
- **Host Tool Bootstrapping (`tic`):** A host-native version of the terminfo compiler (`tic`) was compiled into `$LFS/tools` first. This guarantees that the target's terminfo database is generated cleanly without relying on (or being corrupted by) the host system's `tic` binary.
- **Compiler Safety (`--disable-stripping`):** Explicitly prevented the build system from stripping debug symbols during cross-compilation. Allowing the host's `strip` binary to touch cross-compiled libraries can fatally corrupt them.
- **Wide-Character Forcing:** Created an explicit symlink from `libncurses.so` to the wide-character library (`libncursesw.so`) and patched the `curses.h` header with `sed` to default to `#if 1` for XOPEN support. This guarantees seamless UTF-8 handling inside the future chroot.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
