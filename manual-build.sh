#!/bin/bash

if [[ "$1" =~ ^clean$ ]]; then
  rm -rf nes-dependencies-*
  exit
fi

if [ "$1" == "" ] || [ $# -gt 2 ]; then
  echo "Parameters are missing!"
  echo "Allowed parameters: \"clean\" or a triplet"
  echo "Allowed triplets: (x64 || arm64)-(osx || linux)"
  echo "Optional parameters after triplet: version"
  exit
fi

if [[ ! "$1" =~ ^(x64|arm64)-(osx|linux)$ ]]; then
    echo "$1 is not allowed as triplet!"
    exit
fi
triplet=$1
versioned_triplet=$triplet

if [ "$2" != "" ]; then
#   if [[ ! ( "$2" =~ ^v[0-9]*$ ) ]]; then
#     echo "$2 is not an allowed version!"
#     exit
#   fi
  versioned_triplet=$2-$triplet
fi

if ! command -v 7z &> /dev/null
then
    echo "7z could not be found, please install!"
    exit
fi

echo "Chosen triplet: $triplet-nes"
echo "Versioned triplet: $versioned_triplet-nes"

export VCPKG_FEATURE_FLAGS="-binarycaching"
if [[ "$triplet" =~ ^arm64.*$ ]]; then
    echo "ARM64 detected, using system binaries..."
    export VCPKG_FORCE_SYSTEM_BINARIES=1
    if ! command -v ninja &> /dev/null
    then
        echo "ninja could not be found, please install!"
        exit
    fi
fi

# Sometimes this issue appears: https://github.com/microsoft/vcpkg/issues/22812. 
# Setting this variable to true should quickly fix the path resolution error:
vcpkg_path_fix=false

if [ "$vcpkg_path_fix" = true ] ; then
  sed -i '32i string(REPLACE "\:" "" lst "${lst}")' $(dirname $0)/vcpkg/scripts/cmake/vcpkg_host_path_list.cmake
fi

$(dirname $0)/vcpkg/bootstrap-vcpkg.sh -disableMetrics

$(dirname $0)/vcpkg/vcpkg install --triplet="$triplet-nes" --host-triplet="$1-nes" --overlay-triplets=custom-triplets/  --overlay-ports=vcpkg-registry/ports/


mkdir -p $(dirname $0)/nes-dependencies-$versioned_triplet-nes && \
mv $(dirname $0)/vcpkg_installed nes-dependencies-$versioned_triplet-nes/installed && \
mkdir -p $(dirname $0)/nes-dependencies-$versioned_triplet-nes/scripts/buildsystems && \
cp $(dirname $0)/vcpkg/scripts/buildsystems/vcpkg.cmake $(dirname $0)/nes-dependencies-$versioned_triplet-nes/scripts/buildsystems/ && \
touch $(dirname $0)/nes-dependencies-$versioned_triplet-nes/.vcpkg-root && \
7z a nes-dependencies-$versioned_triplet-nes.7z nes-dependencies-$versioned_triplet-nes -mx9 -aoa

# Clean up the fix
if [ "$vcpkg_path_fix" = true ] ; then
  sed -i '32d' $(dirname $0)/vcpkg/scripts/cmake/vcpkg_host_path_list.cmake
fi
