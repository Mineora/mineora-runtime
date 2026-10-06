# Mineora Android runtime

Source, build instructions and licenses for the runtime components used by **Mineora 1.2.6 (code 28)**. The main runtime is a modified **OpenJDK 25.0.4.1 Android ARM64 port**. This repository does not contain the complete Mineora Android app, users' servers or a desktop Java installer.

## Runtime changes

The Android port includes native file/UTF-8 bounds fixes and maps parsing repairs. Headless font support uses FreeType 2.14.3 and DejaVu 2.37 instead of Lucida fonts. Separate source downloads cover the Java compatibility helper, native helpers and Playit integration.

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

A separate clean runtime build passed targeted runtime and Paper tests. Byte-identical reproduction of the final packaged binaries is not established. The S22 tests and native alignment checks do not certify every Android device or third-party server pack. Older live Mineora releases require a separate matching-source assessment.

## Licenses

Keep each component's notices and terms. OpenJDK uses GPL v2, with the Classpath Exception where designated. FreeType, DejaVu, Playit, ASM, AndroidX and the newly authored helper/tooling retain their own licenses. **There is no blanket MIT license for this repository or runtime.** Publishing this source does not automatically relicense the separate Kotlin app.

This software is based in part on the work of the FreeType Team.

This is a Mineora integration, not an official Oracle/OpenJDK or Playit binary distribution.
