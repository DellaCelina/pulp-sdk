cmake_minimum_required(VERSION 3.5)
project(pulp-debug-bridge)

set(CMAKE_CXX_STANDARD 11)

set(INCLUDE_DIRS
    src
    include
)

set(SRCS
    src/python_wrapper.cpp
    src/cables/jtag.cpp
    src/reqloop.cpp
    src/cables/adv_dbg_itf/adv_dbg_itf.cpp
    src/gdb-server/gdb-server.cpp
    src/gdb-server/rsp.cpp
    src/gdb-server/target.cpp
    src/gdb-server/breakpoints.cpp
    src/cables/jtag-proxy/jtag-proxy.cpp
)

find_package(FTDI REQUIRED)
set(FTDI_CFLAGS ${FTDI_INCLUDE_DIRS})
set(FTDI_LDFLAGS ${FTDI_LIBRARIES})

find_package(SDL2 REQUIRED)
set(SDL2_CFLAGS ${SDL2_INCLUDE_DIRS})
set(SDL2_LDFLAGS ${SDL2_LIBRARIES})

set(CFLAGS -O3 -g -MMD -MP ${FTDI_CFLAGS} ${SDL2_CFLAGS})
set(LDFLAGS -O3 -g ${FTDI_LDFLAGS} ${SDL2_LDFLAGS})

set(TARGET pulpdebugbridge)

add_library(${TARGET} SHARED ${SRCS})

target_include_directories(${TARGET} PUBLIC ${INCLUDE_DIRS})
target_link_libraries(${TARGET} PUBLIC json)

target_compile_options(${TARGET} PRIVATE ${CFLAGS})
target_link_options(${TARGET} PRIVATE ${LDFLAGS})

install(TARGETS ${TARGET} DESTINATION lib)

install(
    DIRECTORY include/
    DESTINATION include
    FILES_MATCHING PATTERN "*.hpp;*.h"
)

install(
    DIRECTORY bin/
    DESTINATION bin
)

install(
    DIRECTORY python/
    DESTINATION python
    FILES_MATCHING PATTERN "*.py"
)