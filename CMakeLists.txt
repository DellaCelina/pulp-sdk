cmake_minimum_required(VERSION 3.5)
project(sdk)

set(SDK_HOME_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_INSTALL_PREFIX ${SDK_HOME_DIR}/install)
set(CMAKE_MODULE_PATH ${SDK_HOME_DIR}/cmake)

set(PULPOS_ARCHI ${SDK_HOME_DIR}/rtos/pulpos/pulp_archi/include)

add_subdirectory(tools/json-tools)
add_subdirectory(tools/gap-configs)
add_subdirectory(tools/pulp-debug-bridge)
add_subdirectory(tools/dpi-models)
add_subdirectory(tools/gvsoc)