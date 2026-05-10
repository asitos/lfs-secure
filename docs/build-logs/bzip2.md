# Package: Bzip2

**Version:** 1.0.8
**Chapter:** 8.7 (System Software)
**SBU Estimate:** < 0.1 SBU

## Overview
The Bzip2 package provides tools for compressing and decompressing files. It uses a block-sorting file compressor, which yields a significantly better compression percentage for text files compared to traditional gzip, making it crucial for archiving and source code distribution.

## Security / Custom Modifications
- **Documentation Patching:** Applied `bzip2-1.0.8-install_docs-1.patch` to ensure the package documentation is correctly formatted and staged during installation.
- **Makefile Hardening (Pathing):** Utilized `sed` to modify the Makefile twice: first to ensure all installed symbolic links are relative (preventing broken links if the root filesystem is mounted elsewhere), and second to force man pages into the FHS-compliant `/usr/share/man` directory instead of `/usr/man`.
- **Dynamic Linking Strategy:** Explicitly built the package using `Makefile-libbz2_so`. This deviates from the default static build by creating a dynamic shared object (`libbz2.so`) and linking the Bzip2 utilities directly against it, improving memory efficiency.
- **ABI Compatibility Mapping:** Manually established a compatibility symlink (`libbz2.so.1` -> `libbz2.so.1.0.8`). Because library naming isn't strictly standardized across distros, this ensures packages like `Kbd` that expect an older or differently-named library reference can still safely link to it.
- **Binary Deduplication:** Installed the dynamically linked `bzip2-shared` binary and replaced redundant copies of `bzcat` and `bunzip2` with lightweight symlinks pointing to the main executable.
- **Static Library Scrubbing:** Deleted the newly generated static archive (`/usr/lib/libbz2.a`) to enforce dynamic linking for all future packages compiling against Bzip2.

## Build Notes
- **Required Disk Space:** 7.3 MB
- **Process:** Required a multi-stage make process (building the `.so` first, cleaning the tree, and then compiling the main package) to properly separate the shared library from the static objects.
