# Manifest based approach building
Here we keep a manifest file WHEN `vcpkg export` works in manifest mode.

## Why a manifest file?
This approach only requires a single `vcpkg.json` at the root of the project.

We don't need to specify per-triplet dependencies and we can have conditionals in the file.
This simplifies the build and takes care of auto-discovery of host architecture.

## Why does this folder exist?
If the files are left on the root folder, `vcpkg` works by-design in manifest mode and individual commands 
don't work/behave the same. For now, we keep a valid configuration as an
example.