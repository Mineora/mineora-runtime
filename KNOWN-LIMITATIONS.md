# Scope, testing and known limitations

## Scope

- The published source matches the runtime in Mineora 1.2.6 (code 28) and 1.2.7 (code 30), which
  ship the same archives. It is not verified corresponding source for any earlier Mineora release.
- `tooling/build-port.sh` builds the JDK image. Packaging that image into the two shipped archives
  is a documented procedure in [BUILDING.md](BUILDING.md), not a one-command script.
- The Java compatibility agent, the `statx` shim, the AndroidX graphics-path library and the Playit
  agent are separate components with their own build steps, described in the helpers and Playit
  source ZIPs. The OpenJDK recipe does not build them.

## What was tested

Runtime built from this source, on a Samsung Galaxy S22 Ultra, October 2026:

- Runtime probes from `probes/` in the JVM ZIP: UTF-8 file and ZIP handling, NIO and child
  processes, instrumentation, headless fonts and PNG output, cryptography.
- Paper, Fabric, NeoForge and Cobblemon servers: startup, world save and normal stop.
- Helper cache update: a modified `mineora-j25shim.jar` of the same size was replaced correctly on
  app start.
- ELF alignment: `PT_LOAD` and RELRO checks passed on all 72 bundled and runtime ELF objects.
- Reproduction: a pinned rebuild on October 20, 2026 reproduced 371 of the 372 runtime files byte
  for byte; the one difference is inside `lib/modules`, in two jpackage launcher resources that
  Mineora does not use. The two shipped `.tar.xz` archives were not themselves regenerated
  byte-identically. See [evidence/build-provenance.md](evidence/build-provenance.md).

## Not tested

- Execution on a device whose kernel uses 16 KB pages. The binaries are aligned for it; only
  4 KB-page devices were used.
- Android 8 to 10. The `statx` shim exists for older kernels but was only exercised on Android 16.
- Every plugin, mod, server version or multiplayer feature. The server checks above are a sample.
  Forge launchers that require Java 8 cannot run on this Java 25 runtime. Third-party native
  components such as JNA or profilers may not work on Android.
- Playit: the 1.2.6 binary passed version and help probes and ELF alignment checks; a fresh
  authenticated public tunnel connection with that exact binary was not part of the recorded tests.

## Security model

Server JARs, plugins and mods imported into Mineora run with the app's own file and network
permissions. There is no sandbox between servers. Only run trusted server software. See
[SECURITY.md](SECURITY.md).
