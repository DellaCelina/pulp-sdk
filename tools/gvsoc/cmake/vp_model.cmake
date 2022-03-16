function(vp_model)
    cmake_parse_arguments(
        VP
        ""
        "NAME;DEST"
        "SOURCES;INCLUDE_DIRS;LIBRARIES;COMPONENTS;CFLAGS;LDFLAGS"
        ${ARGN})

    find_package(python3)
    set(CFLAGS -MMD -MP -O2 -g -D__GVSOC__=1 -Werror -Wfatal-errors ${python3_INCLUDE_DIRS})
    set(LDFLAGS -O2 -g -Werror -Wfatal-errors)

    set(TARGET ${VP_NAME})
    add_library(${TARGET} SHARED ${VP_SOURCES})
    target_include_directories(${TARGET} PUBLIC ${PULPOS_ARCHI} ${VP_INCLUDE_DIRS})
    target_link_libraries(${TARGET} PUBLIC pulpvp ${VP_LIBRARIES})
    target_compile_options(${TARGET} PRIVATE ${CFLAGS} ${VP_CFLAGS})
    target_link_options(${TARGET} PRIVATE ${LDFLAGS} ${VP_LDFLAGS})

    set(DBG_TARGET ${TARGET}-debug)
    add_library(${DBG_TARGET} SHARED ${VP_SOURCES})
    target_include_directories(${DBG_TARGET} PUBLIC ${PULPOS_ARCHI} ${VP_INCLUDE_DIRS})
    target_link_libraries(${DBG_TARGET} PUBLIC pulpvp-debug ${VP_LIBRARIES})
    target_compile_options(${DBG_TARGET} PRIVATE -DVP_TRACE_ACTIVE=1 ${CFLAGS} ${VP_CFLAGS})
    target_link_options(${DBG_TARGET} PRIVATE ${LDFLAGS} ${VP_LDFLAGS})

    set(SV_TARGET ${TARGET}-sv)
    add_library(${SV_TARGET} SHARED ${VP_SOURCES})
    target_include_directories(${SV_TARGET} PUBLIC ${PULPOS_ARCHI} ${VP_INCLUDE_DIRS})
    target_link_libraries(${SV_TARGET} PUBLIC pulpvp-sv ${VP_LIBRARIES})
    target_compile_options(${SV_TARGET} PRIVATE -DVP_TRACE_ACTIVE=1 ${CFLAGS} ${VP_CFLAGS})
    target_link_options(${SV_TARGET} PRIVATE ${LDFLAGS} ${VP_LDFLAGS})

    install(
        TARGETS ${TARGET} ${DBG_TARGET} ${SV_TARGET}
        DESTINATION lib/${VP_DEST}
    )

    install(
        FILES ${VP_COMPONENTS}
        DESTINATION python/${VP_DEST}
    )
endfunction()