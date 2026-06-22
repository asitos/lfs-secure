# Package: Texinfo

**Version:** 7.2
**Chapter:** 8.74 (System Software)
**SBU Estimate:** 0.3 SBU

## Overview
The Texinfo package provides the foundational system for reading, writing, and converting GNU Info pages. Unlike standard manual (`man`) pages, which generally provide quick command-line references, `info` pages are structured hierarchically and often act as comprehensive, deep-dive manuals for GNU software.

Key binaries included:
* `info` (The interactive terminal-based reader for Info pages)
* `install-info` (Updates the global Info index file)
* `makeinfo` / `texi2any` (Translates Texinfo source documents into Info pages, plain text, or HTML)
* **Formatting utilities:** `texi2pdf`, `texi2dvi`, and `texindex` (Used to compile documents into printable formats)

## Security / Custom Modifications
- **Perl Compatibility Patch:** Applied a `sed` fix (`sed 's/! $output_file eq/$output_file ne/' -i tp/Texinfo/Convert/*.pm`) prior to configuration. This preemptively corrects a deprecated code pattern that triggers strict warnings when parsed by Perl versions 5.42 or later.
- **System-Wide FHS Compliance:** Configured directly with `--prefix=/usr` to ensure the binaries are installed securely into the standard system execution path.
- **TeX Integration:** Executed a supplemental `make install-tex` command targeting `TEXMF=/usr/share/texmf`. This specifically provisions the TeX tree root location, ensuring seamless integration if a full TeX formatting environment is installed later in BLFS.

## Build Notes
- **Required Disk Space:** 160 MB
- **Process:** Perl syntax patching followed by standard GNU Autotools configurations.
- **Test Suite:** Executed `make check` to ensure the document translation and formatting algorithms parse macros and index files correctly without data loss.
- **Installation:** Standard `make install` execution, followed by the TeX environment deployment. 
- **System Maintenance Trick:** The master index file for the `info` system (`/usr/share/info/dir`) can occasionally become desynchronized over the lifespan of an OS. The LFS instructions provide a quick Bash loop to completely purge and safely regenerate this directory file from scratch using `install-info`, an invaluable snippet for future system administration.
