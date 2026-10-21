<p align="center">
  <img src="assets/mineora-logo.png" alt="Mineora" width="112">
</p>

# Mineora Runtime

**Java for Minecraft servers on Android.**

This repository is the public source and licence record for the Java runtime inside the
[Mineora Android app](https://play.google.com/store/apps/details?id=app.mineora). The runtime is
**OpenJDK 25.0.4.1** adapted by Mineora for Android ARM64. Mineora **1.2.6 (version code 28)** and
**1.2.7 (version code 30)** ship the identical runtime archives, so this repository covers both.

The repository holds documentation, the build and packaging scripts, licence texts and build
evidence. The complete source is attached to the release below. GitHub's automatic **Source code**
ZIP on the release page contains only this documentation repository, not OpenJDK.

## Source downloads

Release [`mineora-1.2.6-runtime-v3`](https://github.com/Mineora/mineora-runtime/releases/tag/mineora-1.2.6-runtime-v3)
(October 6, 2026). It is titled for 1.2.6 and applies unchanged to 1.2.7.

| File | Contents | SHA-256 |
| --- | --- | --- |
| [Mineora-JVM-25.0.4.1-corresponding-source.zip](https://github.com/Mineora/mineora-runtime/releases/download/mineora-1.2.6-runtime-v3/Mineora-JVM-25.0.4.1-corresponding-source.zip) (157 MB) | Patched OpenJDK source, FreeType 2.14.3, DejaVu 2.37, dependency sources, build script, probes, shipped-file hashes, notices | `fcfb6c28b686ffe848314cc6966c588be77d8dc45dd54b642702ca00b2651342` |
| [Mineora-Playit-Android-source.zip](https://github.com/Mineora/mineora-runtime/releases/download/mineora-1.2.6-runtime-v3/Mineora-Playit-Android-source.zip) | Playit agent 0.17.1 source, `Cargo.lock`, rebuild flags, dependency notices | `4c6709749990f611091a800e198ad97b80b4d7890e99c191ae9a48d66afb809a` |
| [Mineora-Android-runtime-helpers-source.zip](https://github.com/Mineora/mineora-runtime/releases/download/mineora-1.2.6-runtime-v3/Mineora-Android-runtime-helpers-source.zip) | Java compatibility agent with pinned ASM 9.10.1 source, statx shim, AndroidX graphics-path 1.0.1 JNI source | `b7324b45b17f25c33dffbf59ffc36f5d516403fc1cc51bb7edc222772fe69628` |
| [SHA256SUMS.txt](https://github.com/Mineora/mineora-runtime/releases/download/mineora-1.2.6-runtime-v3/SHA256SUMS.txt) | The same three hashes | |

The documents and scripts inside the JVM ZIP are the October 6 versions. Use the scripts in this
repository's `tooling/` folder; [BUILDING.md](BUILDING.md) explains why.

## What the runtime contains

- OpenJDK 25.0.4.1 from [jdk25u `7b65d74`](https://github.com/openjdk/jdk25u/commit/7b65d74bcbd7c3a0b4c1f5c5bd85e64aa2e51b4a)
  with Mineora's Android changes, listed file by file in [CHANGES.md](CHANGES.md).
- FreeType 2.14.3 and the DejaVu 2.37 fonts for headless font support. Lucida fonts are removed.
- A `posix_spawn` implementation from dhcpcd, compiled into `libjava`, and the AOSP `tinyiconv`
  converter, compiled into `libinstrument` and `libjdwp`.

The app also ships these separate components, whose source is in the helpers and Playit ZIPs:
the Java compatibility agent (`mineora-j25shim.jar`, built on ASM 9.10.1), the statx shim, the
AndroidX graphics-path JNI library rebuilt for 16 KB pages, and the Playit tunnel agent (`libplayit.so`).

## Build identity

| | |
| --- | --- |
| Runtime ID | `mineora-openjdk-25.0.4.1-android-integration-20261005-v2` |
| `bin-arm64.tar.xz` (67 files) | `8b99e2ce17e5aa81cff385d9d0c5e62a345eca57333ba6e96e50058f8aa4413f` |
| `universal.tar.xz` (309 files) | `aff39f099b4f1cb768a90d9d16aa26392d79eb1a197eee87854e6f2135e6b780` |
| `libjavaexec.so` (the runtime's `bin/java`) | `601e63091197ab6eec0e38edb340aa279ea82999e9f8f172b1ee858ce528b282` |
| Mineora 1.2.6 code 28 AAB | `4c31046d5b1ef62dd3dae5eb239dfceb8e7c3fb6bdb70b017fb6cd526c7ffad3` |

How a rebuild compares with these files: [BUILDING.md](BUILDING.md) and
[evidence/build-provenance.md](evidence/build-provenance.md).

## Documents

- [BUILDING.md](BUILDING.md): build and package the runtime, and what a rebuild reproduces.
- [CHANGES.md](CHANGES.md): every file Mineora changed relative to upstream OpenJDK.
- [LICENSES.md](LICENSES.md): licence of every shipped component, where its text is, trademarks.
- [KNOWN-LIMITATIONS.md](KNOWN-LIMITATIONS.md): what is recorded as tested and what is not.
- [SECURITY.md](SECURITY.md): scope and how to report a problem.

There is no single licence for this package; see [LICENSES.md](LICENSES.md). This software is based
in part on the work of the FreeType Team.
