file(GLOB SOURCES
    src/dpi.cpp
)

set(CFLAGS -MMD -MP -O3 -g -DUSE_DPI)
set(LDFLAGS -O3 -g)

add_library(gvsocdpi SHARED ${SOURCES})
target_include_directories(gvsocdpi PUBLIC ext/sv/include ext/nosv)
target_link_libraries(gvsocdpi PUBLIC pulpvp-sv json)
target_compile_options(gvsocdpi PRIVATE ${CFLAGS})
target_link_options(gvsocdpi PRIVATE ${LDFLAGS})

install(
    TARGETS gvsocdpi
    DESTINATION lib
)