#!/bin/bash

# load version
source $(dirname $0)/version.sh

# load dependencies
source $(dirname $0)/dependencies-$1.sh

outputFileName="nes-dependencies-v$version-$VCPKG_DEFAULT_TRIPLET"
outputDir="."

for i in "${libs[@]}"; do   # The quotes are necessary here
    $(dirname $0)/vcpkg/vcpkg install "$i" --triplet=$VCPKG_DEFAULT_TRIPLET --overlay-triplets=$(dirname $0)/custom-triplets/
done

exports=""
for i in "${libs[@]}"; do   # The quotes are necessary here
    exports="$exports $i"
done

com="$(dirname $0)/vcpkg/vcpkg export $exports --triplet=$VCPKG_DEFAULT_TRIPLET --overlay-triplets=$(dirname $0)/custom-triplets/ --7zip --output-dir=$outputDir --output=$outputFileName"
echo "Running $com for triplet $VCPKG_DEFAULT_TRIPLET ..."
eval $com