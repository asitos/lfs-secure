# Package: Glibc (Pass 1)

**Version:** 2.43
**Chapter:** 5 (Cross-Compiler Stage 1)
**SBU Estimate:** 1.4 SBU

## Security / Custom Modifications
- **FHS Compliance Patch:** Applied `glibc-fhs-1.patch` to force Glibc programs to store runtime data in standard, modern Filesystem Hierarchy Standard locations rather than legacy `/var/db` directories.
- **Dynamic Loader Symlinks:** Manually established LSB-compliant symbolic links for the `x86_64` dynamic library loader (`ld-linux-x86-64.so.2`) to ensure future toolchain binaries can map their shared libraries correctly.
- **Path Enforcements:** Created a `configparms` file to strictly route administrative binaries (`ldconfig`, `sln`) directly into `/usr/sbin`.
- **Cross-Compilation Boundary:** Passed `--host=$LFS_TGT` and explicitly installed via `make DESTDIR=$LFS install`. This successfully prevented the newly compiled C library from contaminating the Arch host filesystem, maintaining absolute cleanroom integrity.

## Build Notes
- Extracted and compiled cleanly. 
- Disregarded the `msgfmt` warning during configuration, as it is a harmless missing host dependency (Gettext) that does not impact the isolated target build.
