# Package: Vim

**Version:** 9.2.0078
**Chapter:** 8.75 (System Software)
**SBU Estimate:** 3.2 SBU

## Overview
The Vim (Vi IMproved) package provides a highly powerful, modal text editor that is ubiquitous across Unix-like systems. It is an extended version of the classic `vi` editor, featuring syntax highlighting, advanced text objects, and extensive configuration capabilities. It serves as the primary text editor for many users to edit system configurations and write code.

Key binaries included:
* `vim` (The core text editor)
* `vi` (A manual symlink created to point to `vim` for muscle-memory convenience)
* `vimdiff` (Edits two or three versions of a file side-by-side to show differences)
* `vimtutor` (An interactive tutorial for learning basic Vim commands)
* `xxd` (A highly useful utility that creates hex dumps of files or performs the reverse operation)
* **Aliases:** `ex`, `view` (read-only mode), `rvim` (restricted mode), `rview`

## Security / Custom Modifications
- **Global Configuration Path:** Explicitly injected `#define SYS_VIMRC_FILE "/etc/vimrc"` into `src/feature.h` prior to compilation. This forcefully overrides Vim's default behavior, ensuring that the global system configuration file is read from the standard `/etc` directory.
- **Symlink Emulation:** Manually created a `/usr/bin/vi` symlink pointing to `vim`, along with mirroring the manual pages. This is a crucial ergonomic step since many system scripts and users reflexively type `vi`.
- **Sensible Defaults (`/etc/vimrc`):** Created a custom global configuration file to establish modern defaults:
  * `set nocompatible`: Disables legacy `vi` bug compatibility, enabling full Vim features.
  * `set backspace=2`: Allows the backspace key to function normally over line breaks and indents.
  * `set mouse=`: Disables automatic mouse integration, which is critical for allowing standard terminal copy/paste operations when working inside a chroot or SSH session.
  * `syntax on`: Enables global syntax highlighting.

## Build Notes
- **Required Disk Space:** 217 MB
- **Process:** Header file patching, followed by standard `./configure --prefix=/usr` and `make`.
- **Test Suite:** The test suite required execution as the non-root `tester` user. One specific test (`test_plugin_glvs`) was deleted via `sed` because it requires `curl`/`wget` (which are not yet installed). Standard output was redirected to `vim-test.log` because the suite dumps raw binary data that can completely corrupt the active terminal state.
- **Installation:** Standard `make install` execution, followed by the manual creation of symlinks and documentation directory alignment.
- **Future Expansion:** The base LFS build only compiles the terminal version. If a GUI (gvim) is desired, Vim must be recompiled later in BLFS after the X Window System is installed.
