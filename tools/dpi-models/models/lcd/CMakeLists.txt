find_package(SDL2)

if(EXISTS SDL2_LIBRARIES)
    set(CFLAGS ${SDL2_INCLUDE_DIRS} -D__USE_SDL__)
    set(LDFLAGS ${SDL2_LIBRARIES})
endif()

dpi_model(
    NAME lcd_ili9341
    SOURCES ili9341.cpp
    CFLAGS ${CFLAGS}
    LDFLAGS ${LDFLAGS}
)