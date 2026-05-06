# Phase 2: Source Acquisition & Mirror Optimization

**Date:** 06/05/26

## Package Downloads
To build the OS, the source packages defined in the official LFS `wget-list-systemd` were required.

### The Bottleneck
The default upstream FTP/HTTP servers listed in the official manifest severely limited download speeds, making a single-threaded `wget` acquisition highly inefficient.

### Custom Solution
To optimize the build pipeline, I created a custom automation script (`scripts/switch-mirror.sh`). 

This script utilizes `sed` and `awk` to:
1. Strip the slow upstream URLs from the standard manifest.
2. Prepend the high-speed regional mirror (NUS Singapore for the `systemd` variant).
3. Output a localized manifest (`wget-list-fast`).

This bypassed the upstream bottleneck and significantly accelerated the source acquisition phase. 

### Verification
Following the optimized download, all packages were successfully validated against the official LFS `md5sums` to ensure zero corruption before compilation begins. Both the localized manifest and checksums are tracked in `build-manifests/`.
