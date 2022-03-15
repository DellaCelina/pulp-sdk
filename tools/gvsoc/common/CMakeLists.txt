include(install_files)
file(GLOB BIN_FILES
    bin/*
)

install_files(
    FILES ${BIN_FILES}
    BASE ${CMAKE_CURRENT_SOURCE_DIR}/bin
    DEST bin
)

add_subdirectory(engine)
add_subdirectory(launcher)
add_subdirectory(dpi-wrapper)
add_subdirectory(models)