# Installing NES dependencies
`git clone --recurse-submodules https://github.com/nebulastream/dependencies && ./vcpkg/bootstrap-vcpkg.sh -disableMetrics && install-$OS-$version.sh`

## VCPKG on a new AArch64 system
On a RPi4 w/ 2GB RAM and Ubuntu Server 20.04, we need the following settings, packages, and variables. The list of errors that we see with default settings is below.

### Repo
- use latest vcpkg that has a concurrency setting

### APT/system packages
- build-essential
- pkg-config
- zip/unzip
- cmake from custom repo

### Variables
- `export VCPKG_MAX_CONCURRENCY=1` in `/etc/profiles.d/vcpkg_concurrency.sh`
- `export VCPKG_FORCE_SYSTEM_BINARIES=1` in `/etc/profile.d/vckpg_force_system_binaries.sh`

### Errors (as of 20/08/2021)
- folly: folly only supports x86
- jemalloc: Unknown CMake command "CHECK_C_COMPILER_FLAG"
- llvm: out of memory (maybe better in arm server)
