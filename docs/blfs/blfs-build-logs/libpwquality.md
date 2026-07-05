# Package: libpwquality (Password Quality Library)

**Version:** 1.4.5
**Chapter:** BLFS Security / Authentication
**SBU Estimate:** 0.1 SBU

## Overview
The `libpwquality` package provides a robust library and utility set for evaluating password strength and scoring passwords based on their apparent randomness. It serves as the modern, functional replacement for the obsolete `pam_cracklib.so` PAM module. Additionally, it offers tools for generating secure, pronounceable random passwords.

## Security / Custom Modifications
- **Shared Libraries Only:** Passed `--disable-static` during configuration to strictly enforce dynamic linking for all dependent applications.
- **PAM Module Pathing:** Explicitly mapped the installation directory for the PAM module (`--with-securedir=/usr/lib/security`) to ensure the system's authentication framework can locate it.
- **Modern Python Packaging:** Bypassed the deprecated `setup.py` execution by passing `--disable-python-bindings` to `configure`. Instead, the Python bindings were securely built and installed using modern, isolated `pip3 wheel` and `pip3 install` commands.
- **Strict PAM Enforcement:** Completely replaced the default `/etc/pam.d/system-password` configuration to integrate `pam_pwquality.so`. This configuration explicitly ties the authentication framework to the `CrackLib` dictionary (`dictpath=/usr/lib/cracklib/pw_dict`), enforces dictionary checks (`dictcheck=1`), and chains it with the secure `yescrypt` algorithm via `pam_unix.so`.

## Build Notes
- Configured via standard `./configure` with specific flags to disable static libraries and legacy Python builds.
- Compiled the core C libraries via `make`, followed immediately by building the Python wheel (`pip3 wheel -w dist...`).
- **Note:** Upstream does not provide a test suite for this package.
- Deployed the C components via `make install` and the Python module via `pip3 install` as root.
- Reconfigured the system's PAM password policy by backing up the original `system-password` file and injecting the strict `pam_pwquality` ruleset.
