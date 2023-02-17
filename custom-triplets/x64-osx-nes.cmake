set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_LIBRARY_LINKAGE static)

set(VCPKG_CMAKE_SYSTEM_NAME Darwin)
set(VCPKG_OSX_ARCHITECTURES x86_64)
set(VCPKG_CXX_FLAGS "${VCPKG_CXX_FLAGS} -stdlib=libc++")

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

if (PORT STREQUAL oatpp)
	set(VCPKG_LIBRARY_LINKAGE static)
endif()