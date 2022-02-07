set(VCPKG_TARGET_ARCHITECTURE arm64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

set(VCPKG_CMAKE_SYSTEM_NAME Linux)


set(VCPKG_CXX_FLAGS_RELEASE -static-libgcc -static-libstdc++)
set(VCPKG_C_FLAGS_RELEASE -static-libgcc -static-libstdc++)
set(VCPKG_LINKER_FLAGS_RELEASE -static-libgcc -static-libstdc++)

if(NOT CMAKE_HOST_SYSTEM_PROCESSOR)
    execute_process(COMMAND "uname" "-m" OUTPUT_VARIABLE CMAKE_HOST_SYSTEM_PROCESSOR OUTPUT_STRIP_TRAILING_WHITESPACE)
endif()

if (PORT STREQUAL Z3)
	set(VCPKG_TARGET_ARCHITECTURE arm)
endif()


if (PORT STREQUAL paho-mqtt)
	set(VCPKG_LIBRARY_LINKAGE static)
endif()

if (PORT STREQUAL eclipse-paho-mqtt-c)
	set(VCPKG_LIBRARY_LINKAGE static)
endif()

if (PORT STREQUAL paho-mqttpp3)
	set(VCPKG_LIBRARY_LINKAGE static)
endif()

if (PORT STREQUAL llvm)
	set(VCPKG_BUILD_TYPE release)
endif()

if (PORT STREQUAL open62541)
    set(VCPKG_POLICY_ALLOW_RESTRICTED_HEADERS enabled)
endif()
