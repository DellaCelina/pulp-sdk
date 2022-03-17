if(DEFINED fc_itc/version)
    vp_model(
        NAME itc_v${fc_itc/version}_impl
        DEST pulp/itc
        SOURCES itc_v${fc_itc/version}_impl.cpp
    )
endif()