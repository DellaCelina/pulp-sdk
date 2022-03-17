if(DEFINED gpio/version)
    vp_model(
        NAME gpio_v${gpio/version}_impl
        DEST pulp/gpio
        SOURCES gpio_v${gpio/version}_impl.cpp
    )
endif()