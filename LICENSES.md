# Component licenses

This package has several component licenses. Do not label the whole package MIT.

- OpenJDK: GPL version 2, with the Classpath Exception where designated. Preserve per-file/module notices, ADDITIONAL_LICENSE_INFO and ASSEMBLY_EXCEPTION. Complete applicable corresponding source includes modifications and build/install scripts.
- FreeType: FreeType License (FTL) option used for this package. Preserve the supplied notices and attribution: This software is based in part on the work of the FreeType Team.
- DejaVu fonts: retain the supplied DejaVu/Bitstream font terms and notices.
- Native dependencies and ELF-cleaning tools: retain their own supplied licenses. Consult the dependency archives and files under `licenses/`; do not infer a single license from this summary.
- Newly authored build tooling: MIT only where its supplied BUILD-TOOLING-LICENSE and source headers apply.
- Playit: supplied separately; BSD two-clause upstream notice and its dependency/Rust standard-library notices retained.
- ASM compatibility helper: rebuilt for 1.2.6 from published helper source and pinned ASM 9.10.1; BSD three-clause ASM notice and MIT terms for new helper/tooling retained. Its separate helper source archive contains the build script and matching ASM source.

- AndroidX graphics-path 1.0.1 JNI: Apache License 2.0; pinned release source, original headers, source-origin record and license are in the helpers ZIP.
- Mineora statx shim and newly authored Java helper/build tooling: MIT where the corresponding supplied license/header applies; ASM and AndroidX retain their separate upstream terms.

The separate Kotlin Android app is not automatically relicensed by publishing this runtime source package. This index does not replace any upstream license or certify full compliance. Source access, notice delivery, modification notices and other applicable terms must be checked for the actual distribution.
