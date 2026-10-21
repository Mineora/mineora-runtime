# Scope, testing and known limitations

## Scope

- The published source matches the runtime in Mineora 1.2.6 (code 28) and 1.2.7 (code 30), which
  ship the same archives. It is not verified corresponding source for any earlier Mineora release.
- The Java compatibility agent, the `statx` shim, the AndroidX graphics-path library and the Playit
  agent are separate components with their own build steps, described in the helpers and Playit
  source ZIPs. The OpenJDK scripts do not build them.

## Recorded test results

The release's own record is `evidence/validation-summary.json` inside
`Mineora-JVM-25.0.4.1-corresponding-source.zip`, dated October 6, 2026, for Mineora 1.2.6. It
records:

- 90 app unit tests, no failures; lint with no errors.
- Load-segment and RELRO alignment checks passed on 72 native ELF objects.
- 222 upgrade-fixture files unchanged after runtime extraction.
- On a Galaxy S22 Ultra: an ATM10 modpack server started, saved and stopped normally after its
  installer ran. Legacy Forge modpacks failed and their import stays blocked.
- Execution on a 16 KB-page device: untested.

The test logs themselves are not published. Build reproduction is described in
[BUILDING.md](BUILDING.md#what-a-rebuild-reproduces).

## Known limits

- Forge launchers that require Java 8 cannot run on this Java 25 runtime.
- Third-party native components that expect desktop Linux, such as some JNA libraries or
  profilers, may not load on Android.

## Security model

Server JARs, plugins and mods imported into Mineora run with the app's own file and network
permissions. There is no sandbox between servers. Only run trusted server software. See
[SECURITY.md](SECURITY.md).
