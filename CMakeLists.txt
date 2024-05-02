project(nebulastream-dependencies)
cmake_minimum_required(VERSION 2.18)

set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

if(NOT CMAKE_HOST_SYSTEM_PROCESSOR)
    execute_process(COMMAND "uname" "-m" OUTPUT_VARIABLE CMAKE_HOST_SYSTEM_PROCESSOR OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

if (PORT STREQUAL paho-mqtt)
    set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()

if (PORT STREQUAL eclipse-paho-mqtt-c)
    set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()

if (PORT STREQUAL paho-mqttpp3)
    set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()

if (PORT STREQUAL llvm)
    set(VCPKG_BUILD_TYPE release)
endif()