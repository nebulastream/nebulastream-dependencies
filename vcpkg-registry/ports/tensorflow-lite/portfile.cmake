set(VERSION v2.6.0)

#vcpkg_check_linkage(ONLY_STATIC_LIBRARY)

vcpkg_from_github(
        OUT_SOURCE_PATH SOURCE_PATH
        REPO tensorflow/tensorflow
        REF "${VERSION}"
        SHA512 d052da4b324f1b5ac9c904ac3cca270cefbf916be6e5968a6835ef3f8ea8c703a0b90be577ac5205edf248e8e6c7ee8817b6a1b383018bb77c381717c6205e05
        HEAD_REF master
)

vcpkg_cmake_configure(
        SOURCE_PATH "${SOURCE_PATH}/tensorflow/lite/c"
)
vcpkg_cmake_install()

#vcpkg_cmake_config_fixup(CONFIG_PATH lib/cmake/tensorflow)
#
file(COPY ${SOURCE_PATH}/tensorflow/lite/ DESTINATION
        ${CURRENT_PACKAGES_DIR}/include/tensorflow/lite)
#
#file(COPY ${CMAKE_CURRENT_BINARY_DIR}/tensorflow/lite/ DESTINATION
#        ${CURRENT_PACKAGES_DIR}/include/tensorflow/lite)


#if (VCPKG_LIBRARY_LINKAGE STREQUAL dynamic)
#    file(COPY ${CURRENT_PACKAGES_DIR}/libtensorflow_c.a
#            ${CURRENT_PACKAGES_DIR}/debug/lib/libtensorflow_c.a
#            )
#elseif (VCPKG_CMAKE_SYSTEM_NAME STREQUAL Linux)
#    file(COPY ${CURRENT_PACKAGES_DIR}/libtensorflow_c.so
#            ${CURRENT_PACKAGES_DIR}/debug/lib/libtensorflow_c.so
#            )
#else ()
#    file(COPY ${CURRENT_PACKAGES_DIR}/lib/libtensorflow_c.dylib
#            ${CURRENT_PACKAGES_DIR}/debug/lib/libtensorflow_c.dylib
#            )
#endif ()

vcpkg_copy_pdbs()

#file(REMOVE_RECURSE ${CURRENT_PACKAGES_DIR}/debug/include)
file(INSTALL ${SOURCE_PATH}/LICENSE DESTINATION ${CURRENT_PACKAGES_DIR}/share/${PORT} RENAME copyright)