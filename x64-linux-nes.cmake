set(VCPKG_TARGET_ARCHITECTURE x64)
set(VCPKG_CRT_LINKAGE dynamic)
set(VCPKG_CMAKE_SYSTEM_NAME Linux)
set(VCPKG_LIBRARY_LINKAGE static)

if (PORT STREQUAL paho-mqtt)
	set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()

if (PORT STREQUAL eclipse-paho-mqtt-c)
	set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()

if (PORT STREQUAL paho-mqttpp3)
	set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()



if (PORT STREQUAL paho-mqttpp3)
	set(VCPKG_LIBRARY_LINKAGE dynamic)
endif()


if (PORT STREQUAL llvm)
	set(VCPKG_BUILD_TYPE release)
endif()

