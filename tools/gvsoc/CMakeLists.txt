cmake_minimum_required(VERSION 3.5)

project(gvsoc)

set(GVSOC_TOP_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    ${CMAKE_BINARY_DIR}/cmake
    ${GVSOC_TOP_DIR}/cmake)

include(vp_model)
include(props)

add_subdirectory(common)
add_subdirectory(pulp/models)