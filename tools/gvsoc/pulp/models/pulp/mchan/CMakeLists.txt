if(DEFINED dma/version)
    vp_model(
        NAME mchan_v${dma/version}_impl
        DEST pulp/mchan
        SOURCES mchan_v${dma/version}_impl.cpp
    )
endif()