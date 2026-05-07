# Package: Diffutils (Temporary Native Tool)

**Version:** 3.10 
**Chapter:** 6 (Cross-Compiling Temporary Tools)
**SBU Estimate:** 0.1 SBU

## Overview
Diffutils provides essential file comparison and patching utilities (`diff`, `cmp`, `patch`). These are strictly required in the target sysroot for applying source code patches to subsequent packages inside the chroot environment.

## Security / Custom Modifications
- **Target Sysroot Mapping:** Configured with `--host=$LFS_TGT` and installed via `make DESTDIR=$LFS install` to prevent host contamination.
- **Cross-Compilation Override:** Injected the `gl_cv_func_strcasecmp_works=y` variable directly into the configuration. This safely bypasses an upstream autoconf check that erroneously attempts to execute a target-compiled binary on the host machine to test `strcasecmp`. We force-validated this check based on our isolated Glibc-2.43 capabilities.

## Build Notes
- Extracted, configured, and compiled cleanly.
- Source tree successfully destroyed post-installation.
