# Build the Android Java runtime

This recipe builds a usable Android ARM64 image from the supplied source. A separate fresh Linux build passed runtime probes and Paper startup/save/stop. Byte-identical reproduction of the shipped archives is not established. Build-tool paths, timestamps and versions can affect bytes.

## Inputs

- Linux x86_64 build host, Bash, Python 3, autoconf, make, GNU GCC/binutils with bfd, X11 and fontconfig development headers.
- Boot JDK 25.
- Android NDK r27b. The runtime recipe uses r27b; the Android app's native build uses r28. These are separate builds.
- Included OpenJDK Android-port source, dependency sources, FreeType 2.14.3 and DejaVu 2.37 package.

Extract the attached `Mineora-JVM-25.0.4.1-corresponding-source.zip`. From the extracted folder run:

```bash
bash tooling/build-port.sh \
  source/openjdk-25.0.4.1-android-audit-source.tar.gz \
  source/dependency-sources.tar.gz \
  /path/to/boot-jdk25 \
  /path/to/android-ndk-r27b \
  /path/to/new-output \
  source/freetype-2.14.3.tar.xz
```

The output directory must not already exist. The script copies the NDK before creating header links. The script builds FreeType and OpenJDK images; it ends before final app packaging.

## Packaging after building

Use the built JDK image under the fresh output's `source/build/linux-aarch64-server-release/images/jdk` and its matching FreeType shared library. Supply DejaVu fonts and the included `packaging/fontconfig.Linux.properties`, retain font/library notices, and remove Lucida files. Strip/clean Android ELF files using the supplied dependency sources and appropriate NDK tools; these post-build steps remain a documented procedure, not a tested one-command byte-identical packager.

For Mineora's final layout:

1. Retain the runtime libraries/modules, compiler compatibility file `lib/ct.sym`, certificates, configuration, fonts and legal notices. Exclude `.debuginfo`, `jmods/`, `include/`, `demo/`, `man/`, and unused `lib/src.zip` from the installed image. Do not remove corresponding source from its separate downloadable package.
2. Separate ELF files into `bin-arm64.tar.xz`; put retained non-ELF files into `universal.tar.xz`. Preserve their relative runtime paths and file permissions. The shipped inventories describe the expected installed files.
3. The Android executable launcher is packaged as `libjavaexec.so` in the app's ARM64 native-library directory. It originates from the runtime's `bin/java`, after the packaging/stripping steps. The name is for Android packaging; it is launched as an executable.
4. Retain notices in the runtime and app distribution. The final shipped archive and launcher hashes are in `evidence/app-runtime-manifest.json`. A build that differs from them is a new binary requiring tests; do not claim hash identity.

## Validation

Small probe sources are in `probes/`. Test file/ZIP UTF-8, NIO, ProcessBuilder, instrumentation, fonts/PNG, and a real server with normal saved shutdown. Also test application extraction/upgrade, existing worlds, launch flags and target Android versions. These probe sources are not a substitute for the complete OpenJDK test suite.

This archive covers the maintained OpenJDK runtime. The separate app compatibility agent and native statx helper are described in `KNOWN-LIMITATIONS.md`; this package is not a source-provenance certification for every APK component.
