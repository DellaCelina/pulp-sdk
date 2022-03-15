file(GLOB VP_SRCS
    src/vp.cpp
    src/trace/trace.cpp
    src/clock/clock.cpp
    src/trace/event.cpp
    src/trace/vcd.cpp
    src/trace/lxt2.cpp
    src/power/power.cpp
    src/trace/lxt2_write.c
    src/trace/fst/fastlz.c
    src/trace/fst/lz4.c
    src/trace/fst/fstapi.c
    src/trace/fst.cpp
    src/trace/raw.cpp
    src/trace/raw/trace_dumper.cpp
)

file(GLOB_RECURSE VP_HEADERS
    include/*.hpp
    include/*.h
)

file(GLOB_RECURSE PYTHON_FILES
    python/*.py
)

set(CFLAGS -MMD -MP -O2 -g -Werror -Wall)
set(LDFLAGS -O2 -g -Werror -Wall -Wl,--whole-archive -Wl,--no-whole-archive)

set(CFLAGS_DBG -DVP_TRACE_ACTIVE=1)
set(CFLAGS_SV -DVP_TRACE_ACTIVE=1 -D__VP_USE_SYSTEMV=1)

set(VP_INCLUDE_DIRS
    include
    src
)

set(VP_LIBRARIES
    z
    json
    dl
    pthread
)

add_library(pulpvp SHARED ${VP_SRCS})
target_include_directories(pulpvp PUBLIC ${VP_INCLUDE_DIRS})
target_link_libraries(pulpvp PUBLIC ${VP_LIBRARIES})
target_compile_options(pulpvp PRIVATE ${CFLAGS})
target_link_options(pulpvp PRIVATE ${LDFLAGS})

add_library(pulpvp-debug SHARED ${VP_SRCS})
target_include_directories(pulpvp-debug PUBLIC ${VP_INCLUDE_DIRS})
target_link_libraries(pulpvp-debug PUBLIC ${VP_LIBRARIES})
target_compile_options(pulpvp-debug PRIVATE ${CFLAGS} ${CFLAGS_DBG})
target_link_options(pulpvp-debug PRIVATE ${LDFLAGS})

add_library(pulpvp-sv SHARED ${VP_SRCS})
target_include_directories(pulpvp-sv PUBLIC ${VP_INCLUDE_DIRS})
target_link_libraries(pulpvp-sv PUBLIC ${VP_LIBRARIES})
target_compile_options(pulpvp-sv PRIVATE ${CFLAGS} ${CFLAGS_SV})
target_link_options(pulpvp-sv PRIVATE ${LDFLAGS})

add_executable(gvsoc_launcher src/main.cpp)
target_link_libraries(gvsoc_launcher PUBLIC pulpvp)
target_compile_options(gvsoc_launcher PRIVATE ${CFLAGS})
target_link_options(gvsoc_launcher PRIVATE ${LDFLAGS})

add_executable(gvsoc_launcher_debug src/main.cpp)
target_link_libraries(gvsoc_launcher_debug PUBLIC pulpvp-debug)
target_compile_options(gvsoc_launcher_debug PRIVATE ${CFLAGS} ${CFLAGS_DBG})
target_link_options(gvsoc_launcher_debug PRIVATE ${LDFLAGS})

install(TARGETS pulpvp pulpvp-debug pulpvp-sv
    DESTINATION lib)

install(TARGETS gvsoc_launcher gvsoc_launcher_debug
    DESTINATION bin)

install_files(
    FILES ${VP_HEADERS}
    BASE ${CMAKE_CURRENT_SOURCE_DIR}/include
    DEST include
)

install_files(
    FILES ${PYTHON_FILES}
    BASE ${CMAKE_CURRENT_SOURCE_DIR}/python
    DEST python
)