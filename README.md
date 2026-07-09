# lfs-secure

this project is a custom, security-minded operating system created from scratch using the linux from scratch (lfs) approach.

creating an os from scratch is more than just following instructions; it is a learning process where one must understand the boundary between kernel space and user space, memory allocation, and system initialization. unlike mainstream distros that aim for compatibility with all, lfs-secure was crafted for security with minimal attack surface through explicit definition of what is allowed to run.

### status: audited and baseline established

**current lynis hardening index: 90**

the system has been rigorously audited using the lynis security benchmark. the goal was never to blindly chase a score, but to understand the "why" behind every security control, accepting trade-offs where usability and realistic architecture mattered more than arbitrary metrics.
![audits](./audits)

**first successful system boot (unhardened):**
<img width="1920" height="1080" alt="Image" src="https://github.com/user-attachments/assets/1d754b91-13d2-44dd-8988-01c5faa47db4" />
*(successful boot of the unhardened base system)*

**final audit (hardened):**
<img width="2833" height="1463" alt="Image" src="https://github.com/user-attachments/assets/b2b1ba00-03a9-4de3-9179-d2c68781ac4a" />

### what's in this repo
this repo is the "recipe" for the build. it tracks:
- **kernel configurations:** custom .config files optimized for security, featuring removed legacy features and hardened networking stacks.
- **sysctl hardening:** a comprehensive set of kernel parameters to mitigate memory corruption, prevent stack overflows, and disable dangerous networking features like source routing and icmp redirects.
- **automation scripts:** scripts for streamlined compilation, service management, and hardening configuration to ensure the build remains reproducible.
- **security configurations:** hardened templates for sshd_config, pam modules, and file integrity monitoring configurations.
- **documentation:** build notes, patch logs, and audit reports tracking the system’s security posture.

### architectural deep dive & kernel internals
the core of this system runs on a custom-compiled 6.18.10 linux kernel. standard kernels are bloated with drivers and legacy protocols to support every possible hardware configuration. this kernel was stripped down to the bare metal requirements.

### core hardening focus
- **kernel-level hardening:** the kernel is compiled with aggressive restrictions, stripping out unused drivers and legacy protocols (such as dccp, sctp, and tipc) to reduce the potential attack surface. memory protections are strictly enforced.
- **proactive network defense:** the netfilter/iptables firewall is implemented at the kernel level. the ruleset is applied during the boot sequence to ensure the system is protected from network-based threats from the moment the network stack initializes.
- **least privilege and blast radius reduction:** 
    - system-wide enforcement of a strict umask (027) to ensure file permissions are never overly permissive.
    - blacklisting of sensitive kernel modules such as usb-storage and firewire to prevent unauthorized hardware interaction.
    - hardening of the ssh daemon by disabling password authentication, restricting allowed users, and modifying default ports.
    - deployed aggressive kernel parameters to mitigate memory corruption tactics. this includes restricting `kptr_restrict` to hide kernel pointers, enforcing `dmesg_restrict` to prevent unprivileged users from reading kernel logs, and disabling dangerous network vectors like icmp redirects and source routing.

### build notes
this system is an ongoing experiment. the build process is heavily logged in ![docs](./docs) to ensure that every security decision is intentional. moving forward, the focus will shift towards trying to break into the system's security through a raspberry pi i have to learn about penetrating a secure system.

### what i learned 
his project felt like a systems engineering course on its own. i didn't just learn to type commands; i learned how the linux kernel manages hardware, how the boot loader transfers control to systemd, and how user-space daemons interact with kernel-space subsystems. 

**demystifying systemd and the boot process**
before this, i thought systemd was just a black box that started and stopped services. building this system forced me to understand it as a complex, strict dependency tree of unit files and targets. when a custom kernel configuration and a massive memory mapping error caused background daemons to hang, standard commands like `systemctl disable` completely froze because the underlying dbus communication socket was locked. i learned how to manually recover the system by dropping into a root shell, navigating directly to `/etc/systemd/system/multi-user.target.wants/`, and physically ripping out the broken service symlinks. bypassing the dead dbus and untangling the boot sequence mechanically taught me that beneath the complex tooling, linux initialization is just a deeply nested structure of plain text files and symlinks.

**kernel architecture and the netfilter framework**
securing the network stack required diving deep into the kernel configuration menu (`make menuconfig`). to get a hardened iptables firewall working while maintaining strict module loading restrictions, i had to recompile the core kernel image (`bzImage`). this taught me the critical architectural difference between compiling features as loadable modules (`<M>`) versus baking them directly into the monolithic kernel (`<*>`). by integrating the netfilter framework, packet filtering tables, and the `xt_Log` target directly into the core networking stack, i eliminated the firewall's reliance on `modprobe` at runtime, fundamentally shrinking the attack surface.

**user-space interactions and environment isolation**
this project completely reshaped my understanding of permissions and environment isolation. doing a deep audit of the system to enforce a restrictive `027` umask meant hunting down shell initialization scripts in `/etc/profile.d/` and understanding exactly how bash parses environment variables upon user login. i also ran into the reality of how `sudo` actively strips environment variables (like x11 display paths for clipboard access) to isolate the root security context. learning to explicitly preserve environments with `sudo -e` or securely modify the `sudoers` file highlighted exactly how linux sandboxes administrative privileges.

**source compilation and dependency chains**
you can't just `apt install` a security tool on lfs. to implement file integrity monitoring, i had to build aide (advanced intrusion detection environment) completely from source. this required tracking down c library dependencies like pcre (perl compatible regular expressions), configuring the build environment with explicit prefix paths (`--prefix=/usr --sysconfdir=/etc`), compiling the binaries, and manually initializing the cryptographic database. building software this way removes the "magic" from package managers and replaces it with a concrete understanding of how raw c code becomes an executable binary integrated into a live filesystem.

ultimately, lfs taught me that an operating system is not a single cohesive entity. it is a fragile, intricate clockwork of thousands of independent, highly specific components. understanding exactly how they mesh together at a mechanical level is the only real way to secure them.
