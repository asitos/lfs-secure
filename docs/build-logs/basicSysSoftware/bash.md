# Package: Bash

**Version:** 5.3
**Chapter:** 8.37 (System Software)
**SBU Estimate:** 1.5 SBU

## Overview
The Bash package provides the Bourne-Again Shell, the core command interpreter and default user shell for the system. It is heavily relied upon by the system to process shell scripts, execute complex command-line expansions, and mimic standard POSIX `sh` behavior when invoked via symlink.

Key binaries included:
* `bash` (The primary command interpreter)
* `sh` (A symlink to `bash` that forces strictly POSIX-compliant legacy behavior)
* `bashbug` (Utility for composing formatted bug reports)

## Security / Custom Modifications
- **Memory Allocator Hardening:** Configured with `--without-bash-malloc` to explicitly disable Bash's internal memory allocation routines. This forces Bash to use the system `glibc` `malloc()`, ensuring the shell benefits from the stack-smashing protection (`-fstack-protector-strong`) and memory fortification previously baked into the core C library.
- **Shared Library Enforcement:** Passed `--with-installed-readline` to force Bash to link dynamically against the system's freshly built `readline` library rather than compiling its own embedded version. This prevents library duplication and ensures future `readline` security patches apply to the shell automatically.
- **Strict FHS Isolation:** Standard `--prefix=/usr` and version-isolated `--docdir` parameters enforce filesystem hierarchy compliance.
- **Live Shell Replacement:** Executed `exec /usr/bin/bash --login` immediately post-installation. This critical step replaces the currently running, temporary bash process in memory with the newly compiled, fully-linked host binary without dropping the active chroot session.

## Build Notes
- **Required Disk Space:** 56 MB
- **Process:** Compiled cleanly out-of-box using standard configurations.
- **Test Suite:** The Bash test suite requires a strict non-root execution environment with a connected standard input terminal. Bridged this requirement by temporarily granting source ownership to the unprivileged `tester` user (`chown -R tester .`) and spawning a pseudo-terminal using `expect` (`su -s /usr/bin/expect tester`). Handled known, harmless test failures related to missing CJK locales (`zh_TW.BIG5`, `ja_JP.SJIS`) and host-specific `run-builtins` quirks.
- **Installation:** Standard `make install`, followed by the `exec` shell replacement.
