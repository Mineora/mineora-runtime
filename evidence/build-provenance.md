# Build provenance of the shipped runtime

Runtime ID `mineora-openjdk-25.0.4.1-android-integration-20261005-v2`, shipped unchanged in
Mineora 1.2.6 (code 28) and 1.2.7 (code 30). Archive hashes are in `app-runtime-manifest.json`.

## Relation to the clean build

On October 20, 2026 the shipped `bin-arm64.tar.xz` and `universal.tar.xz` were extracted and
compared file by file (SHA-256) against the retained clean build made with `tooling/build-port.sh`
on October 5, 2026 from the published corresponding source, packaged as described in
`BUILDING.md` (debug info, `jmods/`, `include/`, `demo/` and `man/` dropped; FreeType 2.14.3 and
DejaVu 2.37 added; every ELF file passed through termux-elf-cleaner and `llvm-strip`).

| | Files |
|---|---|
| Shipped runtime | 376 |
| Clean build after packaging | 373 |
| Identical path and bytes | 365 |
| Same path, different bytes | 0 |
| Only in the clean build | `lib/src.zip` (removed at integration, as recorded in the manifest) |
| Only in the shipped runtime | `legal/mineora/FreeType-FTL.TXT`, `FreeType-GPLv2.TXT`, `FreeType-LICENSE.TXT`, `RUNTIME-CHANGES.txt` (notices added at integration) |

So every runtime file that Mineora installs is byte-identical to the clean build output; the
integration step only removed `lib/src.zip` and added four notice files before splitting the
tree into the two archives and producing `libjavaexec.so` from `bin/java`.

## Fresh rebuilds

A second build from the same recipe and inputs on a different Linux host is recorded here when
it completes; whether it reproduces the clean build byte for byte is reported in this section
rather than assumed.
