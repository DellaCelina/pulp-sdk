cmake_minimum_required(VERSION 3.5)
project(dpi-models)

set(CMAKE_CXX_STANDARD 11)

set(CMAKE_MODULE_PATH
    ${CMAKE_MODULE_PATH}
    ${CMAKE_CURRENT_SOURCE_DIR}/cmake)

file(GLOB COMMON_SRCS
    src/qspim.cpp
    src/gpio.cpp
    src/jtag.cpp
    src/ctrl.cpp
    src/uart.cpp
    src/cpi.cpp
    src/i2s.cpp
    src/i2c.cpp
    src/telnet_proxy.cpp
)

file(GLOB DPI_SRCS
    src/dpi.cpp
)

file(GLOB PERIPH_SRCS
    src_models.cpp
)

file(GLOB_RECURSE HEADER_FILES
    include/*.hpp
    include/*.h
)

set(INCLUDE_DIRS
    include
    ext/sv/include
    ext/nosv
)

set(CFLAGS -MMD -MP -O3 -g -DUSE_DPI)
set(LDFLAGS -O3 -g -Wl,-export-dynamic -rdynamic)

add_library(pulpperiph SHARED ${PERIPH_SRCS} ${COMMON_SRCS})
target_link_libraries(pulpperiph PUBLIC json)
target_include_directories(pulpperiph PUBLIC ${INCLUDE_DIRS})
target_compile_options(pulpperiph PRIVATE ${CFLAGS})
target_link_options(pulpperiph PRIVATE ${LDFLAGS})

add_library(pulpdpi SHARED ${DPI_SRCS} ${COMMON_SRCS})
target_link_libraries(pulpdpi PUBLIC json pulpperiph)
target_include_directories(pulpdpi
    PUBLIC ${PUBLIC_INCLUDE_DIRS}
    PRIVATE ${PRIVATE_INCLUDE_DIRS}
)
target_compile_options(pulpdpi PRIVATE ${CFLAGS})
target_link_options(pulpdpi PRIVATE ${LDFLAGS})

install(TARGETS pulpperiph pulpdpi DESTINATION lib)

install(
    DIRECTORY include/
    DESTINATION include
    FILES_MATCHING PATTERN "*.hpp;*.h"
)

add_subdirectory(models)