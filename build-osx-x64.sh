#!/bin/bash

#./vcpkg/bootstrap-vcpkg.sh
export VCPKG_DEFAULT_TRIPLET="x64-osx-nes"
export VCPKG_DEFAULT_HOST_TRIPLET="$VCPKG_DEFAULT_TRIPLET"
version="v1"
outputFileName="nes-dependencies-$version-$VCPKG_DEFAULT_TRIPLET"
outputDir="."
postfix=""
libs=("z3"
"boost-system"
"boost-process"
"boost-thread"
"boost-program-options"
"boost-filesystem"
"boost-chrono"
"zeromq"
"cppzmq"
"log4cxx"
"grpc"
"folly"
"cpprestsdk"
"paho-mqtt"
"paho-mqttpp3" 
"llvm[core,clang,target-x86]")
     

for i in "${libs[@]}"; do   # The quotes are necessary here
    ./vcpkg/vcpkg install "$i$postfix" --host-triplet=x64-linux-nes --triplet=$VCPKG_DEFAULT_TRIPLET --overlay-triplets=./
done

exports=""
for i in "${libs[@]}"; do   # The quotes are necessary here
    exports="$exports $i$postfix"
done

echo $exports
com="./vcpkg/vcpkg export $exports  --host-triplet=$VCPKG_DEFAULT_TRIPLET --triplet$VCPKG_DEFAULT_TRIPLET --overlay-triplets=./ --7zip --output-dir=$outputDir --output=$outputFileName"
echo "$com"
eval $com