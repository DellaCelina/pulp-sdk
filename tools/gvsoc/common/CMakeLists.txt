install(
    DIRECTORY bin/
    DESTINATION bin
)

add_subdirectory(engine)
add_subdirectory(launcher)
add_subdirectory(dpi-wrapper)
add_subdirectory(models)