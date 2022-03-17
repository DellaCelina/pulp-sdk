if(DEFINED cluster/version)
    vp_model(
        NAME l1_interleaver_impl
        DEST pulp/cluster
        SOURCES l1_interleaver_impl.cpp
    )

    vp_model(
        NAME cluster_impl
        DEST pulp/cluster
        SOURCES cluster_impl.cpp
    )
endif()

if(DEFINED cluster_ctrl/version)
    vp_model(
        NAME cluster_ctrl_v${cluster_ctrl/version}_impl
        DEST pulp/cluster
        SOURCES cluster_ctrl_v${cluster_ctrl/version}_impl.cpp
    )
endif()