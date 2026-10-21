#!/usr/bin/env python3
# Mineora build tooling, October 2026. SPDX-License-Identifier: MIT (licenses/Mineora-MIT-LICENSE.txt)
"""Turn the JDK image built by build-port.sh into the two runtime archives Mineora ships.

  package-runtime.py package   <build-dir> <DejaVu-fonts-2.37.zip> <termux-elf-cleaner> <out-dir>
  package-runtime.py integrate <packaged-dir> <archive-dir>

package: copy the image without jmods/, include/, demo/, man/ and *.debuginfo; add libfreetype.so,
the DejaVu fonts and fontconfig.Linux.properties; run every ELF file through termux-elf-cleaner and
the NDK's llvm-strip; write <out-dir>-hashes.json.
integrate: copy the packaged tree, remove lib/src.zip, add legal/mineora/ (the three FreeType
licence files from licenses/ and packaging/legal-mineora/RUNTIME-CHANGES.txt, the notice as shipped),
and write bin-arm64.tar.xz (ELF files) and universal.tar.xz (everything else).

The October 5, 2026 integration scripts were not kept. This script performs the same steps; it
reproduces the shipped file contents, not byte-identical .tar.xz archives (tar metadata and xz
settings of the originals are not recorded).
"""
from pathlib import Path
import hashlib, json, shutil, subprocess, sys, tarfile, zipfile

def is_elf(p):
    with p.open('rb') as f:
        return f.read(4) == b'\x7fELF'

def hashes(root):
    return {str(p.relative_to(root)): hashlib.sha256(p.read_bytes()).hexdigest()
            for p in sorted(root.rglob('*')) if p.is_file()}

def package(build, dejavu, cleaner, out):
    image = build / 'source/build/linux-aarch64-server-release/images/jdk'
    strip = build / 'tools/android-ndk-r27b/toolchains/llvm/prebuilt/linux-x86_64/bin/llvm-strip'
    for path in (image, dejavu, cleaner, strip):
        if not path.exists():
            sys.exit(f'missing: {path}')
    if out.exists():
        sys.exit(f'{out} already exists')
    shutil.copytree(image, out, symlinks=False,
                    ignore=shutil.ignore_patterns('jmods', 'include', 'demo', 'man', '*.debuginfo'))
    shutil.copy2(build / 'dependencies/freetype-2.14.3/install/lib/libfreetype.so', out / 'lib/libfreetype.so')
    with zipfile.ZipFile(dejavu) as z:
        for name in z.namelist():
            if name.endswith('.ttf') or name == 'LICENSE-DejaVu.txt':
                dest = out / 'lib/fonts' / name
                dest.parent.mkdir(parents=True, exist_ok=True)
                dest.write_bytes(z.read(name))
            elif name == 'fontconfig.Linux.properties':
                (out / 'lib' / name).write_bytes(z.read(name))
    for p in sorted(out.rglob('*')):
        if p.is_file() and is_elf(p):
            subprocess.run([str(cleaner), str(p)], check=True, capture_output=True)
            subprocess.run([str(strip), str(p)], check=True)
    manifest = hashes(out)
    out.with_name(out.name + '-hashes.json').write_text(json.dumps(manifest, indent=2) + '\n')
    print(f'packaged {len(manifest)} files into {out}')

REPO = Path(__file__).resolve().parent.parent
LEGAL = [REPO / 'licenses/FreeType-FTL.TXT', REPO / 'licenses/FreeType-GPLv2.TXT',
         REPO / 'licenses/FreeType-LICENSE.TXT', REPO / 'packaging/legal-mineora/RUNTIME-CHANGES.txt']

def integrate(packaged, archives):
    if archives.exists():
        sys.exit(f'{archives} already exists')
    tree = archives / 'runtime'
    shutil.copytree(packaged, tree, symlinks=False)
    (tree / 'lib/src.zip').unlink(missing_ok=True)
    (tree / 'legal/mineora').mkdir(parents=True, exist_ok=True)
    for f in LEGAL:
        shutil.copy2(f, tree / 'legal/mineora' / f.name)
    files = [p for p in sorted(tree.rglob('*')) if p.is_file()]
    split = {'bin-arm64.tar.xz': [p for p in files if is_elf(p)],
             'universal.tar.xz': [p for p in files if not is_elf(p)]}
    for name, members in split.items():
        with tarfile.open(archives / name, 'w:xz') as t:
            for p in members:
                t.add(p, arcname=str(p.relative_to(tree)), recursive=False)
        print(f'{name}: {len(members)} files')
    (archives / 'runtime-hashes.json').write_text(json.dumps(hashes(tree), indent=2) + '\n')

if __name__ == '__main__':
    if len(sys.argv) == 6 and sys.argv[1] == 'package':
        package(*(Path(a) for a in sys.argv[2:]))
    elif len(sys.argv) == 4 and sys.argv[1] == 'integrate':
        integrate(*(Path(a) for a in sys.argv[2:]))
    else:
        sys.exit(__doc__)
