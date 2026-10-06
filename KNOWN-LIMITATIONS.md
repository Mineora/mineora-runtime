# Runtime scope and known limitations

- The supplied source describes the maintained Android ARM64 runtime used by Mineora 1.2.6. It is not verified corresponding source for every older Mineora release. The source-base revision and installed runtime hashes are recorded in the README and evidence directory.
- A separate clean build passed targeted runtime and Paper startup/save/stop checks. Byte-identical reproduction of the packaged archives is not established. The build recipe ends at the JDK image; final app packaging is described in BUILDING.md.
- The Java compatibility agent, statx shim and AndroidX JNI library are separate components in the helpers source ZIP. They are not built by the OpenJDK recipe. The agent uses pinned ASM 9.10.1.
- Native ELF alignment checks passed. Actual ARM64 execution on a 16 KB-page device and Android 8–10 compatibility remain untested.
- Startup/save/stop checks cover selected Paper, Fabric and NeoForge servers. They do not establish every plugin, mod, server version or multiplayer feature. Older Forge launchers requiring Java 8 are unsupported by this Java 25 integration. Some third-party native JNA/profiler features may not work on Android.
- Imported server code runs with Mineora's app permissions; there is no separate sandbox per server. Only run trusted server JARs, plugins and mods. See SECURITY.md.
