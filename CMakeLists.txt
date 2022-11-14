project(nebulastream-dependencies)
cmake_minimum_required(VERSION 3.15)

set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

# CUDA SETUP
find_package(CUDAToolkit REQUIRED)
if(NOT ${CUDAToolkit_FOUND})
    message(FATAL_ERROR "Unable to find CUDAToolkit")
endif ()
enable_language(CUDA)
set(CMAKE_CUDA_STANDARD 14)
set(LIBRARIES ${LIBRARIES} CUDA::cudart CUDA::curand CUDA::cuda_driver)
set(CMAKE_CUDA_FLAGS "-lineinfo")
message("-- CUDA dependencies OK")
include_directories(${CMAKE_CUDA_TOOLKIT_INCLUDE_DIRECTORIES})
target_link_libraries(nebulastream-dependencies PRIVATE CUDA::cudart CUDA::curand CUDA::cuda_driver)

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