set(S2_INCLUDE_DIR "${CMAKE_CURRENT_LIST_DIR}/../../include")

add_library(s2::s2 SHARED IMPORTED)

set_target_properties(s2::s2
        PROPERTIES
        IMPORTED_LOCATION ${CMAKE_CURRENT_LIST_DIR}/../../lib/libs2.a
        INTERFACE_INCLUDE_DIRECTORIES "${S2_INCLUDE_DIR}"
        )

set(s2_FOUND TRUE)