# Package: Procps-ng

**Version:** 4.0.6
**Chapter:** 8.81 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The Procps-ng package provides essential command-line utilities for monitoring system processes, memory usage, and kernel state. These tools directly interface with the `/proc` virtual filesystem maintained by the Linux kernel to expose critical performance and diagnostic data to the user.

Key binaries included:
* **Process Monitoring:** `ps`, `top`, `pgrep`, `pidof`, `pmap`
* **Process Control:** `pkill` (Note: `kill` is omitted here in favor of the Util-linux version)
* **System State:** `free` (memory), `uptime`, `vmstat`, `sysctl` (kernel parameter modification)
* **Utility:** `watch` (repeatedly executes a command to observe output changes)

## Security / Custom Modifications
- **Binary Delegation (`--disable-kill`):** Explicitly passed during configuration. The standard `kill` command is intentionally omitted from this build because the version provided by the upcoming Util-linux package is considered the definitive, more feature-complete implementation for modern systems.
- **Internationalization (`--enable-watch8bit`):** Ensures the `watch` utility compiles with `ncursesw` support, allowing it to correctly display 8-bit, multi-byte characters (like UTF-8) without breaking the terminal layout.
- **Systemd Integration (`--with-systemd`):** Enabled to ensure process monitoring tools correctly interface with systemd control groups (cgroups), allowing commands like `ps` and `top` to identify which systemd service spawned a particular process.
- **Library Stripping (`--disable-static`):** Prevents the generation of statically linked libraries, forcing binaries to rely on the shared `libproc-2.so`, minimizing disk space and ensuring security updates to the library propagate to all dependent tools.

## Build Notes
- **Required Disk Space:** 28 MB
- **Process:** Configured and compiled cleanly using standard GNU Autotools.
- **Test Suite:** The test suite required execution as the unprivileged `tester` user. *Note:* One specific `ps` formatting test (`bsdtime,cputime...`) relies heavily on host kernel features. It will predictably fail if your Arch host kernel lacks BSD process accounting (`CONFIG_BSD_PROCESS_ACCT`). This is safe to ignore.
- **Installation:** Standard `make install` execution.
