vp_model(
    NAME cluster_ctrl_v2_impl
    DEST pulp/cluster
    SOURCES cluster_ctrl_v2_impl.cpp
)

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