# Package: CrackLib (Password Strength Checking)

**Version:** 2.10.3
**Chapter:** BLFS Security / Password Management
**SBU Estimate:** < 0.1 SBU

## Overview
The `CrackLib` package contains a library used to enforce strong passwords by comparing user-selected passwords against extensive word lists. It is designed to filter out weak, guessable passwords at the source by utilizing dictionaries of regular language words, common substitutions, and word-based keystroke combinations.

## Security / Custom Modifications
- **Shared Libraries Only:** Passed `--disable-static` during configuration to prevent the installation of static versions of the libraries, ensuring all dependents use the dynamic object.
- **Dictionary Pathing:** Configured with `--with-default-dict=/usr/lib/cracklib/pw_dict` to force the installation of the dictionary database to the correct `/lib` hierarchy.
- **Site-Specific Hardening:** Added a custom build step (`echo $(hostname) >> /usr/share/dict/cracklib-extra-words`) to explicitly blacklist the machine's hostname from being used as a valid password. 
- **Shadow Toolchain Dependency:** Note that if the `Shadow` package is already installed on the system, it must be rebuilt/reinstalled *after* `CrackLib` to successfully link and provide strong password support (unless `Linux-PAM` is being installed immediately after).

## Build Notes
- Configured and compiled via standard `./configure` and `make`.
- Deployed via `make install` as root.
- Extracted the recommended English wordlist (`cracklib-words-2.10.3.xz`) to `/usr/share/dict/cracklib-words` and symlinked it to the historical `/usr/share/dict/words` path.
- Generated the binary dictionary database using the `create-cracklib-dict` utility, combining the standard word list and the extra words list.
- Functionality verified post-build using `make test` and the Python module tested via `python3 -c 'import cracklib; cracklib.test()'`.
