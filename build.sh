#!/bin/bash

#./vcpkg/bootstrap-vcpkg.sh
outputFileName="nesDebs"
outputDir="."

libs=("z3"
     "boost-system" 
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
     "paho-mqttpp3:x64-linux-dynamic")

for i in "${libs[@]}"; do   # The quotes are necessary here
    ./vcpkg/vcpkg install "$i$postfix" --overlay-triplets=./
done

exports=""
for i in "${libs[@]}"; do   # The quotes are necessary here
    exports="$exports $i$postfix"
done

echo $exports
com="./vcpkg/vcpkg export $exports --overlay-triplets=./ --raw --output-dir=$outputDir --output=$outputFileName"
echo "$com"
eval $com