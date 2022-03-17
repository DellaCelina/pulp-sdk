set(CMAKE_MODULE_PATH
${CMAKE_MODULE_PATH}
${CMAKE_BINARY_DIR}/cmake)

include(archi_files)
include(install_files)

set(HEADERS
    archi/pulp_defs.h
    archi/pulp.h
    archi/utils.h
    archi/gap_utils.h
    archi/gvsoc/gvsoc.h
    ${ARCHI_FILES}
)

foreach(file ${HEADERS})
    list(APPEND ARCHI_HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/include/${file})
endforeach()

install_files(
    FILES ${ARCHI_HEADERS}
    DEST pulpos/include
    BASE ${CMAKE_CURRENT_SOURCE_DIR}/include
)