# Mineora Runtime

Source of the Java runtime in the [Mineora Android app](https://play.google.com/store/apps/details?id=app.mineora):
OpenJDK 25.0.4.1 modified by Mineora for Android ARM64. Mineora 1.2.6 (version code 28) to 1.3.1
(version code 35) ship this runtime unchanged.

## Source

The complete corresponding source is attached to release
[`mineora-1.2.7-runtime-v4`](https://github.com/Mineora/mineora-runtime/releases/tag/mineora-1.2.7-runtime-v4):

[Mineora-JVM-25.0.4.1-corresponding-source.zip](https://github.com/Mineora/mineora-runtime/releases/download/mineora-1.2.7-runtime-v4/Mineora-JVM-25.0.4.1-corresponding-source.zip)
(157 MB), SHA-256 `894826fd5e3d472a9be2bc1bd4b8c35a2caf34334fdefa1895fd1dcb0219a532`

It holds the modified OpenJDK source, the sources of FreeType 2.14.3, the DejaVu 2.37 fonts and the
other build dependencies, and the build and packaging scripts, which are also in [`tooling/`](tooling).
GitHub's automatic "Source code" download holds only this repository.

Upstream is OpenJDK [jdk25u `7b65d74`](https://github.com/openjdk/jdk25u/commit/7b65d74bcbd7c3a0b4c1f5c5bd85e64aa2e51b4a);
Mineora's changes are listed in [CHANGES.md](CHANGES.md).

## Licences

OpenJDK is licensed under the GNU General Public License version 2, with the Classpath Exception
where designated; the texts are in [`licenses/`](licenses). Mineora's build and packaging scripts
are under the MIT License; they add the FreeType licence texts in `licenses/` and the notice in
`packaging/` to the runtime. The licences of the other components (FreeType under the FreeType
License, the DejaVu fonts, `posix_spawn`, `tinyiconv`) ship with the runtime in the app and are in
the source ZIP.

This software is based in part on the work of the FreeType Team.
