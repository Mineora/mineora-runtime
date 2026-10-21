# Building the runtime

Two scripts in `tooling/` turn the published source into the shipped runtime:
`build-port.sh` builds the JDK image, `package-runtime.py` packages it into the two archives.
Use the copies in this repository. The copy of `build-port.sh` inside the October 6 JVM ZIP
predates the `VERSION_OPT` and `SOURCE_DATE` variables, and the ZIP has no packaging script.

## Inputs

- Linux x86_64 host with Bash, Python 3, autoconf, make, GNU GCC and binutils (with bfd, used for
  the host-side build tools), and the X11 and fontconfig development headers.
- A boot JDK 25. The shipped runtime used Temurin 25.0.3+9.
- Android NDK r27b. The app's own native code uses NDK 28; the runtime does not.
- `termux-elf-cleaner`, built from the source in `source/dependency-sources.tar.gz`.
- From `Mineora-JVM-25.0.4.1-corresponding-source.zip`: `source/openjdk-25.0.4.1-android-audit-source.tar.gz`,
  `source/dependency-sources.tar.gz`, `source/freetype-2.14.3.tar.xz` and `source/DejaVu-fonts-2.37.zip`.

## Build

```bash
VERSION_OPT=adhoc.root.source SOURCE_DATE=1791180150 JOBS=4 \
bash tooling/build-port.sh \
  source/openjdk-25.0.4.1-android-audit-source.tar.gz \
  source/dependency-sources.tar.gz \
  /path/to/boot-jdk25 \
  /path/to/android-ndk-r27b \
  /path/to/build \
  source/freetype-2.14.3.tar.xz
```

The output directory must not exist yet. The script logs the input hashes and the whole build to
`evidence/rebuild.log` under it.

`VERSION_OPT` and `SOURCE_DATE` pin the version string and build date that OpenJDK embeds in the
image. The shipped runtime was built as `root` in a directory named `source` on
2026-10-05T06:02:30Z, which is what these two values encode. Without them, `configure` uses your
user name, directory and the current time.

## Package

```bash
python3 tooling/package-runtime.py package /path/to/build source/DejaVu-fonts-2.37.zip \
  /path/to/termux-elf-cleaner /path/to/packaged
python3 tooling/package-runtime.py integrate /path/to/packaged /path/to/archives
```

`package` leaves out debug files, `jmods/`, `include/`, `demo/` and `man/`, adds FreeType, the
DejaVu fonts and `fontconfig.Linux.properties`, and runs every ELF file through
`termux-elf-cleaner` and `llvm-strip`. `integrate` removes `lib/src.zip`, adds the four notices
under `legal/mineora/`, and writes `bin-arm64.tar.xz` (the 67 ELF files) and `universal.tar.xz`
(the other 309). The app ships `bin/java` a second time as `libjavaexec.so`.

The shipped hashes are in `evidence/app-runtime-manifest.json`. A build that differs from them is
a new binary and needs testing again.

## What a rebuild reproduces

On October 20, 2026 the build was run on an Omarchy (Arch-based) Linux x86_64 machine with NDK r27b
and boot JDK Temurin 25.0.3+9, packaged, and compared file by file with the shipped runtime:

| Run | Identical files | Different | What differs |
| --- | --- | --- | --- |
| Without the pinning variables | 335 of 372 | 37 | Only the embedded version string and build date |
| With `VERSION_OPT=adhoc.root.source SOURCE_DATE=1791180150` | 371 of 372 | 1, `lib/modules` | 4 bytes in each of two `jdk.jpackage` launcher resources, which Mineora does not use, plus the module hashes derived from them |

On October 21, 2026 `package-runtime.py integrate` was run on the pinned build: it produced the
same 67 + 309 split, and 375 of the 376 files are identical to the shipped runtime (all but
`lib/modules`). The `.tar.xz` archives themselves are not byte-identical; tar metadata and xz
settings of the originals were not recorded.

These rebuilds used the source tarball the October 5 build used. The published tarball differs
from it in one file only: the two-line comment in `make/modules/java.desktop/lib/ClientLibraries.gmk`
added on October 6, which changes no build logic.

## Validation

The JVM ZIP's `probes/` directory holds small test programs for UTF-8 file and ZIP handling, NIO and
child processes, the instrumentation agent, headless fonts and PNG output, and the memory-map and
iconv native code. They are not a substitute for the OpenJDK test suite.
