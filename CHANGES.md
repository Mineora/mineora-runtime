# What Mineora changed

The runtime is OpenJDK 25.0.4.1 from [jdk25u `7b65d74`](https://github.com/openjdk/jdk25u/commit/7b65d74bcbd7c3a0b4c1f5c5bd85e64aa2e51b4a)
built for Android ARM64. The modified source is in `Mineora-JVM-25.0.4.1-corresponding-source.zip`
on the release; the differences from upstream are the Android port plus the changes below. The
runtime ID `mineora-openjdk-25.0.4.1-android-integration-20261005-v2` records the date of the
shipped build, October 5, 2026.

## Source changes

- Android port of the Linux/aarch64 build: Bionic instead of glibc, no X11 or CUPS libraries at run
  time, headless only.
- Native file handling: UTF-8 bounds fixes in character conversion, and parsing of the process
  memory map (`/proc/self/maps`) as Android lays it out.
- `posix_spawn` for Bionic, taken from Android's dhcpcd 6.8.2 compatibility code
  (`src/java.base/unix/native/libjava/posix_spawn.c` and `.h`, BSD 2-Clause).
- A small `iconv` from the Android Open Source Project (`src/java.base/share/native/libtinyiconv/`,
  BSD 3-Clause), because Bionic has none.
- Headless font support: the font manager links FreeType 2.14.3 and the fonts are DejaVu 2.37 with
  a matching `fontconfig.Linux.properties`. The Lucida fonts are removed. On October 6, 2026 a
  comment describing this modification was added beside the existing link block in
  `make/modules/java.desktop/lib/ClientLibraries.gmk`; no build logic changed.

## Build and packaging choices

- Configured with `--enable-headless-only`, the `server` JVM variant, and the `dtrace`, `zero`,
  `vm-structs` and `epsilongc` features disabled.
- Compiled with the Android NDK r27b clang for `aarch64-linux-android21`, stack protector,
  `_FORTIFY_SOURCE=2`, RELRO with immediate binding, and 16 KB maximum and common page sizes.
- Every ELF file is passed through `termux-elf-cleaner` and `llvm-strip`.
- Not included in the shipped runtime: `.debuginfo` files, `jmods/`, `include/`, `demo/`, `man/`
  and `lib/src.zip`.
- Added at integration under `legal/mineora/`: the FreeType licence files and a short runtime
  change notice.
- The runtime's `bin/java` is shipped as `libjavaexec.so` in the app's native library directory,
  so Android installs it as an executable file.

## Separate components, not part of the OpenJDK build

- Java compatibility agent `mineora-j25shim.jar`: Mineora code on ASM 9.10.1, relocated to
  `app.mineora.shim.asm`, compiled for Java 11.
- `statx` shim: a small native library for older kernels.
- AndroidX graphics-path 1.0.1 JNI library, rebuilt from the pinned upstream source with NDK 28 and
  16 KB page alignment; no C++ behaviour changes.
- Playit agent 0.17.1 (`libplayit.so`): built from the locked source with Rust 1.99.0 and NDK r27b;
  `ratatui` 0.30.2 with `crossterm` 0.29, and `dotenv` replaced by `dotenvy` 0.15.7.
