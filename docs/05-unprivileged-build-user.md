# Phase 4: Build Environment Isolation

**Date:** 06/05/26

## The Principle of Least Privilege
Compiling complex software toolchains as the `root` user introduces a catastrophic risk to the host operating system. To mitigate this and enforce strict system boundaries, the entire cross-compilation phase (Chapters 5 & 6) is executed via a dedicated, unprivileged user named `lfs`.

## User Configuration Highlights
- **Skeleton Isolation (`-k /dev/null`):** When the `lfs` user was generated, the standard `/etc/skel` copying was explicitly blocked. This ensures that the host system's default configurations, aliases, and hidden files do not pollute the clean build environment.
- **Strict Ownership:** The `lfs` user was granted ownership *only* over the specific target directories (`$LFS/usr`, `$LFS/var`, `$LFS/etc`, `$LFS/tools`). It has absolutely no write access to the Arch Linux host system.

## Automation
This isolation setup is reproducible via `scripts/setup-lfs-user.sh`.
