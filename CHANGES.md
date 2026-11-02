# Changes from upstream OpenJDK

This is the notice of modification for the OpenJDK source Mineora distributes (GNU GPL version 2,
section 2(a)).

- **Upstream:** OpenJDK [jdk25u `7b65d74`](https://github.com/openjdk/jdk25u/commit/7b65d74bcbd7c3a0b4c1f5c5bd85e64aa2e51b4a), version 25.0.4.1.
- **Modified source:** `source/openjdk-25.0.4.1-android-audit-source.tar.gz` in
  `Mineora-JVM-25.0.4.1-corresponding-source.zip`.
- **Date:** every change below is in the source used for the shipped build of October 5, 2026.
  Earlier dates of individual changes were not recorded. On October 6, 2026 a two-line comment was
  added to `make/modules/java.desktop/lib/ClientLibraries.gmk` in the published copy; it changes no
  build logic.
- **Changed by:** Mineora.

## Files changed

Compared file by file against the upstream archive: 37 modified, 6 added, 1 removed.

Build system:

```
M configure
M make/autoconf/flags-cflags.m4
M make/autoconf/flags-ldflags.m4
M make/autoconf/lib-freetype.m4
M make/autoconf/libraries.m4
M make/autoconf/platform.m4
M make/autoconf/toolchain.m4
M make/common/JdkNativeCompilation.gmk
M make/common/Modules.gmk
M make/common/Utils.gmk
M make/hotspot/lib/JvmOverrideFiles.gmk
M make/modules/java.desktop/Lib.gmk
M make/modules/java.desktop/lib/ClientLibraries.gmk
M make/modules/java.instrument/Lib.gmk
M make/modules/jdk.hotspot.agent/Lib.gmk
M make/modules/jdk.jdwp.agent/Lib.gmk
```

HotSpot:

```
M src/hotspot/cpu/arm/icache_arm.cpp
M src/hotspot/os/linux/gc/z/zNUMA_linux.cpp
M src/hotspot/os/linux/os_linux.cpp
M src/hotspot/os/linux/os_perf_linux.cpp
M src/hotspot/os/posix/os_posix.cpp
M src/hotspot/os_cpu/linux_aarch64/javaThread_linux_aarch64.hpp
M src/hotspot/os_cpu/linux_aarch64/threadLS_linux_aarch64.S
M src/hotspot/os_cpu/linux_arm/linux_arm_32.S
M src/hotspot/os_cpu/linux_arm/os_linux_arm.cpp
M src/hotspot/os_cpu/linux_x86/os_linux_x86.cpp
M src/hotspot/share/utilities/elfFile.hpp
M src/hotspot/share/utilities/globalDefinitions_gcc.hpp
A src/hotspot/os_cpu/linux_arm/fpu_control.h
A src/hotspot/os_cpu/linux_x86/fpu_control.h
```

Class libraries:

```
M src/java.base/unix/classes/sun/net/dns/ResolverConfigurationImpl.java
M src/java.base/unix/native/libjava/java_props_md.c
M src/java.base/unix/native/libjava/jni_util_md.c
M src/java.base/unix/native/libjli/java_md.c
M src/java.base/unix/native/libnet/net_util_md.h
M src/java.base/unix/native/libnio/fs/UnixNativeDispatcher.c
M src/java.desktop/unix/native/libawt/awt/awt_LoadLibrary.c
M src/java.instrument/unix/native/libinstrument/EncodingSupport_md.c
M src/jdk.jdwp.agent/share/native/libjdwp/utf_util.c
A src/java.base/share/classes/sun/launcher/resources/launcher_en.properties
R src/java.base/share/classes/sun/launcher/resources/launcher.properties
A src/java.base/share/native/libtinyiconv/iconv.cpp
A src/java.base/unix/native/libjava/posix_spawn.c
A src/java.base/unix/native/libjava/posix_spawn.h
```

Third-party code in the added files, under its own licence:

- `posix_spawn.c` and `.h`: from Android's dhcpcd compatibility code, Copyright 2006-2012 Roy
  Marples, BSD 2-Clause. Compiled into `libjava`.
- `libtinyiconv/iconv.cpp`: Copyright 2017 The Android Open Source Project, BSD 3-Clause. Compiled
  into `libinstrument` and `libjdwp`.
