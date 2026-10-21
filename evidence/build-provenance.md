# Build provenance of the shipped runtime

Runtime ID `mineora-openjdk-25.0.4.1-android-integration-20261005-v2`, shipped unchanged in
Mineora 1.2.6 (code 28) and 1.2.7 (code 30). Archive hashes are in `app-runtime-manifest.json`.

## Shipped runtime versus the October 5 clean build

The shipped `bin-arm64.tar.xz` and `universal.tar.xz` were extracted and compared by path and
SHA-256 with the packaged clean build of October 5, 2026. That build was packaged with the steps
`tooling/package-runtime.py package` performs (the script is adapted from the one used then):

| | Files |
|---|---|
| Shipped runtime | 376 |
| Clean build after packaging | 373 |
| Identical path and bytes | 372 |
| Same path, different bytes | 0 |
| Only in the clean build | `lib/src.zip` |
| Only in the shipped runtime | `legal/mineora/FreeType-FTL.TXT`, `FreeType-GPLv2.TXT`, `FreeType-LICENSE.TXT`, `RUNTIME-CHANGES.txt` |

Every runtime file Mineora installs is byte-identical to the clean build. Integration removed
`lib/src.zip` and added four notice files. The shipped `RUNTIME-CHANGES.txt` is kept as shipped in
`packaging/legal-mineora/`.

## Rebuilds

The October 20 and 21, 2026 rebuild results are in [BUILDING.md](../BUILDING.md#what-a-rebuild-reproduces).
