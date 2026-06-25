# Chapter 9: System Configuration (Systemd Edition)

**Objective:** Configure the network, console, locale, and init system (systemd) for the base LFS build. 

*Note: Several standard LFS configurations were intentionally bypassed or modified to accommodate a laptop hardware profile, a dual-boot architecture with an Arch Linux host, and future cybersecurity/networking requirements.*

### 1. Network Configuration (DHCP & DNS)
Hardcoding static IPs and specific network interfaces is impractical for a mobile development machine. The system was configured to dynamically accept IP addresses and DNS configurations across various environments.

* **DHCP Wildcard Configuration (`/etc/systemd/network/10-dhcp.network`):** Instead of binding to a specific interface like `enp3s0` or `eth0`, the configuration utilizes the `Name=en* eth* usb*` wildcard. This ensures the system automatically requests an IP address via standard Ethernet or **USB Tethering** (crucial since base LFS lacks `wpa_supplicant` for native Wi-Fi).
* **Dynamic DNS (`/etc/resolv.conf`):** Delegated DNS management entirely to `systemd-resolved` by creating a symlink to `/run/systemd/resolve/stub-resolv.conf`.
* **Local Hostname Resolution (`/etc/hosts`):** Configured strictly for IPv6 loopback and multicast addresses. IPv4 loopback (`127.0.0.1`) is handled automatically by the `nss-myhostname` systemd module.

### 2. Time & Clock Management
* **Hardware Clock Sync:** Intentionally skipped the creation of `/etc/adjtime`. By omitting this file, `systemd` defaults the hardware clock to UTC. This prevents the LFS build and the Arch Linux host from fighting over the motherboard's clock and causing timezone drifts.
* **Timezone:** To be set to `Asia/Kolkata` using `timedatectl` upon the first successful boot.

### 3. Console & Locale Settings
* **Virtual Console (`/etc/vconsole.conf`):** Set the keyboard map to standard `us` and the font to `Lat2-Terminus16` to ensure proper rendering of Unicode characters (like em-dashes and smart quotes) in the raw TTY before a graphical display server is installed.
* **System Locale (`/etc/locale.conf`):** Set primary locale to `en_IN.UTF-8` for appropriate Indian date, time, and currency formatting.
* **Bash Profile (`/etc/profile`):** Implemented a conditional script that detects the terminal type. It forces a fallback to `C.UTF-8` on the raw Linux console to prevent rendering errors, while allowing `en_IN.UTF-8` to pass through to future graphical terminals.

### 4. Input Configuration (`/etc/inputrc`)
Created a global readline configuration file to standardize keyboard input across the terminal. 
* Mapped standard escape sequences to ensure the `Delete`, `Home`, and `End` keys function correctly instead of printing raw escape codes (e.g., `^[[3~`).
* **Terminal Bell:** Explicitly disabled the hardware terminal bell (`set bell-style none`).

### 5. Systemd Core Tweaks
Modified the default `systemd` behavior to improve debugging and workflow capabilities:
* **Disabled TTY1 Screen Clearing:** Created an override in `/etc/systemd/system/getty@tty1.service.d/noclear.conf` (`TTYVTDisallocate=no`). This prevents systemd from wiping the screen prior to the login prompt, ensuring kernel panics and boot errors remain visible for debugging.
* **Preserved User Background Processes:** Modified `/etc/systemd/logind.conf.d/lingering.conf` (`KillUserProcesses=no`). By default, modern systemd kills all user processes upon logout. This override ensures tools like `tmux`, `screen`, and background compilation scripts survive session terminations.

### Skipped/Deferred Configurations
* **Device Management (udev rules):** Skipped custom device naming. Native predictable interface naming is sufficient until specific external interfaces (like multiple identical wireless adapters for penetration testing) are required.
* **tmpfs `/tmp` modifications:** Left `/tmp` configured to mount in RAM, which is optimal for NVMe/SSD wear-leveling and temporary compilation speed.
