function(dpi_model)
    cmake_parse_arguments(
        DPI
        ""
        "NAME"
        "SOURCES;INCLUDE_DIRS;LIBRARIES;CFLAGS;LDFLAGS"
        ${ARGN}
    )
    set(CFLAGS -MMD -MP -O2 -g -Werror -Wfatal-errors)
    set(LDFLAGS -O2 -g -Werror -Wfatal-errors)

    add_library(${DPI_NAME} SHARED ${DPI_SOURCES})
    target_compile_options(${DPI_NAME} PRIVATE ${CFLAGS} ${DPI_CFLAGS})
    target_link_options(${DPI_NAME} PRIVATE ${LDFLAGS} ${DPI_LDFLAGS})

    if(EXISTS ${DPI_INCLUDE_DIRS})
        target_include_directories(${DPI_NAME} PUBLIC ${DPI_INCLUDE_DIRS})
    endif()

    target_link_libraries(${DPI_NAME} PUBLIC pulpdpi ${DPI_LIBRARIES})

    install(TARGETS ${DPI_NAME} DESTINATION lib)
endfunction()