## System Optimization: Stripping Binaries (Chapter 8.85)

**Objective:** Reduce the final footprint of the LFS system by stripping unnecessary debugging symbols and symbol table entries from compiled binaries and shared libraries. This process typically reclaims around 2 GB of disk space.

### The Technical Challenge
Stripping binaries is generally straightforward, but performing this operation on core system libraries (like the ELF dynamic linker `ld-linux`, or the C standard library `libc.so.6`) while the system is actively running them presents a critical risk. 

If the `strip` command overwrites an active binary directly in `/usr/lib` or `/usr/bin`, it can instantly crash the processes relying on that code, rendering the entire LFS chroot environment unusable.

### The "Copy-Strip-Replace" Methodology
To safely strip active libraries without crashing the system, I utilized a safe-replacement script. The methodology operates as follows:

1.  **Isolation:** Copy the critical active library (e.g., `libc.so.6`) to a temporary location (`/tmp`).
2.  **Modification:** Execute the `strip --strip-debug` command on the isolated copy in `/tmp`.
3.  **Atomic Replacement:** Use the `install` command to copy the stripped binary back into `/usr/lib`. The `install` command is crucial here because it unlinks the existing file and creates a new one, ensuring that any processes currently executing the old code in memory are not interrupted.

### Debug Preservation
For specific core libraries (such as `libstdc++` and `libc`), the debugging symbols were explicitly extracted, compressed using `zstd`, and preserved in separate `.dbg` files. This ensures that tools like `gdb` and `valgrind` can still be utilized later in the Beyond Linux From Scratch (BLFS) phase for advanced system debugging.

**Note:** During the final recursive stripping loop across `/usr/{bin,sbin,libexec}`, numerous warnings regarding "file format not recognized" were generated. This is expected behavior, as the `find` command passes shell scripts to the `strip` utility, which can only process compiled ELF binaries.
