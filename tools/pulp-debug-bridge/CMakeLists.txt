cmake_minimum_required(VERSION 3.5)
project(pulp-debug-bridge)

set(CMAKE_CXX_STANDARD 11)

include(install_files)

file(GLOB_RECURSE HEADER_FILES
    include/*.hpp
    include/*.h
)

file(GLOB_RECURSE BIN_FILES
    bin/*
)

file(GLOB_RECURSE PYTHON_FILES 
    python/*.py
)

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

find_package(FTDI)
set(FTDI_CFLAGS ${FTDI_INCLUDE_DIRS})
set(FTDI_LDFLAGS ${FTDI_LIBRARIES})

find_package(SDL2)
set(SDL2_CFLAGS ${SDL2_INCLUDE_DIRS})
set(SDL2_LDFLAGS ${SDL2_LIBRARIES})

set(CFLAGS -O3 -g -MMD -MP ${FTDI_CFLAGS} ${SDL2_CFLAGS})
set(LDFLAGS -O3 -g ${FTDI_LDFLAGS} ${SDL_LDFLAGS})

set(TARGET pulpdebugbridge)

add_library(${TARGET} SHARED ${SRCS})

target_include_directories(${TARGET} PUBLIC ${INCLUDE_DIRS})
target_link_libraries(${TARGET} PUBLIC json)

target_compile_options(${TARGET} PRIVATE ${CFLAGS})
target_link_options(${TARGET} PRIVATE ${LDFLAGS})

install(TARGETS ${TARGET} DESTINATION lib)

install_files(
    DEST include
    BASE ${CMAKE_CURRENT_SOURCE_DIR}/include
    FILES ${HEADER_FILES}
)

install_files(
    DEST bin
    BASE ${CMAKE_CURRENT_SOURCE_DIR}/bin
    FILES ${BIN_FILES}
)

install_files(
    DEST python
    BASE ${CMAKE_CURRENT_SOURCE_DIR}/python
    FILES ${PYTHON_FILES}
)