# Package: OpenSSH (Secure Shell Client and Daemon)

**Version:** 10.2p1
**Chapter:** BLFS Security / Authentication
**SBU Estimate:** 0.3 SBU (Using parallelism=4; tests take ~11 minutes regardless of CPU)

## Overview

The `OpenSSH` package provides secure, encrypted replacements for legacy network tools like telnet, rsh, and rcp. It includes the `ssh` and `scp` clients, secure file transfer utilities (`sftp`), and the `sshd` daemon, ensuring robust authentication and subsequent traffic encryption across local networks and the Internet.

## Security / Custom Modifications

* **Privilege Separation Environment:** Configured a dedicated, non-privileged group and user (`sshd:sshd`, GID/UID 50) and a restricted shell-less directory (`/var/lib/sshd`, `/bin/false`) prior to compilation. OpenSSH splits runtime tasks between a highly privileged master process controlling rights and an unprivileged network-facing process to limit attack surfaces.
* **FHS Compliance:** Passed `--sysconfdir=/etc/ssh` to contain configuration layout and set `--with-pid-dir=/run` to enforce modern runtime state compliance rather than utilizing the legacy `/var/run` tree.
* **Path Matching:** Explicitly configured target executable search limits (`--with-default-path` and `--with-superuser-path`) to match the Shadow password framework defaults established in basic LFS setups.
* **Hardening Enhancements:** Recommended changes applied post-install block root entry entirely (`PermitRootLogin no`), drop password/keyboard-interactive entries in favor of cryptographic key-pair validations (`PasswordAuthentication no` and `KbdInteractiveAuthentication no`), and securely duplicate local PAM rules (`UsePAM yes`) if compiled with PAM hooks.

## Build Notes

* Prepared system users/groups and deployed the empty isolation home directory before initiating configuration.
* Configured via standard `./configure` with specific hooks tracking paths, privileges, and optional dependencies (e.g., `--with-pam`, `--with-kerberos5=/usr`, or `--with-libedit`).
* Compiled core objects via `make`.
* Test suite executed strictly via sequential execution (`make -j1 tests`).
* Deployed files via `make install` as root, followed by the explicit installation of the `ssh-copy-id` helper script, its manual page, and standard project documentation trees.
* Installs the systemd unit `sshd.service` via `make install-sshd` out of the central BLFS systemd units package. Note that custom `ListenAddress` overrides are not natively supported by this basic unit.
