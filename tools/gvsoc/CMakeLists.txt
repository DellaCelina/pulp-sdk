cmake_minimum_required(VERSION 3.5)

project(gvsoc)

set(GVSOC_TOP_DIR ${CMAKE_CURRENT_SOURCE_DIR})

set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    ${GVSOC_TOP_DIR}/cmake)

include(vp_model)

add_subdirectory(common)
add_subdirectory(pulp/models)