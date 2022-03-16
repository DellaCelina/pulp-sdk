vp_model(
    NAME apb_soc_impl
    DEST pulp/chips/wolfe
    SOURCES apb_soc_impl.cpp
)

install(
    FILES rom.bin
    DESTINATION python/pulp/chips/wolfe
)