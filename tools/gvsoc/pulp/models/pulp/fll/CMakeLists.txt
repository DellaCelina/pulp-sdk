if(DEFINED fll/version)
    vp_model(
        NAME fll_v${fll/version}_impl
        DEST pulp/fll
        SOURCES fll_v${fll/version}_impl.cpp
    )

    vp_model(
        NAME fll_ctrl_impl
        DEST pulp/fll
        SOURCES fll_ctrl_impl.cpp
    )
endif()