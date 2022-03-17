if(DEFINED ima/version)
    vp_model(
        NAME ima_v${ima/version}_impl
        DEST pulp/ima
        SOURCES ima_v${ima/version}_impl.cpp
        COMPONENTS ima_v${ima/version}.py
    )
endif()