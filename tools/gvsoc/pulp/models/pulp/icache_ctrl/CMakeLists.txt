if(DEFINED icache_ctrl/version)
    vp_model(
        NAME icache_ctrl_v${icache_ctrl/version}_impl
        DEST pulp/icache_ctrl
        SOURCES icache_ctrl_v${icache_ctrl/version}_impl.cpp
    )
endif()