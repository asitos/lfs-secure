# lfs-secure

this project is a bespoke, security-first operating system built entirely from source code following the linux from scratch (lfs) methodology. while mainstream distributions prioritize universal compatibility and ease of use, lfs-secure is built on the principle of proactive security. instead of retrofitting security patches onto a general-purpose os, this system is hardened from the kernel upwards to minimize the attack surface and enforce the principle of least privilege.

### status: hardened and audited
**current lynis hardening index: 90**

the base system is stable and has been audited against the lynis security benchmark. the hardening process focused on neutralizing threats at both the kernel and user-space boundaries.

![base lfs system boot](assets/firstboot.jpg)
*(successful boot of the hardened base system)*

### what's in this repo
this repo is the "recipe" for the build. it tracks:
- **kernel configurations:** custom .config files optimized for security, featuring removed legacy features and hardened networking stacks.
- **sysctl hardening:** a comprehensive set of kernel parameters to mitigate memory corruption, prevent stack overflows, and disable dangerous networking features like source routing and icmp redirects.
- **automation scripts:** scripts for streamlined compilation, service management, and hardening configuration to ensure the build remains reproducible.
- **security configurations:** hardened templates for sshd_config, pam modules, and file integrity monitoring configurations.
- **documentation:** build notes, patch logs, and audit reports tracking the system’s security posture.

### core hardening focus
- **kernel-level hardening:** the kernel is compiled with aggressive restrictions, stripping out unused drivers and legacy protocols (such as dccp, sctp, and tipc) to reduce the potential attack surface. memory protections are strictly enforced.
- **proactive network defense:** the netfilter/iptables firewall is implemented at the kernel level. the ruleset is applied during the boot sequence to ensure the system is protected from network-based threats from the moment the network stack initializes.
- **least privilege and blast radius reduction:** 
    - system-wide enforcement of a strict umask (027) to ensure file permissions are never overly permissive.
    - blacklisting of sensitive kernel modules such as usb-storage and firewire to prevent unauthorized hardware interaction.
    - hardening of the ssh daemon by disabling password authentication, restricting allowed users, and modifying default ports.

### build notes
this system is an ongoing experiment. the build process is heavily logged to ensure that every security decision is intentional. moving forward, the focus will shift towards trying to break into the system's security through a raspberry pi i have to learn about penetrating a secure system.


