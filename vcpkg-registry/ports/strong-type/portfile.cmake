
vcpkg_from_github(
    OUT_SOURCE_PATH SOURCE_PATH
    REPO rollbear/strong_type
    REF "v14"
    SHA512 8accb839e52e87d871ef5321e73e93744c174ef01417c5fc2ef2ef692639db5b2cd2286a11aaa3b320d8e485823bd05980267711fa942d60ca496e1ec0a7dc39 
    HEAD_REF 6c6a5bfc1d0972820a4b0ed7cafb19f67153054c
)

vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup(PACKAGE_NAME "strong_type" CONFIG_PATH "lib/cmake")

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/lib" "${CURRENT_PACKAGES_DIR}/debug")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
