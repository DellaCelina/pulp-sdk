if(DEFINED stdout/version)
    vp_model(
        NAME stdout_v${stdout/version}_impl
        DEST pulp/stdout
        SOURCES stdout_v${stdout/version}_impl.cpp
    )
endif()