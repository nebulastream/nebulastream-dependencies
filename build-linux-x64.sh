#!/bin/bash

#./vcpkg/bootstrap-vcpkg.sh
export VCPKG_DEFAULT_TRIPLET="x64-linux-nes"
export VCPKG_DEFAULT_HOST_TRIPLET="$VCPKG_DEFAULT_TRIPLET"
version="v3"
outputFileName="nes-dependencies-$version-$VCPKG_DEFAULT_TRIPLET"
outputDir="."
postfix=""
# TODO have a common script to load deps
libs=(
# The LLVM Compiler Infrastructure.
"llvm[core,clang,target-x86]"
# Z3 is a theorem prover from Microsoft Research.
"z3"
# Boost
"boost-system"
"boost-process"
"boost-thread"
"boost-program-options"
"boost-filesystem"
"boost-chrono"
# The ZeroMQ lightweight messaging kernel 
"zeromq"
# lightweight messaging kernel, C++ bindings
"cppzmq"
# Apache log4cxx is a logging framework
"log4cxx"
# An RPC library and framework
"grpc"
# An open-source C++ library developed and used at Facebook. 
"folly"
# C++11 JSON, REST, and OAuth library The C++ REST SDK is a Microsoft
"cpprestsdk"
# An event notification library
"libevent"
# Formatting library for C++. It can be used as a safe alternative to printf or as a fast alternative to IOStreams.
"fmt"
# Paho project provides open-source client implementations of MQTT and MQTT-SN messaging protocols 
"paho-mqtt"
# Paho project provides open-source C++ wrapper for Paho C library
"paho-mqttpp3" 
# kafka lib
"cppkafka"
# jemalloc is a general purpose malloc(3) implementation that emphasizes fragmentation avoidance and scalable concurrency support
"jemalloc"
# An open source, portable, easy to use, readable and flexible SSL library
"mbedtls"
# open62541 is an open source C (C99) implementation of OPC UA licensed under the Mozilla Public License v2.0.
"open62541"
# libsodium is necessary as 3rd-party library
"libsodium"
# template library for linear algebra: matrices, vectors, numerical solvers, and related algorithms
"eigen3"
)
     

for i in "${libs[@]}"; do   # The quotes are necessary here
    ./vcpkg/vcpkg install "$i$postfix" --host-triplet=$VCPKG_DEFAULT_TRIPLET --triplet=$VCPKG_DEFAULT_TRIPLET --overlay-triplets=./
done

exports=""
for i in "${libs[@]}"; do   # The quotes are necessary here
    exports="$exports $i$postfix"
done

echo $exports
com="./vcpkg/vcpkg export $exports  --host-triplet=$VCPKG_DEFAULT_TRIPLET --triplet=$VCPKG_DEFAULT_TRIPLET --overlay-triplets=./ --7zip --output-dir=$outputDir --output=$outputFileName"
echo "$com"
eval $com