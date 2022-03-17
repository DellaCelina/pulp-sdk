if(DEFINED udma/uart/version)
    vp_model(
        NAME uart_checker
        DEST devices/uart
        SOURCES uart_checker.cpp
    )
endif()