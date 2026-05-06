# Package: GCC (Pass 1)

**Version:** 15.2.0
**Chapter:** 5 (Cross-Compiler Stage 1)
**Build Time:** 2m18.3732s

## Security / Custom Modifications
- **Environment Override:** `CXXFLAGS="-O2 -fno-char8_t"`
- **Reason:** The default `configure` script failed during the compilation of the `libcody` component. Modern host environments strict-enforce UTF-8 string literals (`u8""`) as `char8_t`, which broke older C++ template deductions (`const char`) inside the `libcody` source code. 
- **Action:** Injected the `-fno-char8_t` flag directly into the C++ compiler flags during configuration to force standard character parsing and successfully bypass the build failure.

## Build Notes
- Successfully extracted and linked `gmp`, `mpfr`, and `mpc` inside the source tree prior to compilation.
- Target `lib64` directory was successfully aliased to `lib` via the provided `sed` script.
