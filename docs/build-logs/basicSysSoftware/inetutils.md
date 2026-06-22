# Package: Inetutils

**Version:** 2.7
**Chapter:** 8.42 (System Software)
**SBU Estimate:** 0.3 SBU

## Overview
The Inetutils package provides the fundamental suite of networking utilities essential for basic host communication, diagnostics, and interface management. It includes critical diagnostic tools like `ping`, `traceroute`, and `ifconfig`, alongside basic client applications for network protocols.

Key binaries included:
* `ping` & `ping6` (ICMP network diagnostics)
* `ifconfig` (Network interface management)
* `hostname` & `dnsdomainname` (System identification)
* `traceroute`, `telnet`, `ftp`, `tftp`, and `talk`

## Security / Custom Modifications
- **Insecure Protocol Eradication:** Explicitly disabled the compilation of legacy, unencrypted remote execution protocols (`--disable-rsh`, `--disable-rlogin`, `--disable-rcp`, `--disable-rexec`). These are cryptographically unsafe and are deliberately omitted in favor of OpenSSH, which will be provisioned later.
- **Server Attack Surface Reduction:** Passed `--disable-servers` to completely prevent the installation of all network daemons (such as `telnetd` or `ftpd`). These daemons are inherently insecure, transmit data in plaintext, and have no place in a zero-trust or tightly controlled architecture.
- **Redundancy & Obsolescence Trimming:** Disabled the `logger` and `whois` clients. The system will rely on the modern, superior `logger` provided by Util-linux, and the `whois` client is completely outdated.
- **Compiler Compatibility Patch:** Pre-emptively applied a `sed` patch (`sed -i 's/def HAVE_TERMCAP_TGETENT/ 1/' telnet/telnet.c`) to force compatibility with GCC-14's strict C standards regarding termcap definitions.
- **Privilege Separation (FHS Compliance):** Manually relocated the `ifconfig` binary post-installation (`mv -v /usr/bin/ifconfig /usr/sbin/ifconfig`). This strict FHS enforcement guarantees that administrative interface management tools remain exclusively within the root/administrative execution path (`sbin`).

## Build Notes
- **Required Disk Space:** 38 MB
- **Process:** Compiled cleanly in-tree following the GCC-14 `sed` patch and aggressive configuration trimming.
- **Test Suite:** Executed `make check` to verify the operational integrity of the networking clients within the chroot environment.
- **Installation:** Standard `make install` execution, followed immediately by the `ifconfig` binary relocation.
