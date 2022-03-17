if(DEFINED udma/hyper/version)
    vp_model(
        NAME hyperram_impl
        DEST devices/hyperbus
        SOURCES hyperram_impl.cpp
    )

    vp_model(
        NAME hyperflash_impl
        DEST devices/hyperbus
        SOURCES hyperflash_impl.cpp
    )
endif()