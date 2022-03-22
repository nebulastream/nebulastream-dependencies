#!/bin/bash

if [[ "$1" =~ ^clean$ ]]; then
  rm -rf nes-dependencies-*
  exit
fi

if [ "$1" == "" ] || [ $# -gt 1 ]; then
  echo "Parameters are missing!"
  echo "Allowed parameters: \"clean\" or a triplet"
  echo "Allowed triplets: (x64 || arm64)-(osx || linux)"
  exit
fi

if [[ ! "$1" =~ ^(x64|arm64)-(osx|linux)$ ]]; then
    echo "$1 is not allowed as triplet!"
    exit
fi

if ! command -v 7z &> /dev/null
then
    echo "7z could not be found, please install!"
    exit
fi

echo "Chosen triplet: $1-nes"

export VCPKG_FEATURE_FLAGS="-binarycaching"
if [[ "$1" =~ ^arm64.*$ ]]; then
    echo "ARM64 detected, using system binaries..."
    export VCPKG_FORCE_SYSTEM_BINARIES=1
    if ! command -v ninja &> /dev/null
    then
        echo "ninja could not be found, please install!"
        exit
    fi
fi

# Sometimes this issue appears: https://github.com/microsoft/vcpkg/issues/22812. This quick fix here might solve it:
# sed -i '36i elseif("${VCPKG_HOST_PATH_SEPARATOR}" STREQUAL ":")\nset("${out_var}" "${lst}" PARENT_SCOPE)\nstring(FIND "${lst}" [[\\:]] index_of_host_path_separator)' $(dirname $0)/vcpkg/scripts/cmake/vcpkg_host_path_list.cmake

$(dirname $0)/vcpkg/bootstrap-vcpkg.sh -disableMetrics

$(dirname $0)/vcpkg/vcpkg install --triplet="$1-nes" --host-triplet="$1-nes" --overlay-triplets=custom-triplets/   --overlay-ports=vcpkg-registry/ports/


mkdir $(dirname $0)/nes-dependencies-$1-nes && \
mv $(dirname $0)/vcpkg_installed nes-dependencies-$1-nes/installed && \
mkdir -p $(dirname $0)/nes-dependencies-$1-nes/scripts/buildsystems && \
cp $(dirname $0)/vcpkg/scripts/buildsystems/vcpkg.cmake $(dirname $0)/nes-dependencies-$1-nes/scripts/buildsystems/ && \
touch $(dirname $0)/nes-dependencies-$1-nes/.vcpkg-root && \
7z a nes-dependencies-$1-nes.7z nes-dependencies-$1-nes -mx9 -aoa
