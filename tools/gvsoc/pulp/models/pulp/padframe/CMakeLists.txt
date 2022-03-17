if(DEFINED padframe/version)
    vp_model(
        NAME padframe_v${padframe/version}_impl
        DEST pulp/padframe
        SOURCES padframe_v${padframe/version}_impl.cpp
    )
endif()