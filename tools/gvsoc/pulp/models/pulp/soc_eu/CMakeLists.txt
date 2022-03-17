if(DEFINED soc_eu/version)
    vp_model(
        NAME soc_eu_v${soc_eu/version}_impl
        DEST pulp/soc_eu
        SOURCES soc_eu_v${soc_eu/version}_impl.cpp
    )
endif()