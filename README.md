<p align="center">
  <img src="assets/mineora-logo.png" alt="Mineora" width="112">
</p>

# Mineora Runtime

**Java for Minecraft servers on Android.**

Mineora uses this runtime to run Java Minecraft servers on your phone. It is an Android ARM64 adaptation of **OpenJDK 25.0.4.1**, packaged for the Mineora app.

Selected Paper, Fabric and NeoForge servers have passed startup, save and stop checks. Plugin and mod compatibility depends on the server and its Java requirements. See [known limits](KNOWN-LIMITATIONS.md).

This repository provides the matching source downloads, build instructions and component licenses for **[Mineora 1.2.6 (code 28), available on Google Play](https://play.google.com/store/apps/details?id=app.mineora)**. It contains runtime materials, rather than the full Android app or Minecraft server software.

## What Mineora changes

- Android compatibility fixes for native file handling, UTF-8 bounds and process memory-map parsing.
- Headless font support using FreeType 2.14.3 and DejaVu 2.37 instead of Lucida fonts.
- Separate compatibility helpers and Playit integration, with their own source and notices.

## Start here

- [Build instructions](BUILDING.md)
- [Component licenses](LICENSES.md)
- [Known limits and provenance](KNOWN-LIMITATIONS.md)
- [Security and safe reporting](SECURITY.md)

## Download the complete source

Get **all three source ZIPs** and the checksum file from the [versioned release](https://github.com/Mineora/mineora-runtime/releases/tag/mineora-1.2.6-runtime-v3):

| File | Contents |
| --- | --- |
| [JVM corresponding source](https://github.com/Mineora/mineora-runtime/releases/download/mineora-1.2.6-runtime-v3/Mineora-JVM-25.0.4.1-corresponding-source.zip) | Patched OpenJDK, supplied dependency sources, FreeType source, DejaVu fonts, build recipe, probes and legal notices |
| [Playit Android source](https://github.com/Mineora/mineora-runtime/releases/download/mineora-1.2.6-runtime-v3/Mineora-Playit-Android-source.zip) | Matching Playit source, Cargo lock, rebuild flags and notices |
| [Android runtime helpers](https://github.com/Mineora/mineora-runtime/releases/download/mineora-1.2.6-runtime-v3/Mineora-Android-runtime-helpers-source.zip) | Java compatibility agent, pinned ASM source, statx shim and pinned AndroidX graphics JNI source |
| [SHA-256 checksums](https://github.com/Mineora/mineora-runtime/releases/download/mineora-1.2.6-runtime-v3/SHA256SUMS.txt) | Integrity hashes for those three downloads |

GitHub's automatic **Source code.zip** contains this documentation repository. It does **not** contain the full OpenJDK source. Use the explicit release attachments above. Source downloads and notices must remain accessible to recipients.

## Build identity

- Runtime ID: `mineora-openjdk-25.0.4.1-android-integration-20261005-v2`
- Source base: [OpenJDK jdk25u `7b65d74bcbd7c3a0b4c1f5c5bd85e64aa2e51b4a`](https://github.com/openjdk/jdk25u/commit/7b65d74bcbd7c3a0b4c1f5c5bd85e64aa2e51b4a)
- App AAB SHA-256: `4c31046d5b1ef62dd3dae5eb239dfceb8e7c3fb6bdb70b017fb6cd526c7ffad3`
- [Installed runtime hashes](evidence/app-runtime-manifest.json)
- [Validation summary](evidence/validation-summary.json)

Testing scope, reproduction limits and support for older releases are documented in [known limits](KNOWN-LIMITATIONS.md).

## Licenses

OpenJDK uses GPL v2, with the Classpath Exception where designated. Other components retain their own licenses. Read [the license index](LICENSES.md) and preserve the supplied notices. There is no blanket MIT license for the runtime.

This software is based in part on the work of the FreeType Team.

The Mineora name and logo identify this project; they do not change any component's license. This is a Mineora integration, not an official Oracle/OpenJDK, Mojang/Microsoft or Playit distribution.
