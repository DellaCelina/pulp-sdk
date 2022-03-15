function(install_files)
    cmake_parse_arguments(
        ARG
        ""
        "DEST;BASE"
        "FILES"
        ${ARGN}
    )

    foreach(file ${ARG_FILES})
        file(RELATIVE_PATH file_path
            ${ARG_BASE}
            ${file}
        )
        get_filename_component(dir ${file_path} DIRECTORY)
        install(FILES ${file} DESTINATION ${ARG_DEST}/${dir})
    endforeach()
endfunction()