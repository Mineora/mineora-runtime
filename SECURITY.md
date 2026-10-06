# Runtime security scope

This repository provides source and build information for Mineora's Android runtime integration. It is not a separate supported desktop Java distribution.

Server JARs, plugins and mods are executable code. Imported code runs with Mineora's file and network permissions. There is no separate sandbox per server. Only run trusted code.

## Reporting an issue

Provide the runtime/server versions, a minimal reproduction and a redacted error description. Do not include credentials, signing keys, full server backups, personal addresses or user worlds in an issue. Contact the maintainer privately before sharing sensitive vulnerability details publicly.

See KNOWN-LIMITATIONS.md for test coverage. Targeted checks do not prove absence of every vulnerability. Runtime or dependency changes require new testing.
