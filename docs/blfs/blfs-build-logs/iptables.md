# Package: iptables (Packet Filtering Framework)

**Version:** 1.8.12
**Chapter:** BLFS Security / Firewalls
**SBU Estimate:** 0.1 SBU

## Overview
The `iptables` package provides the userspace command-line utilities required to configure, maintain, and inspect the IPv4 and IPv6 packet filtering rulesets in the Linux kernel's Netfilter framework. It is the core tool used for constructing personal firewalls, masquerading routers, and implementing complex network packet manipulation and security policies.

## Security / Custom Modifications
- **Kernel Prerequisites:** For `iptables` to enforce any security policies, the host kernel must be explicitly configured to support the Netfilter framework. This includes enabling Connection Tracking (`NF_CONNTRACK`), Xtables legacy support (`NETFILTER_XTABLES_LEGACY`), and IP tables support (`IP_NF_IPTABLES`).
- **nftables Omission:** Explicitly disabled `nftables` compatibility (`--disable-nftables`) during configuration to maintain a strict, legacy `iptables` build environment without mixed filtering backends.
- **Library Export:** Enabled the compilation of `libipq.so` (`--enable-libipq`) to ensure compatibility with external tools that may rely on the iptables userspace packet queueing mechanism.

## Build Notes
- Configured via standard `./configure` utilizing the specific backend flags mentioned above.
- Compiled the main binaries and libraries via `make`.
- **Note:** Upstream does not provide a test suite for this package.
- Deployed the binaries and libraries to the system via `make install` as root.
