vcpkg_check_linkage(ONLY_STATIC_LIBRARY)
set(VERSION "5.2.1")

vcpkg_download_distfile(
    ARCHIVE
    URLS "https://github.com/jemalloc/jemalloc/releases/download/${VERSION}/jemalloc-${VERSION}.tar.bz2"
    FILENAME "jemalloc-${VERSION}.tar.bz2"
    SHA512 0bbb77564d767cef0c6fe1b97b705d368ddb360d55596945aea8c3ba5889fbce10479d85ad492c91d987caacdbbdccc706aa3688e321460069f00c05814fae02
)

vcpkg_extract_source_archive_ex(
    OUT_SOURCE_PATH SOURCE_PATH
    ARCHIVE ${ARCHIVE}
)

vcpkg_configure_make(
	SOURCE_PATH "${SOURCE_PATH}"
	AUTOCONF
	)
vcpkg_install_make()

vcpkg_copy_pdbs()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")

file(
	INSTALL "${SOURCE_PATH}/include/" 
	DESTINATION "${CURRENT_PACKAGES_DIR}/include"
)

file(
	INSTALL "${SOURCE_PATH}/COPYING"
	DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}"
	RENAME copyright
)