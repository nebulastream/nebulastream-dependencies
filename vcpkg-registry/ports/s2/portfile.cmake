set(VERSION v0.10.0)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO google/s2geometry
        REF ${VERSION}
        SHA512 04fe955f71b584bca7e492b935ec6061ce1348ff1731797451cdaa538adb88274cb1634d91a844d5d6e3ad0ed11e865322002115d2e746d9a0127f38cabc34e3
        HEAD_REF main
        PATCHES
             0001-change-debug-const-definition.patch
)

vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}"
        OPTIONS
        -DBUILD_EXAMPLES=OFF
)

vcpkg_cmake_install()
vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(COPY ${CMAKE_CURRENT_LIST_DIR}/s2Config.cmake DESTINATION ${CURRENT_PACKAGES_DIR}/share/s2)
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/s2/" RENAME copyright)