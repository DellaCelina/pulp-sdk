cmake_minimum_required(VERSION 3.5)
project(sdk)

set(SDK_HOME_DIR ${CMAKE_CURRENT_SOURCE_DIR})
set(CMAKE_INSTALL_PREFIX ${SDK_HOME_DIR}/install)
set(CMAKE_MODULE_PATH ${SDK_HOME_DIR}/cmake)

set(PULPOS_ARCHI ${SDK_HOME_DIR}/rtos/pulpos/pulp_archi/include)

# build toolchain
add_custom_target(
    toolchain
    COMMAND
        ./configure
        --prefix=${CMAKE_INSTALL_PREFIX}/toolchain
        --with-arch=rv32imc
        --with-cmodel=medlow
    COMMAND make -j4
    WORKING_DIRECTORY ${SDK_HOME_DIR}/toolchain
    COMMENT "Build toolchain"
)

add_subdirectory(cmake)
add_subdirectory(ext)
add_subdirectory(tools)
add_subdirectory(rtos)