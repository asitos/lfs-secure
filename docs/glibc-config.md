# Configuration: Glibc System State

**Version:** 2.43
**Chapter:** 8.5.2 (System Software)

## Overview
Following the installation of the Glibc binaries, this phase establishes the core system configuration files required for network resolution, dynamic library linking, and accurate local timekeeping.

## Security / Custom Modifications
- **Network Service Switch (`nsswitch.conf`):** Manually generated `/etc/nsswitch.conf` to configure how the C library resolves hostnames, passwords, and groups. This replaces the default Glibc behavior, which is unreliable in networked environments.
- **Dynamic Loader Configuration (`ld.so.conf`):** Initialized `/etc/ld.so.conf` to instruct the dynamic loader (`/lib/ld-linux.so.2`) to search for shared libraries in `/usr/local/lib` and `/opt/lib`. 
- **Modular Loader Includes:** Expanded the dynamic loader configuration to automatically source any `.conf` files dropped into the `/etc/ld.so.conf.d/` directory, allowing future packages to cleanly register their own libraries.

## Build Notes
- **Time Zone Data (tzdata):** Extracted and compiled the POSIX time zone database (`tzdata2025c`) using the `zic` compiler. Generated both standard POSIX zones and "right" zones (which account for leap seconds) into `/usr/share/zoneinfo`.
- **Local Time Mapping:** Utilized `tzselect` to identify the correct geographic timezone and permanently mapped it to the system by symlinking `/usr/share/zoneinfo/<Region>/<City>` to `/etc/localtime`.
