if(DEFINED event_unit/version)
    vp_model(
        NAME eu_v${event_unit/version}_impl
        DEST pulp/event_unit
        SOURCES eu_v${event_unit/version}_impl.cpp
    )
endif()