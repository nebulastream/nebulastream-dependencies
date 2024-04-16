vcpkg_find_acquire_program(GIT)
set(GIT_URL "https://github.com/ls-1801/smallfolly")
set(GIT_REV "29f5a4c267ea7162b6326eda4b75d94ffab5e3d7")

set(SOURCE_PATH ${CURRENT_BUILDTREES_DIR}/src/${PORT})

if(NOT EXISTS "${SOURCE_PATH}/.git")
	message(STATUS "Cloning and fetching submodules")
	vcpkg_execute_required_process(
	  COMMAND ${GIT} clone --recurse-submodules ${GIT_URL} ${SOURCE_PATH}
	  WORKING_DIRECTORY ${CURRENT_BUILDTREES_DIR}
	  LOGNAME clone
	)

	message(STATUS "Checkout revision ${GIT_REV}")
	vcpkg_execute_required_process(
	  COMMAND ${GIT} checkout ${GIT_REV}
	  WORKING_DIRECTORY ${SOURCE_PATH}
	  LOGNAME checkout
	)

	message(STATUS "Applying Patches")
	file(GLOB PATCH_FILES ${SOURCE_PATH}/patches/*)
	vcpkg_execute_required_process(
	  COMMAND /usr/bin/git apply ${PATCH_FILES}
	  WORKING_DIRECTORY ${SOURCE_PATH}/folly
	  LOGNAME patches
	)
endif()


vcpkg_cmake_configure(
    SOURCE_PATH "${SOURCE_PATH}"
    OPTIONS
        ${FEATURE_OPTIONS}
)

vcpkg_cmake_install()
vcpkg_cmake_config_fixup()

file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/include")
file(REMOVE_RECURSE "${CURRENT_PACKAGES_DIR}/debug/share")
# Handle copyright
# file(INSTALL "${SOURCE_PATH}/LICENSE" DESTINATION "${CURRENT_PACKAGES_DIR}/share/${PORT}" RENAME copyright)
