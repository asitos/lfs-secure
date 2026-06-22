# Package: Systemd

**Version:** 259.1
**Chapter:** 8.78 (System Software)
**SBU Estimate:** 1.1 SBU

## Overview
The Systemd package is the core init system and service manager for modern Linux distributions. It replaces the traditional SysVinit, taking over the boot process immediately after the kernel initializes the hardware. It is responsible for parallelizing service startup, managing daemons, controlling the system journal (`journald`), and managing device events via `udev`.

Key binaries included:
* **Core Init:** `init` (symlinked to systemd), `systemctl` (the primary control interface)
* **Device Management:** `udevadm`
* **Logging:** `journalctl` (used to query the binary `journald` logs)
* **System Management:** `hostnamectl`, `localectl`, `timedatectl`, `loginctl`
* **Power Management:** `halt`, `poweroff`, `reboot`, `shutdown`

## Security / Custom Modifications
- **Udev Group Rules:** Modified `50-udev-default.rules.in` via `sed` to replace the `render` group with `video`, and removed the `sgx` group entirely, aligning device permissions with the standard LFS group structures established in Chapter 7.
- **Strict Meson Configuration:** The `meson setup` command includes a highly customized, restrictive configuration block explicitly designed for the manual LFS build methodology:
  * **Feature Stripping:** Disabled `homed`, `sysusers`, `sysupdate`, `firstboot`, and `ukify`. These daemons manage automatic user creation, OS updates, and boot setups which are strictly incompatible with a from-scratch environment where the administrator builds and configures everything manually.
  * **Security Overrides:** Enforced `dev-kvm-mode=0660` to restrict virtual machine access, explicitly defined the `nogroup` GID, and disabled `pamconfdir` as PAM is not yet available.
  * **Build Optimizations:** Enforced a `release` build type and disabled `ldconfig` execution at boot to minimize startup latency.
- **Pre-compiled Man Pages:** Passed `-D man=disabled` to prevent the heavy dependency footprint required to generate manuals from source. Instead, pre-generated man pages were extracted directly into `/usr/share/man` post-installation.

## Build Notes
- **Required Disk Space:** 349 MB
- **Process:** Configured using the `meson` and `ninja` build systems bootstrapped in previous chapters.
- **Test Suite:** Testing systemd is complex within a chroot. An `/etc/os-release` file was temporarily mocked, and the tests were executed inside an isolated mount namespace (`unshare -m ninja test`) to prevent temporary mount points from polluting the host system. Several tests (like `test-namespace`) are expected to fail or timeout due to the lack of kernel module support in the chroot environment.
- **Installation:** Executed `ninja install`, extracted the supplementary manual pages, generated the unique system identifier (`systemd-machine-id-setup`), and initialized the default target structure (`systemctl preset-all`).
