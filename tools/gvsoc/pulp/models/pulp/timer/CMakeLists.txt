if(DEFINED timer/version)
    vp_model(
        NAME timer_v${timer/version}_impl
        DEST pulp/timer
        SOURCES timer_v${timer/version}_impl.cpp
    )
endif()