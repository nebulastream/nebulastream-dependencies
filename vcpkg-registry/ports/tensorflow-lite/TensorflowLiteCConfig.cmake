set(tensorflowlite_c_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../include")

set(tensorflowlite_c_INCLUDE_DIRS
        ${tensorflowlite_c_INCLUDE_DIR}
        ${tensorflowlite_c_INCLUDE_DIR}/tensorflow/lite/c
        )

add_library(tensorflowlite_c::tensorflowlite_c SHARED IMPORTED)
set_target_properties(tensorflowlite_c::tensorflowlite_c
        PROPERTIES
        IMPORTED_LOCATION ${CMAKE_CURRENT_LIST_DIR}/../../lib/libtensorflowlite_c.so
        INTERFACE_INCLUDE_DIRECTORIES "${tensorflowlite_c_INCLUDE_DIR}"
        )

set(tensorflowlite_c_FOUND TRUE)