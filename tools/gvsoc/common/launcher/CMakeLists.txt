file(GLOB SOURCES
    src/launcher.cpp
)

file(GLOB HEADERS
    include/*.hpp
    include/*.h
)

set(CFLAGS -MMD -MP -O2 -g -Werror -Wall)
set(LDFLAGS -O2 -g -Werror -Wall -Wl,--whole-archive -Wl,--no-whole-archive)

add_library(pulpvplauncher SHARED ${SOURCES})
target_include_directories(pulpvplauncher PUBLIC include)
target_link_libraries(pulpvplauncher PUBLIC json)
target_compile_options(pulpvplauncher PRIVATE ${CFLAGS})
target_link_options(pulpvplauncher PRIVATE ${LDFLAGS})

install(
    TARGETS pulpvplauncher
    DESTINATION lib
)

install(
    DIRECTORY include/
    DESTINATION include
    FILES_MATCHING PATTERN "*.hpp;*.h"
)