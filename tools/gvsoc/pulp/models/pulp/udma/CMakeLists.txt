if(DEFINED udma/version)
    if(DEFINED udma/spim/version)
        list(APPEND UDMA_CFLAGS -DHAS_SPIM)
        list(APPEND UDMA_SRCS spim/udma_spim_v${udma/spim/version}.cpp)
    endif()

    if(DEFINED udma/cpi/version)
        list(APPEND UDMA_CFLAGS -DHAS_CPI)
        list(APPEND UDMA_SRCS cpi/udma_cpi_v${udma/cpi/version}.cpp)
    endif()

    if(DEFINED udma/i2c/version)
        list(APPEND UDMA_CFLAGS -DHAS_I2C)
        list(APPEND UDMA_SRCS i2c/udma_i2c_v${udma/i2c/version}.cpp)
    endif()

    if(DEFINED udma/hyper/version)
        list(APPEND UDMA_CFLAGS -DHYPER_VERSION=${udma/hyper/version} -DHAS_HYPER)
        list(APPEND UDMA_SRCS hyper/udma_hyper_v${udma/hyper/version}.cpp)
    endif()

    if(DEFINED udma/i2s/version)
        list(APPEND UDMA_CFLAGS -DI2S_VERSION=${udma/i2s/version} -DHAS_I2S)
        list(APPEND UDMA_SRCS i2s/udma_i2s_v${udma/i2s/version}.cpp)
    endif()

    if(DEFINED udma/uart/version)
        list(APPEND UDMA_CFLAGS -DHAS_UART)
        list(APPEND UDMA_SRCS uart/udma_uart_v${udma/uart/version}.cpp)
    endif()

    vp_model(
        NAME udma_v${udma/version}_${pulp_chip_family}_impl
        DEST pulp/udma
        SOURCES
            udma_v${udma/version}_impl.cpp
            ${UDMA_SRCS}
        CFLAGS
            -DUDMA_VERSION=${udma/version}
            ${UDMA_CFLAGS}
    )
endif()