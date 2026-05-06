# Phase 5: Cleanroom Build Environment

**Date:** 06/05/26

## Environment Isolation (`env -i`)
To prevent host system contamination during the cross-compilation phase, the `lfs` user's `.bash_profile` utilizes `exec env -i`. This replaces the login shell with a new instance containing a completely empty environment (retaining only `HOME`, `TERM`, and `PS1`). 

## Toolchain Targeting
The `.bashrc` establishes the critical `$LFS_TGT` variable (the target architecture triplet) and isolates the execution `$PATH` to prioritize the temporary `$LFS/tools/bin` directory. This ensures that when compilation commands like `gcc` or `make` are called, the system explicitly uses the newly built, isolated cross-toolchain rather than the host's native utilities.

## Build Optimization
Parallel compilation is globally enabled via the `MAKEFLAGS` environment variable, utilizing all available logical CPU cores on the host machine to optimize compile times.

## Artifacts
The specific shell configurations are tracked in `configs/lfs-user/`.
