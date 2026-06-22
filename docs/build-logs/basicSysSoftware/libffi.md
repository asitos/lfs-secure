# Package: Libffi

**Version:** 3.5.2
**Chapter:** 8.51 (System Software)
**SBU Estimate:** 1.7 SBU

## Overview
The Libffi (Foreign Function Interface) library provides a portable, high-level programming interface to various calling conventions. It acts as a critical runtime bridge, allowing programs written in interpreted languages (such as Perl and Python) to dynamically call shared library subroutines written in compiled languages (like C or C++).

## Security / Custom Modifications
- **Dynamic Linking Enforcement:** Configured with `--disable-static` to ensure only the shared object library (`libffi.so`) is generated. This ensures that any dependent languages or interpreters seamlessly inherit future security patches applied to Libffi without requiring those interpreters to be recompiled.
- **Strict Architecture Optimization:** Explicitly configured with `--with-gcc-arch=native` to force the compiler to optimize the machine code specifically for the host CPU. Preventing the compiler from guessing the architecture guarantees execution stability and prevents catastrophic "Illegal Operation" CPU faults during dynamic foreign function calls.
- **System-Wide FHS Compliance:** Applied the standard `--prefix=/usr` to ensure the core library is installed directly into the correct root filesystem hierarchy.

## Build Notes
- **Required Disk Space:** 10 MB
- **Process:** Compiled cleanly in-tree utilizing the CPU-native optimization parameters.
- **Test Suite:** Executed `make check` to verify the mathematical integrity of the memory alignments, register passing, and foreign calling conventions strictly against the host architecture.
- **Installation:** Standard `make install` execution.
