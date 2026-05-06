# Phase 3: Initial Target Filesystem Layout

**Date:** 06/05/26

## Overview
To prepare the target partition (`$LFS`) for the temporary cross-compiler toolchain, a limited directory hierarchy was established.

## The `usr-merge` Architecture
Instead of using traditional split directories, this system adopts the modern `usr-merge` approach immediately. 
- `/bin`, `/lib`, and `/sbin` are created as symbolic links pointing directly into their respective directories under `/usr`. 
- This simplifies package management later on and prevents execution path fragmentation.

## Toolchain Isolation
A dedicated `$LFS/tools` directory was created to house the temporary cross-compiler (Chapter 6). This strict separation ensures that temporary build tools are completely isolated from the final, secured system libraries built in Chapter 8, preventing accidental contamination of the final OS environment.

## Automation
This process is reproducible via `scripts/create-layout.sh`.
