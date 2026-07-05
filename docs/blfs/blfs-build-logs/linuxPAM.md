# Package: Linux-PAM (Pluggable Authentication Modules)

**Version:** 1.7.2
**Chapter:** BLFS Security / Authentication
**SBU Estimate:** 0.3 SBU (with tests)

## Overview
The `Linux-PAM` package provides a centralized framework for authentication. It contains Pluggable Authentication Modules that allow system administrators to seamlessly manage and dictate how applications authenticate users, effectively separating the authentication mechanism from the applications themselves.

## Security / Custom Modifications
- **Restrictive Fallback Policy:** Implemented a strict default `/etc/pam.d/other` configuration utilizing `pam_warn.so` and `pam_deny.so`. This "default-deny" posture ensures that any PAM-aware application attempting to run without an explicitly defined configuration file is immediately blocked and the attempt is logged.
- **Modern Cryptography:** Configured the `/etc/pam.d/system-password` profile to enforce the modern `yescrypt` hashing algorithm and integrate with shadow passwords (`yescrypt shadow try_first_pass`).
- **SUID Helper Hardening:** Explicitly set the Set-UID bit on the `unix_chkpwd` helper binary (`chmod -v 4755 /usr/sbin/unix_chkpwd`). This is required to allow non-root processes (like screen lockers) to securely verify a user's password against the shadow file without exposing the file itself.
- **Kernel Auditing Dependency:** Ensured Kernel Auditing (`CONFIG_AUDIT`) is enabled, which is a strict prerequisite for the `pam_loginuid.so` module to track system sessions correctly (especially critical when integrated with Systemd).
- **Toolchain Rebuilds:** Noted the critical post-installation requirement: core system components like `Shadow` and `Systemd` must be recompiled and reinstalled immediately to link against the new PAM infrastructure.

## Build Notes
- **Documentation Build Patch:** Applied an inline `sed` patch to `meson.build` to substitute the unavailable `elinks` renderer with `lynx` for building the plain-text documentation.
- Configured using the `meson` build system from an out-of-source `build` directory, targeting a release build (`--buildtype=release`).
- Compiled the binaries via `ninja`.
- **Secure Testing Environment:** Before running the test suite (`ninja test`), a temporary `/etc/pam.d/other` file populated with `pam_deny.so` rules was created to allow the tests to execute safely. This file was removed immediately after verification.
- Deployed binaries via `ninja install` and manually generated the core system profiles (`system-account`, `system-auth`, `system-session`, `system-password`) into `/etc/pam.d/` as root.
