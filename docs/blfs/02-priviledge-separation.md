### Phase 2: User Provisioning & Privilege Separation
**Status:** Implemented

**Architecture:** Daily administration as the omnipotent `root` user is restricted to enforce the Principle of Least Privilege (PoLP). System-level changes are now strictly delegated through the `wheel` group via `sudo`.

**Implementation details:**
1. **User Generation:** Provisioned two distinct accounts: `asitos-admin` (attached to the `wheel` group) and `asitos-user` (standard unprivileged). 
2. **Modular Sudoers Configuration:** Privilege escalation rules were written to a drop-in file (`/etc/sudoers.d/`) rather than editing the master `/etc/sudoers` file. This prevents syntax errors from bricking root access and allows for cleaner automated management.
3. **Permission Hardening:** The drop-in configuration was locked to `0440` permissions, ensuring it is strictly read-only and only accessible by the root owner.

**Execution Log:**
```bash
# Set secure passwords for provisioned users
passwd asitos-admin
passwd asitos-user

# Delegate sudo access to the wheel group via drop-in file
echo "%wheel ALL=(ALL:ALL) ALL" > /etc/sudoers.d/10-wheel-group

# Lock down the drop-in file permissions (Root read-only)
chmod 0440 /etc/sudoers.d/10-wheel-group
```
