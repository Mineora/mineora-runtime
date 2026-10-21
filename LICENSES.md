# Licences

Every component that ships in the Mineora runtime, or beside it in the app, with its licence and the
file under `licenses/` that holds the text. No single licence covers the whole package; the licence
texts govern, this page only indexes them.

## In the runtime archives

| Component | Licence | Text |
| --- | --- | --- |
| OpenJDK 25.0.4.1 with Mineora's changes | GNU GPL version 2 with the Classpath Exception where designated | `OpenJDK-LICENSE.txt`, `OpenJDK-ASSEMBLY_EXCEPTION.txt`, `OpenJDK-ADDITIONAL_LICENSE_INFO.txt`. The runtime's own `legal/` tree keeps OpenJDK's per-module third-party notices. |
| FreeType 2.14.3 | FreeType License (FTL), the option Mineora uses of the two FreeType offers | `FreeType-FTL.TXT`, `FreeType-LICENSE.TXT` (explains the choice), `FreeType-GPLv2.TXT` (the alternative, not used), `FreeType-NOTICE.txt` |
| DejaVu fonts 2.37 | Bitstream Vera Fonts licence; DejaVu changes are public domain; Arev glyphs are copyright Tavmjong Bah under the same terms | `DejaVu-LICENSE.txt` |
| `posix_spawn` from Android's dhcpcd 6.8.2 compatibility code | BSD 2-Clause | `posix-spawn-NOTICE.txt` |
| `tinyiconv` from the Android Open Source Project | BSD 3-Clause | `tinyiconv-NOTICE.txt` |

## Beside the runtime in the app

| Component | Licence | Text |
| --- | --- | --- |
| Java compatibility agent `mineora-j25shim.jar` | Mineora's code under MIT; the relocated ASM 9.10.1 under BSD 3-Clause | `Mineora-MIT-LICENSE.txt`, `ASM-NOTICES.txt` |
| `statx` shim | MIT | `Mineora-MIT-LICENSE.txt` |
| AndroidX graphics-path 1.0.1 JNI library | Apache License 2.0 | `AndroidX-graphics-path-LICENSE.txt`, `AndroidX-graphics-path-NOTICE.txt` |
| Playit agent 0.17.1 `libplayit.so` | BSD 2-Clause; its Rust dependencies under their own terms, listed in `THIRD-PARTY-NOTICES.txt` inside the Playit source ZIP and shipped in the app | `playit-LICENSE.txt` |
| Build and packaging tooling in this repository and the source ZIPs | MIT | `Mineora-MIT-LICENSE.txt` |

## Build inputs that do not ship

The recipe compiles against CUPS 2.2.4 headers and the build host's X11, fontconfig and C library
headers, and runs `termux-elf-cleaner` (GPL version 3) over the output. None of their code is in
the shipped runtime: all 67 shipped ELF files link only Android's `libc`, `libdl` and `libm` plus
the runtime's own libraries. The CUPS and `termux-elf-cleaner` sources and licence texts are inside
`Mineora-JVM-25.0.4.1-corresponding-source.zip` beside `source/dependency-sources.tar.gz`.

## Source for the GPL parts

The complete corresponding source for the GPL-licensed parts is
`Mineora-JVM-25.0.4.1-corresponding-source.zip` on the release named in the README. It contains the
modified OpenJDK source, the dependency sources, the build recipe and the packaging description.
Anyone redistributing the runtime must keep the licence texts and notices and keep this source
available. The Mineora Android app around the runtime is separate and is not covered by this
repository.

## Trademarks

Java and OpenJDK are trademarks or registered trademarks of Oracle and/or its affiliates. Minecraft
is a trademark of Mojang Synergies AB. Playit is a product of Developed Methods LLC. Bitstream Vera
is a trademark of Bitstream, Inc. Mineora is an independent integration and is not affiliated with or
endorsed by any of them.

This software is based in part on the work of the FreeType Team.
