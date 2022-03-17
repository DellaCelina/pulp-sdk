set(CMAKE_MODULE_PATH
${CMAKE_MODULE_PATH}
${CMAKE_BINARY_DIR}/cmake)

include(hal_files)
include(hal_src_files)
include(install_files)

set(HEADERS
    hal/pulp.h
    hal/utils.h
    hal/pulp_io.h
    hal/debug_bridge/debug_bridge.h
    hal/gvsoc/gvsoc.h
    hal/tb/tb.h
    ${HAL_FILES}
)

set(SOURCES
    ${HAL_SRC_FILES}
)

foreach(file ${HEADERS})
    list(APPEND HAL_HEADERS ${CMAKE_CURRENT_SOURCE_DIR}/include/${file})
endforeach()

install_files(
    FILES ${HAL_HEADERS}
    DEST pulpos/include
    BASE ${CMAKE_CURRENT_SOURCE_DIR}/include
)

foreach(file ${SOURCES})
    list(APPEND HAL_SOURCES ${CMAKE_CURRENT_SOURCE_DIR}/src/${file})
endforeach()

install_files(
    FILES ${HAL_SOURCES}
    DEST pulpos/src
    BASE ${CMAKE_CURRENT_SOURCE_DIR}/src
)