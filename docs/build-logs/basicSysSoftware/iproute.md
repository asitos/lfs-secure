# Package: IPRoute2

**Version:** 6.18.0
**Chapter:** 8.68 (System Software)
**SBU Estimate:** 0.1 SBU

## Overview
The IPRoute2 package provides the modern, definitive suite of tools for controlling TCP/IP networking and traffic control on Linux. It completely replaces the deprecated `net-tools` package (which contained legacy commands like `ifconfig`, `route`, and `netstat`).

Key binaries included:
* `ip` (The monolithic network configuration tool used to manage interfaces, routing, tunnels, and addresses)
* `ss` (The modern replacement for `netstat`, used to dump socket statistics)
* `tc` (Traffic Control utility for configuring Quality of Service, packet scheduling, and bandwidth shaping)
* `bridge` (Utility for configuring network bridges)
* `ifstat` / `lnstat` (Network interface statistic monitors)

## Security / Custom Modifications
- **Dependency Minimization:** Applied a `sed` patch to the `Makefile` and explicitly deleted the `arpd.8` manual page prior to compilation. This forcefully prevents the build system from attempting to compile the `arpd` daemon, which requires the Berkeley DB library. Since Berkeley DB is deliberately omitted from the base LFS environment, this patch ensures a clean, successful build.
- **Runtime Path Definition:** Compiled with `NETNS_RUN_DIR=/run/netns`. This strictly maps network namespace runtime data to the volatile, in-memory `/run` hierarchy, ensuring proper isolation and cleanup upon reboot.
- **System-Wide FHS Compliance:** Installed with `SBINDIR=/usr/sbin` to rigidly enforce that these critical network administration binaries are placed in the secure system binary path, compliant with modern filesystem hierarchy standards.

## Build Notes
- **Required Disk Space:** 17 MB
- **Process:** Makefile patching followed by a custom `make` invocation.
- **Test Suite:** No functional test suite is provided by the upstream maintainers.
- **Installation:** Executed `make install` utilizing the custom `SBINDIR` variable, followed by the manual deployment of documentation into standard `/usr/share/doc/` paths.
