#!/usr/bin/env bash
# Newly authored Mineora build tooling, 2026-10-01. SPDX-License-Identifier: MIT
# See BUILD-TOOLING-LICENSE.txt. Portable recipe derived from the successful isolated audit build; a separate fresh build passed; byte-identical reproduction is not established.
set -euo pipefail
if [[ $# != 6 && $# != 7 ]]; then
 echo 'Usage: build-port.sh patched-source.tar.gz dependency-sources.tar.gz boot-jdk-directory ndk-r27b-directory new-output-directory freetype-2.14.3.tar.xz [native-overlay.tar.gz]' >&2
 exit 2
fi
source_archive=$(realpath "$1")
dependency_archive=$(realpath "$2")
export JAVA_HOME=$(realpath "$3")
ndk_input=$(realpath "$4")
base=$(realpath -m "$5")
test ! -e "$base" || { echo 'Output directory must not already exist' >&2; exit 2; }
test -x "$JAVA_HOME/bin/javac"
test -x "$ndk_input/toolchains/llvm/prebuilt/linux-x86_64/bin/aarch64-linux-android21-clang"
mkdir -p "$base"/{source,dependencies,tools,evidence}
exec > >(tee "$base/evidence/rebuild.log") 2>&1
trap 'printf "FAILED at line %s\n" "$LINENO" > "$base/evidence/status"' ERR
export PATH="$JAVA_HOME/bin:$PATH"
java -version
# Use the supplied trusted source archives. No original harness scripts are run.
tar -xf "$source_archive" -C "$base/source"
if [[ $# == 7 ]]; then
 tar -xf "$7" -C "$base/source"
fi
tar -xf "$dependency_archive" -C "$base/dependencies"
cp -a --reflink=auto "$ndk_input" "$base/tools/android-ndk-r27b"
tar -xf "$6" -C "$base/dependencies"
export TARGET=aarch64-linux-android
export TOOLCHAIN="$base/tools/android-ndk-r27b/toolchains/llvm/prebuilt/linux-x86_64"
export ANDROID_INCLUDE="$TOOLCHAIN/sysroot/usr/include"
export thecc="$TOOLCHAIN/bin/aarch64-linux-android21-clang"
export thecxx="$TOOLCHAIN/bin/aarch64-linux-android21-clang++"
cat > "$base/tools/cc" <<'WRAPPER'
#!/usr/bin/env bash
set -e
if [[ ${1:-} == --version ]]; then
 printf '%s-gcc (GCC) 4.9.0\n' "$TARGET"
 printf 'GCC configure-compatibility marker: Free Software Foundation\n'
 exit 0
fi
args=()
for arg in "$@"; do [[ "$arg" == -fno-var-tracking-assignments ]] || args+=("$arg"); done
exec "$thecc" -Wl,-z,max-page-size=16384 -Wl,-z,common-page-size=16384 -Wno-unused-command-line-argument -Wno-unknown-warning-option "${args[@]}"
WRAPPER
cat > "$base/tools/cxx" <<'WRAPPER'
#!/usr/bin/env bash
set -e
if [[ ${1:-} == --version ]]; then
 printf '%s-g++ (GCC) 4.9.0\n' "$TARGET"
 printf 'GCC configure-compatibility marker: Free Software Foundation\n'
 exit 0
fi
args=()
for arg in "$@"; do [[ "$arg" == -fno-var-tracking-assignments ]] || args+=("$arg"); done
exec "$thecxx" -Wl,-z,max-page-size=16384 -Wl,-z,common-page-size=16384 -Wno-unused-command-line-argument -Wno-unknown-warning-option "${args[@]}"
WRAPPER
chmod +x "$base/tools/cc" "$base/tools/cxx"
export CC="$base/tools/cc" CXX="$base/tools/cxx"
export AR="$TOOLCHAIN/bin/llvm-ar" RANLIB="$TOOLCHAIN/bin/llvm-ranlib"
export OBJCOPY="$TOOLCHAIN/bin/llvm-objcopy" STRIP="$TOOLCHAIN/bin/llvm-strip"
export CXXCPP="$CXX -E"
ln -sfn /usr/include/X11 "$ANDROID_INCLUDE/X11"
ln -sfn /usr/include/fontconfig "$ANDROID_INCLUDE/fontconfig"
ln -sfn "$base/dependencies/cups-2.2.4/cups" "$ANDROID_INCLUDE/cups"
printf 'BUILDING_FREETYPE\n' > "$base/evidence/status"
cd "$base/dependencies/freetype-2.14.3"
CFLAGS="-O2 -fstack-protector-strong -D_FORTIFY_SOURCE=2 -fPIC" LDFLAGS="-Wl,-z,max-page-size=16384 -Wl,-z,common-page-size=16384 -Wl,-z,relro,-z,now" ./configure --host="$TARGET" --prefix="$PWD/install" --without-zlib --with-png=no --with-harfbuzz=no --with-bzip2=no --with-brotli=no
make -j4
make install
mkdir -p "$base/tools/dummy-libs"
for name in pthread rt thread_db; do ar cr "$base/tools/dummy-libs/lib$name.a"; done
printf 'CONFIGURING_OPENJDK\n' > "$base/evidence/status"
cd "$base/source"
flags='-DLE_STANDALONE -O3 -mllvm -polly -DANDROID -fstack-protector-strong -D_FORTIFY_SOURCE=2 -Wno-error=implicit-function-declaration -Wno-error=int-conversion'
bash configure --openjdk-target="$TARGET" --with-boot-jdk="$JAVA_HOME" \
 --with-extra-cflags="$flags" --with-extra-cxxflags="$flags" \
 --with-extra-ldflags="-L$base/tools/dummy-libs -Wl,--undefined-version -Wl,-z,relro,-z,now" \
 --disable-precompiled-headers --disable-warnings-as-errors --enable-option-checking=fatal \
 --enable-headless-only=yes --with-jvm-variants=server \
 --with-jvm-features=-dtrace,-zero,-vm-structs,-epsilongc \
 --with-cups-include="$base/dependencies/cups-2.2.4" --with-devkit="$TOOLCHAIN" \
 --with-native-debug-symbols=external --with-debug-level=release \
 --with-fontconfig-include="$ANDROID_INCLUDE" --x-includes="$ANDROID_INCLUDE/X11" --x-libraries=/usr/lib \
 --with-toolchain-type=gcc --with-freetype-include="$base/dependencies/freetype-2.14.3/install/include/freetype2" \
 --with-freetype-lib="$base/dependencies/freetype-2.14.3/install/lib" \
 OBJCOPY="$OBJCOPY" RANLIB="$RANLIB" AR="$AR" STRIP="$STRIP"
printf '\n# Host tools use GNU bfd, target keeps Android NDK lld.\nJVM_LDFLAGS += -fuse-ld=bfd\n' >> build/linux-aarch64-server-release/buildjdk-spec.gmk
printf 'BUILDING_OPENJDK\n' > "$base/evidence/status"
nice -n 10 make images CONF=linux-aarch64-server-release JOBS=4
printf 'IMAGES_BUILT_PACKAGING_AND_ANDROID_TESTS_PENDING\n' > "$base/evidence/status"
