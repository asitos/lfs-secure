# Package: Kbd

**Version:** 2.9.0
**Chapter:** 8.69 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Kbd package provides the essential utilities for configuring the core Linux console environment. It contains the tools required to manage virtual terminals (TTYs), load regional keyboard layouts (keymaps), modify keyboard repeat rates, and apply custom console fonts. 

Key binaries included:
* `loadkeys` & `dumpkeys` (Loads and dumps keyboard translation tables)
* `setfont` & `showconsolefont` (Changes and displays the VGA/EGA console font)
* `chvt`, `openvt`, `deallocvt` (Virtual terminal management)
* `showkey` (Reports the raw scancodes, keycodes, and ASCII codes of pressed keys)

## Security / Custom Modifications
- **Backspace/Delete Consistency Patch:** Applied `kbd-2.9.0-backspace-1.patch`. By default, the behavior of the Backspace and Delete keys is notoriously inconsistent across different i386 keymaps. This patch forces the Backspace key to uniformly generate character code 127 and the Delete key to generate the standard escape sequence, preventing terminal input frustration.
- **Defunct Dependency Elimination:** Used `sed` to strip the `resizecons` program and its manual page from the build process. This legacy tool requires the long-defunct `svgalib` to function; modern console resizing is handled natively by `setfont`.
- **PAM Restriction (`--disable-vlock`):** Passed `--disable-vlock` during configuration. The `vlock` utility allows users to lock virtual consoles, but it relies on Pluggable Authentication Modules (PAM) to verify passwords. Because PAM is not included in the base LFS specification, attempting to compile `vlock` would trigger a build failure. 
- **System-Wide FHS Compliance:** Configured explicitly with `--prefix=/usr` to place all binaries and mapping tables strictly within standard execution paths.

## Build Notes
- **Required Disk Space:** 37 MB
- **Process:** Patch application, `sed` modifications, and standard GNU Autotools configuration. 
- **Test Suite:** Executed `make check` to ensure internal keycode mapping and font-handling logic compiled correctly.
- **Installation:** Standard `make install` execution, followed by the manual copying of the documentation hierarchy to `/usr/share/doc/kbd-2.9.0`.
- **Caveat:** Users relying on specific non-Latin encodings (such as the CP1251 keymap for Belarusian) may need to source external keymaps post-installation, and should avoid using the included `unicode_start` script unless their base keymap is strictly ISO-8859-1.
